<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<fmt:setLocale value="${sessionScope.locale != null ? sessionScope.locale : 'vi'}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Product Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background: white;
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 420px;
            text-align: center;
            position: relative;
        }
        .logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-size: 36px;
            font-weight: bold;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }
        h2 { font-size: 28px; margin-bottom: 10px; color: #333; }
        p { color: #666; margin-bottom: 30px; font-size: 15px; }

        label { display: block; margin-bottom: 8px; color: #555; font-weight: 600; }
        input[type="text"], input[type="password"] {
            width: 100%; padding: 14px 16px; border: 1px solid #ddd;
            border-radius: 10px; font-size: 16px; transition: border 0.3s;
        }
        input:focus {
            outline: none; border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }

        .remember-me {
            display: flex; align-items: center; justify-content: space-between;
            margin: 20px 0; font-size: 14px;
        }
        .remember-me label {
            display: flex; align-items: center; cursor: pointer; color: #555;
        }

        button {
            width: 100%; padding: 16px;
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white; border: none; border-radius: 10px;
            font-size: 18px; font-weight: 600; cursor: pointer;
            transition: all 0.3s;
        }
        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102,126,234,0.4);
        }

        .error {
            color: #e53e3e; background: #ffebee;
            padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 14px;
        }

        /* Combo Box Ngôn Ngữ */
        .lang-box {
            position: absolute;
            right: 15px;
            top: 15px;
        }

        .lang-box select {
            padding: 6px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            cursor: pointer;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="login-container">

    <!-- COMBO BOX NGÔN NGỮ (GIỐNG OTP / FORGOT / RESET) -->
    <form action="${pageContext.request.contextPath}/setLocale" method="post" class="lang-box">
        <select name="locale" onchange="this.form.submit()">
            <option value="vi" ${sessionScope.locale == 'vi' ? 'selected' : ''}>🇻🇳 VI</option>
            <option value="en" ${sessionScope.locale == 'en' ? 'selected' : ''}>🇺🇸 EN</option>
        </select>
    </form>

    <div class="logo">PM</div>

    <h2><fmt:message key="login.title" /></h2>
    <p><fmt:message key="login.welcome" /></p>

    <!-- FORM LOGIN -->
    <form action="${pageContext.request.contextPath}/login" method="post">

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <label><fmt:message key="login.username" /></label>
        <input type="text" name="username"
               placeholder="<fmt:message key='login.username.placeholder' />" required>

        <label><fmt:message key="login.password" /></label>
        <input type="password" name="password"
               placeholder="<fmt:message key='login.password.placeholder' />" required>
        <div class="remember-me">
            <label>
                <input type="checkbox" name="remember">
                <fmt:message key="login.remember" />
            </label>
            <a href="${pageContext.request.contextPath}/forgot-password"><fmt:message key="login.forgot" /></a>
        </div>

        <button type="submit"><fmt:message key="login.button" /></button>
    </form>
</div>
</body>
</html>
