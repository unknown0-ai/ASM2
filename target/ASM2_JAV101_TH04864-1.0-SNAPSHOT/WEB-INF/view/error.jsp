<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ff416c, #ff4b2b);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            margin: 0;
        }

        .error-box {
            background: rgba(255, 255, 255, 0.15);
            padding: 40px;
            border-radius: 20px;
            text-align: center;
            width: 420px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        h1 {
            font-size: 28px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        p {
            font-size: 18px;
            margin-bottom: 25px;
        }

        a {
            text-decoration: none;
        }

        .btn-back {
            padding: 12px 20px;
            border-radius: 12px;
            border: none;
            background: white;
            color: #ff416c;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.25s;
        }

        .btn-back:hover {
            background: #ffe8ee;
        }
    </style>
</head>
<body>

<div class="error-box">
    <h1>❌ Lỗi</h1>

    <p>${error}</p>

    <a href="${pageContext.request.contextPath}/Load">
        <button class="btn-back">Quay về trang sản phẩm</button>
    </a>
</div>

</body>
</html>
