<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- set locale -->
<fmt:setLocale value="${sessionScope.locale != null ? sessionScope.locale : 'vi'}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="reset.title" /></title>

    <!-- Font giống Forgot & OTP -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg,#667eea,#764ba2);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .box {
            background: #fff;
            width: 420px;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            text-align: center;
            position: relative;
        }

        .lang-box {
            position: absolute;
            right: 12px;
            top: 12px;
        }

        .lang-box select {
            padding: 6px;
            border-radius: 6px;
            border: 1px solid #ccc;
            cursor: pointer;
        }

        h2 {
            margin-bottom: 10px;
            font-size: 26px;
            font-weight: 600;
            color: #333;
        }

        input[type=password] {
            width: 100%;
            padding: 14px;
            margin: 10px 0;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 15px;
        }

        input[type=password]:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.15);
        }

        button {
            width: 100%;
            padding: 14px;
            margin-top: 10px;
            background: #667eea;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            color: #fff;
            cursor: pointer;
            font-weight: 600;
        }

        .msg {
            background: #f0fff4;
            color: #16a34a;
            padding: 12px;
            border-radius: 8px;
            margin: 15px 0;
            font-weight: 600;
        }

        .err {
            background: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 8px;
            margin: 15px 0;
            font-weight: 600;
        }
    </style>
</head>

<body>

<div class="box">

    <!-- Language Selector -->
    <form action="${pageContext.request.contextPath}/setLocale" method="post" class="lang-box">
        <select name="locale" onchange="this.form.submit()">
            <option value="vi" ${sessionScope.locale == 'vi' ? 'selected' : ''}>🇻🇳 VI</option>
            <option value="en" ${sessionScope.locale == 'en' ? 'selected' : ''}>🇺🇸 EN</option>
        </select>
    </form>

    <h2><fmt:message key="reset.title" /></h2>

    <c:if test="${not empty msg}">
        <div class="msg">${msg}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="err">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">

        <input type="password"
               name="newPassword"
               placeholder="<fmt:message key='reset.newpass' />"
               required>

        <input type="password"
               name="confirmPassword"
               placeholder="<fmt:message key='reset.confirm' />"
               required>

        <input type="hidden" name="email" value="${sessionScope.resetEmail}">

        <button type="submit"><fmt:message key="reset.button" /></button>
    </form>

</div>

</body>
</html>
