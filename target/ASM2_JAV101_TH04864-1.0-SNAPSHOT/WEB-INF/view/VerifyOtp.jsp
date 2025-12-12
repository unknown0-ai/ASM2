<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Apply Locale -->
<fmt:setLocale value="${sessionScope.locale != null ? sessionScope.locale : 'en'}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="otp.title" /></title>

    <!-- Font giống forgot-password -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg,#667eea,#764ba2);
        }

        .otp-box {
            background: #fff;
            width: 420px;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            text-align: center;
            position: relative;
        }

        /* GIỐNG forgot-password */
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

        p {
            margin-top: 5px;
            margin-bottom: 20px;
            color: #555;
        }

        input[type=text] {
            width: 100%;
            padding: 14px;
            margin: 10px 0;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 18px;
            text-align: center;
        }

        input[type=text]:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.15);
        }

        input[type=submit] {
            width: 100%;
            padding: 14px;
            margin-top: 10px;
            background: #667eea;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            color: #fff;
            cursor: pointer;
            font-weight: 600;
        }

        .err {
            background: #fee;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 12px;
            color: #c33;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="otp-box">

    <form action="${pageContext.request.contextPath}/setLocale" method="post" class="lang-box">
        <select name="locale" onchange="this.form.submit()">
            <option value="vi" ${sessionScope.locale == 'vi' ? 'selected' : ''}>🇻🇳 VI</option>
            <option value="en" ${sessionScope.locale == 'en' ? 'selected' : ''}>🇺🇸 EN</option>
        </select>
    </form>

    <h2><fmt:message key="otp.title" /></h2>
    <p><fmt:message key="otp.desc" /></p>

    <c:if test="${not empty error}">
        <div class="err">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <input type="text" name="otp" maxlength="6"
               placeholder="<fmt:message key='otp.placeholder' />"
               required autofocus>

        <input type="hidden" name="email" value="${sessionScope.resetEmail}">
        <input type="submit" value="<fmt:message key='otp.button' />">
    </form>
</div>

</body>
</html>
