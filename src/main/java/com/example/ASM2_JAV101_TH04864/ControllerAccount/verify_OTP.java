package com.example.ASM2_JAV101_TH04864.ControllerAccount;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/verify-otp")
public class verify_OTP extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("resetEmail") == null) {
            resp.sendRedirect(req.getContextPath()+"/forgot-password");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/view/VerifyOtp.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String otp   = req.getParameter("otp");

        if (OTPcache.verify(email, otp)) {
            resp.sendRedirect(req.getContextPath()+"/reset-password");
        } else {
            req.setAttribute("error", "Mã OTP không đúng hoặc đã hết hạn!");
            doGet(req, resp);
        }
    }
}
