package com.example.ASM2_JAV101_TH04864.ControllerAccount;

import com.example.ASM2_JAV101_TH04864.Entity.Account;
import com.example.ASM2_JAV101_TH04864.RepositoryAccount.RepoAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AccountList")
public class AccountList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        RepoAccount repoAccount = new RepoAccount();
        List<Account> list = repoAccount.getAll();

        req.setAttribute("AcList", list);

        // truyền thông tin qua layout
        req.setAttribute("title", "Danh Sách Account");
        req.setAttribute("contentPage", "/WEB-INF/view/AccountList.jsp");

        // render layout
        req.getRequestDispatcher("/WEB-INF/view/common/master.jsp")
                .forward(req, resp);
    }
}

