package com.example.ASM2_JAV101_TH04864.Cart;

import com.example.ASM2_JAV101_TH04864.ConfirmPayment.RepoOrder;
import com.example.ASM2_JAV101_TH04864.Entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/OrderList")
public class OrderListServlet extends HttpServlet {

    private final RepoOrder orderDAO = new RepoOrder();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Order> orderList = orderDAO.getAllOrders(); // Hàm lấy tất cả đơn hàng

        req.setAttribute("orderList", orderList);
        req.getRequestDispatcher("/WEB-INF/view/OrderList.jsp").forward(req, resp);
    }
}
