<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
    <h1 class="page-title">DANH SÁCH ACCOUNT</h1>

    <div class="table-container">
        <table class="styled-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>User Name</th>
                <th>Password</th>
                <th>Active</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${AcList}" var="account">
                <tr>
                    <td>${account.id}</td>
                    <td>${account.username}</td>
                    <td class="password-cell">${account.password}</td>
                    <td>
                        <span class="status ${account.active ? 'active' : 'inactive'}">
                                ${account.active ? 'Hoạt động' : 'Không hoạt động'}
                        </span>
                    </td>
                    <td>${account.email}</td>
                    <td>
                        <a href="Account-Delete?id=${account.id}"
                           class="delete-btn"
                           onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?');">
                            Xóa
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <c:if test="${empty AcList}">
            <p class="no-data">Chưa có tài khoản nào!</p>
        </c:if>
    </div>
</div>

<style>
    .container {
        padding: 40px 20px;
        max-width: 1200px;
        margin: 0 auto;
    }

    .page-title {
        font-size: 36px;
        text-align: center;
        margin-bottom: 40px;
        color: white;
        text-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
        font-weight: 700;
        letter-spacing: 1px;
    }

    .table-container {
        background: rgba(255, 255, 255, 0.12);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border-radius: 24px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        padding: 30px;
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
        overflow: hidden;
    }

    .styled-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }

    .styled-table th {
        background: linear-gradient(to right, #667eea, #764ba2);
        color: white;
        padding: 18px;
        text-align: center;
        font-weight: 600;
        font-size: 16px;
    }

    .styled-table td {
        padding: 18px;
        text-align: center;
        color: rgba(255, 255, 255, 0.95);
        background: rgba(255, 255, 255, 0.05);
    }

    .styled-table tr {
        transition: all 0.3s;
    }

    .styled-table tr:hover {
        background: rgba(255, 255, 255, 0.15);
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .styled-table tr:last-child td:first-child {
        border-bottom-left-radius: 20px;
    }

    .styled-table tr:last-child td:last-child {
        border-bottom-right-radius: 20px;
    }

    .delete-btn {
        background: linear-gradient(to right, #e63946, #f15a5f);
        color: white;
        padding: 10px 20px;
        border-radius: 12px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s;
        display: inline-block;
    }

    .delete-btn:hover {
        background: linear-gradient(to right, #f15a5f, #e63946);
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(230, 57, 70, 0.4);
    }

    .status {
        padding: 8px 16px;
        border-radius: 30px;
        font-weight: bold;
        font-size: 14px;
    }

    .status.active {
        background: rgba(72, 187, 120, 0.3);
        color: #48bb78;
    }

    .status.inactive {
        background: rgba(229, 62, 70, 0.3);
        color: #e53e3e;
    }

    .password-cell {
        max-width: 280px;
        word-break: break-all;
        font-family: monospace;
        opacity: 0.8;
        font-size: 13px;
    }

    .no-data {
        text-align: center;
        color: rgba(255, 255, 255, 0.7);
        font-size: 20px;
        margin-top: 40px;
    }
</style>