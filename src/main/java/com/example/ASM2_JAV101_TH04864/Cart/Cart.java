package com.example.ASM2_JAV101_TH04864.Cart;

import com.example.ASM2_JAV101_TH04864.Entity.SanPham;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Cart")
public class Cart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
        List<SanPham> cart = (List<SanPham>) req.getSession().getAttribute("cart");
        req.setAttribute("cart",cart!=null?cart:new ArrayList<>());
        req.getRequestDispatcher("/WEB-INF/view/Cart.jsp").forward(req,resp);
    }
}
