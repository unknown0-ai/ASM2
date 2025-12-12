<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 08/12/2025
  Time: 10:18 SA
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<fmt:setLocale value="${sessionScope.locale != null ? sessionScope.locale : 'vi'}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="forgot.title" /></title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body{font-family:'Poppins',sans-serif;background:linear-gradient(135deg,#667eea,#764ba2);
            height:100vh;display:flex;align-items:center;justify-content:center;margin:0}
        .box{background:#fff;width:420px;margin:auto;padding:40px;border-radius:16px;
            box-shadow:0 15px 35px rgba(0,0,0,0.2);text-align:center;position:relative}
        input[type=email]{width:100%;padding:14px;border:2px solid #ddd;border-radius:10px;
            font-size:15px;margin:10px 0}
        input[type=email]:focus{border-color:#667eea;outline:none;box-shadow:0 0 0 3px rgba(102,126,234,0.1)}
        button{width:100%;padding:14px;background:#667eea;color:#fff;border:none;border-radius:10px;
            font-size:16px;cursor:pointer}
        .msg{color:#16a34a;background:#f0fff4;padding:12px;border-radius:8px;margin:15px 0}
        .err{color:#c33;background:#fee;padding:12px;border-radius:8px;margin:15px 0}
        a{color:#667eea;margin-top:20px;display:block}

        /* giống reset-password */
        .lang-box{position:absolute; right:12px; top:12px;}
        .lang-box select{padding:6px;border-radius:6px;border:1px solid #ccc;cursor:pointer}
    </style>
</head>

<body>

<div class="box">

    <!-- CHỌN NGÔN NGỮ (giống reset-password.jsp) -->
    <form action="${pageContext.request.contextPath}/setLocale" method="post" class="lang-box">
        <select name="locale" onchange="this.form.submit()">
            <option value="vi" ${sessionScope.locale == 'vi' ? 'selected' : ''}>🇻🇳 VI</option>
            <option value="en" ${sessionScope.locale == 'en' ? 'selected' : ''}>🇺🇸 EN</option>
        </select>
    </form>

    <h2><fmt:message key="forgot.title" /></h2>
    <p><fmt:message key="forgot.desc" /></p>

    <c:if test="${not empty msg}">
        <div class="msg">${msg}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="err">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <input type="email"
               name="email"
               placeholder="<fmt:message key='forgot.email.placeholder' />"
               required
               value="${param.email}"
               autofocus>

        <button type="submit"><fmt:message key="forgot.button" /></button>
    </form>

    <a href="${pageContext.request.contextPath}/login">
        <fmt:message key="forgot.back" />
    </a>
</div>

</body>
</html>
