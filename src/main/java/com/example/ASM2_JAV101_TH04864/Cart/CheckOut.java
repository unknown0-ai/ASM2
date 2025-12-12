package com.example.ASM2_JAV101_TH04864.Cart;

import com.example.ASM2_JAV101_TH04864.Entity.Coupon;
import com.example.ASM2_JAV101_TH04864.Entity.SanPham;
import com.example.ASM2_JAV101_TH04864.RepositoryCoupon.RepoCoupon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/Checkout")
public class CheckOut extends HttpServlet {

    private final RepoCoupon repoCoupon = new RepoCoupon();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/Cart");
            return;
        }

        // Lấy list coupon còn hạn
        List<Coupon> couponList = repoCoupon.getAllValidCoupons();

        // Tính tổng tiền tạm
        double total = 0;
        for (SanPham sp : cart) {
            total += sp.getGiaSP();
        }

        // Nếu có coupon đã chọn → tính lại
        Coupon selectedCoupon = (Coupon) session.getAttribute("selectedCoupon");
        if (selectedCoupon != null) {
            double discountTotal = 0;
            for (SanPham sp : cart) {
                double price = sp.getGiaSP();
                if (repoCoupon.isApplicable(selectedCoupon, sp.getLoaiSP())) {
                    price *= (1 - selectedCoupon.getDiscount() / 100.0);
                }
                discountTotal += price;
            }
            total = discountTotal;
        }

        req.setAttribute("cart", cart);
        req.setAttribute("couponList", couponList);
        req.setAttribute("selectedCoupon", selectedCoupon);
        req.setAttribute("totalAfterCoupon", total);

        req.getRequestDispatcher("/WEB-INF/view/Checkout.jsp").forward(req, resp);
    }
}