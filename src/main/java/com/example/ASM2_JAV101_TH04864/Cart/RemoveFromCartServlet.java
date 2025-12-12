package com.example.ASM2_JAV101_TH04864.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/RemoveFromCart")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        List<?> cart = (List<?>) session.getAttribute("cart");

        String indexStr = req.getParameter("index");

        if (cart != null && indexStr != null) {
            try {
                int index = Integer.parseInt(indexStr);
                if (index >= 0 && index < cart.size()) {
                    cart.remove(index);
                    session.setAttribute("cart", cart);
                }
            } catch (NumberFormatException e) {
            }
        }

        resp.sendRedirect(req.getContextPath() + "/Cart");
    }
}
