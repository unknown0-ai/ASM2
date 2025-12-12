package com.example.ASM2_JAV101_TH04864;

import com.example.ASM2_JAV101_TH04864.ConfirmPayment.RepoOrder;
import com.example.ASM2_JAV101_TH04864.Entity.Order;
import com.example.ASM2_JAV101_TH04864.Entity.OrderDetail;

import com.example.ASM2_JAV101_TH04864.RepositoryOrderDetail.RepoOrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/OrderDetail")
public class OrderDetailServlet extends HttpServlet {

    private final RepoOrder orderDAO = new RepoOrder();
    private final RepoOrderDetail orderDetailDAO = new RepoOrderDetail();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(req.getParameter("id"));

            Order order = orderDAO.getOrderById(orderId);
            List<OrderDetail> details = orderDetailDAO.getDetailsByOrderId(orderId);

            if (order == null) {
                req.setAttribute("error", "Không tìm thấy đơn hàng!");
            } else {
                req.setAttribute("order", order);
                req.setAttribute("details", details);
            }

            req.getRequestDispatcher("/WEB-INF/view/OrderDetail.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi tải chi tiết đơn hàng!");
            req.getRequestDispatcher("/WEB-INF/view/OrderDetail.jsp").forward(req, resp);
        }
    }
}
