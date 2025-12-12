package com.example.ASM2_JAV101_TH04864.ControllerAccount;
import com.example.ASM2_JAV101_TH04864.Entity.Account;
import com.example.ASM2_JAV101_TH04864.RepositoryAccount.RepoAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet{
    private RepoAccount repoAccount = new RepoAccount();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
        req.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp);
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        Account account = repoAccount.findByUsername(username);

        if (account != null && account.isActive()) {
            try {
                if (repoAccount.verifyPassword(password, account.getPassword())) {
                    HttpSession session = req.getSession();
                    session.setAttribute("user", account);
                    session.setAttribute("username", account.getUsername());

                    if (req.getParameter("remember") != null) {
                        String token = java.util.UUID.randomUUID().toString();
                        repoAccount.updateRememberToken(account.getId(), token);

                        Cookie cId = new Cookie("userId", String.valueOf(account.getId()));
                        Cookie cToken = new Cookie("rememberToken", token);
                        int maxAge = 30 * 24 * 60 * 60; // 30 ngày
                        cId.setMaxAge(maxAge);
                        cToken.setMaxAge(maxAge);
                        cId.setPath("/");
                        cToken.setPath("/");
                        cId.setHttpOnly(true);
                        cToken.setHttpOnly(true);
                        resp.addCookie(cId);
                        resp.addCookie(cToken);
                    }

                    resp.sendRedirect(req.getContextPath() + "/Load");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        req.setAttribute("error", "Invalid credentials");
        doGet(req, resp);

    }
}
