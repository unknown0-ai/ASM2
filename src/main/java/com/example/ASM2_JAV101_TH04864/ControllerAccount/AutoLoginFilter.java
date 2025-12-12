package com.example.ASM2_JAV101_TH04864.ControllerAccount;

import com.example.ASM2_JAV101_TH04864.Entity.Account;
import com.example.ASM2_JAV101_TH04864.RepositoryAccount.RepoAccount;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/*") // ← Quan trọng: chạy trước mọi request
public class AutoLoginFilter implements Filter {

    private final RepoAccount repoAccount = new RepoAccount();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        // Nếu chưa đăng nhập → mới kiểm tra cookie
        if (session.getAttribute("user") == null) {

            String userIdStr = null;
            String token = null;

            Cookie[] cookies = req.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("userId".equals(c.getName())) {
                        userIdStr = c.getValue();
                    }
                    if ("rememberToken".equals(c.getName())) {
                        token = c.getValue();
                    }
                }
            }

            if (userIdStr != null && token != null) {
                try {
                    int userId = Integer.parseInt(userIdStr);
                    Account account = repoAccount.checkRememberToken(userId, token);

                    if (account != null && account.isActive()) {
                        // Đăng nhập tự động thành công
                        session.setAttribute("user", account);
                        session.setAttribute("username", account.getUsername());
                    } else {
                        // Token sai hoặc tài khoản bị khóa → xóa cookie
                        clearCookies(resp);
                    }
                } catch (NumberFormatException e) {
                    clearCookies(resp);
                }
            }
        }

        chain.doFilter(request, response);
    }

    private void clearCookies(HttpServletResponse resp) {
        Cookie c1 = new Cookie("userId", "");
        c1.setMaxAge(0);
        c1.setPath("/");
        resp.addCookie(c1);

        Cookie c2 = new Cookie("rememberToken", "");
        c2.setMaxAge(0);
        c2.setPath("/");
        resp.addCookie(c2);
    }

    @Override public void init(FilterConfig filterConfig) {}
    @Override public void destroy() {}
}
