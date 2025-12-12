<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${title}" default="Quản Lý Shop"/></title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            padding-left: 80px;
        }
        .content {
            padding: 40px;
            min-height: 100vh;
        }
    </style>
</head>

<body>

<%@ include file="/WEB-INF/view/common/sidebar.jsp" %>

<div class="content">
    <jsp:include page="${contentPage}" />
</div>

</body>
</html>
