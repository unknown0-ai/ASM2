package com.example.ASM2_JAV101_TH04864.ControllerCuopon;

import com.example.ASM2_JAV101_TH04864.Entity.Coupon;
import com.example.ASM2_JAV101_TH04864.Entity.SanPham;
import com.example.ASM2_JAV101_TH04864.RepositoryCoupon.RepoCoupon;
import com.example.ASM2_JAV101_TH04864.RepositoryProduct.RepoProduct;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ServletCoupon", value = {
        "/ServletCoupon",
        "/Coupon-Load",
        "/ApplyCoupon",
        "/Coupon-Add",
        "/Coupon-delete"
})
public class ServletCoupon extends HttpServlet {
    RepoCoupon repoCoupon = new RepoCoupon();
    RepoProduct repoProduct = new RepoProduct();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.contains("/Coupon-Load")) {
            List<Coupon> List = repoCoupon.getAll();
            String[] typelist = {"Phụ kiện", "Thiết bị"};
            request.setAttribute("ListType", typelist);
            request.setAttribute("List", List);
            request.getRequestDispatcher("/WEB-INF/view/CouponList.jsp").forward(request, response);
        } else if (uri.contains("ApplyTo")) {
            request.getRequestDispatcher("/WEB-INF/view/CouponList.jsp").forward(request, response);
        } else if (uri.contains("/Coupon-Add")) {
            request.getRequestDispatcher("/WEB-INF/view/CouponList.jsp").forward(request, response);
        } else if (uri.contains("/Coupon-delete")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            repoCoupon.delete(id);
            response.sendRedirect(request.getContextPath() + "/Coupon-Load");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("ApplyCoupon")) {
            HttpSession session = request.getSession();
            String couponIdStr = request.getParameter("couponId");

            if (couponIdStr != null && !couponIdStr.isEmpty()) {
                int couponId = Integer.parseInt(couponIdStr);
                Coupon selectedCoupon = repoCoupon.findById(couponId);
                if (selectedCoupon != null) {
                    session.setAttribute("selectedCoupon", selectedCoupon);
                } else {
                    session.removeAttribute("selectedCoupon");
                }
            } else {
                session.removeAttribute("selectedCoupon");
            }

            response.sendRedirect(request.getContextPath() + "/Checkout");
        } else if (uri.contains("Coupon-Add")) {
            try {
                SimpleDateFormat spdf = new SimpleDateFormat("yyyy-MM-dd");
                String code = request.getParameter("code");
                System.out.println(code);
                Integer discount = Integer.parseInt(request.getParameter("discount"));
                String ApplyTo = request.getParameter("applyto");
                if (ApplyTo.equalsIgnoreCase("tất cả sản phẩm")) {
                    ApplyTo = "all";
                }
                Date startdate = spdf.parse(request.getParameter("date"));
                Date enddate = spdf.parse(request.getParameter("endDate"));
                System.out.println(startdate);
                repoCoupon.add(new Coupon(code, discount, startdate, enddate, ApplyTo));
                response.sendRedirect(request.getContextPath() + "/Coupon-Load");
            } catch (ParseException e) {
                e.printStackTrace();
            }

        }
    }
}

