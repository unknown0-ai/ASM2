package com.example.ASM2_JAV101_TH04864.Cart;

import com.example.ASM2_JAV101_TH04864.Entity.SanPham;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/CompareInCart")
public class CompareCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<SanPham> cart = (List<SanPham>) req.getSession().getAttribute("cart");
        String[] selected = req.getParameterValues("selected"); // Lấy tất cả checkbox được chọn

        if (cart == null || selected == null || selected.length < 2) {
            req.setAttribute("compareResult", "Vui lòng chọn ít nhất 2 sản phẩm để so sánh!");
        } else {
            // Lấy 2 sản phẩm đầu tiên được chọn (có thể mở rộng so sánh nhiều hơn)
            int index1 = Integer.parseInt(selected[0]);
            int index2 = Integer.parseInt(selected[1]);

            SanPham sp1 = cart.get(index1);
            SanPham sp2 = cart.get(index2);

            String result = "<strong>So sánh:</strong><br>" +
                    "• " + sp1.getTenSP() + " - Giá: " + fmt(sp1.getGiaSP()) + " VNĐ<br>" +
                    "• " + sp2.getTenSP() + " - Giá: " + fmt(sp2.getGiaSP()) + " VNĐ<br><br>" +
                    "<strong>Kết luận:</strong> " +
                    (sp1.getGiaSP() > sp2.getGiaSP()
                            ? sp1.getTenSP() + " đắt hơn " + fmt(sp1.getGiaSP() - sp2.getGiaSP()) + " VNĐ"
                            : sp2.getTenSP() + " đắt hơn " + fmt(sp2.getGiaSP() - sp1.getGiaSP()) + " VNĐ");

            req.setAttribute("compareResult", result);
        }

        req.getRequestDispatcher("/WEB-INF/view/Cart.jsp").forward(req, resp);
    }

    private String fmt(double price) {
        return new java.text.DecimalFormat("#,##0").format(price);
    }
}
