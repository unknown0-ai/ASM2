package com.example.ASM2_JAV101_TH04864.ControllerAccount;

import com.example.ASM2_JAV101_TH04864.Entity.Account;
import com.example.ASM2_JAV101_TH04864.RepositoryAccount.RepoAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/forgot-password")
public class forgotPassword extends HttpServlet {
    private final RepoAccount repoAccount= new RepoAccount();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/forgotPassword.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email").trim();

        Account acc = repoAccount.findByEmail(email);
        if (acc == null) {
            req.setAttribute("error", "Không tìm thấy tài khoản với email này!");
            doGet(req, resp);
            return;
        }

        String otp = EmailUtil.generateOTP();
        OTPcache.store(email, otp);

        if (EmailUtil.sendOTP(email, otp)) {
            req.getSession().setAttribute("resetEmail", email);
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("error", "Gửi email thất bại. Vui lòng thử lại!");
            doGet(req, resp);
        }
    }
}
