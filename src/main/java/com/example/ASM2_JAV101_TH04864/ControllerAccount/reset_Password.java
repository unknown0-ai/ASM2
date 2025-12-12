package com.example.ASM2_JAV101_TH04864.ControllerAccount;

import com.example.ASM2_JAV101_TH04864.Dbconnector.DbConnector;
import com.example.ASM2_JAV101_TH04864.RepositoryAccount.RepoAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
@WebServlet("/reset-password")
public class reset_Password extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
        if (req.getSession().getAttribute("resetEmail") == null) {
            resp.sendRedirect("login");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/view/resetPassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp);
        String email          = req.getParameter("email");
        String newPass        = req.getParameter("newPassword");
        String confirmPass    = req.getParameter("confirmPassword");

        if (!newPass.equals(confirmPass)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            doGet(req, resp);
            return;
        }

        try (Connection conn = DbConnector.getConnection()) {
            RepoAccount accountDAO = new RepoAccount();
            String hashed = accountDAO.hashPassword(newPass);
            String sql = "UPDATE Account SET Password = ? WHERE Email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, hashed);
            ps.setString(2, email);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                req.getSession().removeAttribute("resetEmail");
                req.setAttribute("msg", "Đặt lại mật khẩu thành công! Bạn có thể đăng nhập ngay.");
                req.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Cập nhật thất bại!");
                doGet(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống!");
            doGet(req, resp);
        }
    }
    }

