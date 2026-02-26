package com.example.ASM2_JAV101_TH04864.ConfirmPayment;

import com.example.ASM2_JAV101_TH04864.Dbconnector.DbConnector;
import com.example.ASM2_JAV101_TH04864.Entity.Coupon;
import com.example.ASM2_JAV101_TH04864.Entity.Order;
import com.example.ASM2_JAV101_TH04864.Entity.OrderDetail;
import com.example.ASM2_JAV101_TH04864.Entity.SanPham;
import com.example.ASM2_JAV101_TH04864.RepositoryCoupon.RepoCoupon;
import com.example.ASM2_JAV101_TH04864.RepositoryProduct.RepoProduct;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/ConfirmPayment")
public class ConfirmPaymentServlet extends HttpServlet {
    private final RepoOrder orderDAO = new RepoOrder();
    private final RepoProduct repoProduct = new RepoProduct();
    private final RepoCoupon repoCoupon = new RepoCoupon();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
        Coupon selectedCoupon = (Coupon) session.getAttribute("selectedCoupon");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/Cart");
            return;
        }

        String customerName = req.getParameter("customerName");
        String customerEmail = req.getParameter("customerEmail");
        String customerPhone = req.getParameter("customerPhone");

        try (Connection conn = DbConnector.getConnection()) {
            conn.setAutoCommit(false); // Transaction

            double totalAmount = 0;
            for (SanPham sp : cart) {
                double price = sp.getGiaSP();
                if (selectedCoupon != null && repoCoupon.isApplicable(selectedCoupon, sp.getLoaiSP())) {
                    price *= (1 - selectedCoupon.getDiscount() / 100.0);
                }
                totalAmount += price;
            }

            Order order = new Order(customerName, customerEmail, customerPhone, totalAmount, selectedCoupon != null ? selectedCoupon.getCode() : null);
            int orderId = orderDAO.addOrder(order);

            if (orderId == -1) {
                throw new Exception("Lỗi tạo đơn hàng");
            }

            for (SanPham sp : cart) {
                double price = sp.getGiaSP();
                double giaDaGiam = price;
                if (selectedCoupon != null && repoCoupon.isApplicable(selectedCoupon, sp.getLoaiSP())) {
                    giaDaGiam *= (1 - selectedCoupon.getDiscount() / 100.0);
                }

                OrderDetail detail = new OrderDetail(orderId, sp.getMaSP(), 1, price, giaDaGiam);
                orderDAO.addOrderDetail(detail);

                repoProduct.buy(sp.getMaSP(), 1); // Giảm số lượng tồn kho
            }

            conn.commit();

            session.removeAttribute("cart");
            session.removeAttribute("selectedCoupon");

            
            resp.sendRedirect(req.getContextPath() + "/Load");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Thanh toán thất bại: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/Checkout.jsp").forward(req, resp);
        }
    }
}
