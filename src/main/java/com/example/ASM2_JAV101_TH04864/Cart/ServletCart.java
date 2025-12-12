package com.example.ASM2_JAV101_TH04864.Cart;

import com.example.ASM2_JAV101_TH04864.Entity.SanPham;
import com.example.ASM2_JAV101_TH04864.RepositoryProduct.RepoProduct;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AddToCart")
public class ServletCart extends HttpServlet {

    private final RepoProduct repoProduct = new RepoProduct();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int maSP = Integer.parseInt(req.getParameter("maSP"));
        SanPham sp = repoProduct.findById(maSP);

        if (sp == null) {
            req.getSession().setAttribute("msg", "Sản phẩm không tồn tại!");
        } else {
            // Lấy giỏ hàng từ Session (nếu chưa có thì tạo mới)
            HttpSession session = req.getSession();
            List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
            }

            cart.add(sp);
            session.setAttribute("cart", cart);

            session.setAttribute("msg", "Đã thêm " + sp.getTenSP() + " vào giỏ hàng!");
        }

        // Quay lại trang danh sách
        resp.sendRedirect(req.getContextPath() + "/Load");
    }
}