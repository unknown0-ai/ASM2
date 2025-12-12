package com.example.ASM2_JAV101_TH04864.ControllerAccount;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class Logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.invalidate();

        // Xóa cookie remember me
        Cookie c1 = new Cookie("userId", "");
        c1.setMaxAge(0);
        c1.setPath("/");
        resp.addCookie(c1);

        Cookie c2 = new Cookie("rememberToken", "");
        c2.setMaxAge(0);
        c2.setPath("/");
        resp.addCookie(c2);

        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
