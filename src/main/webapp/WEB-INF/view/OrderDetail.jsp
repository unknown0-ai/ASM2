<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn hàng #${order.orderId}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 1100px;
            margin: auto;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(16px);
            border-radius: 28px;
            padding: 50px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4);
            color: white;
        }

        h2 {
            text-align: center;
            font-size: 36px;
            margin-bottom: 40px;
            font-weight: 700;
        }

        .order-info {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 40px;
        }

        .order-info p {
            margin: 15px 0;
            font-size: 18px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            overflow: hidden;
        }

        th, td {
            padding: 18px;
            text-align: center;
        }

        th {
            background: rgba(255, 255, 255, 0.2);
            font-weight: 600;
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        .total {
            font-size: 30px;
            font-weight: bold;
            text-align: right;
            margin: 40px 0;
            color: #ffeb3b;
        }

        .back-btn {
            display: block;
            width: 300px;
            margin: 40px auto 0;
            padding: 16px;
            background: #ff9800;
            color: white;
            text-align: center;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
            font-size: 18px;
        }

        .back-btn:hover {
            background: #e68900;
        }

        .error {
            text-align: center;
            color: #ff6b6b;
            font-size: 24px;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>CHI TIẾT ĐƠN HÀNG #${order.orderId}</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <c:if test="${not empty order}">
        <div class="order-info">
            <p><strong>Khách hàng:</strong> ${order.customerName}</p>
            <p><strong>Email:</strong> ${order.customerEmail}</p>
            <p><strong>Số điện thoại:</strong> ${order.customerPhone}</p>
            <p><strong>Ngày đặt hàng:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
            <p><strong>Mã coupon sử dụng:</strong> ${order.couponCode != null ? order.couponCode : 'Không sử dụng'}</p>
            <p><strong>Trạng thái:</strong> <span style="color:#4caf50;font-weight:bold;">${order.status}</span></p>
        </div>

        <h3 style="text-align:center;">DANH SÁCH SẢN PHẨM</h3>
        <table>
            <tr>
                <th>Tên sản phẩm</th>
                <th>Hãng</th>
                <th>Loại</th>
                <th>Giá gốc</th>
                <th>Giá đã giảm</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
            <c:forEach items="${details}" var="d">
                <tr>
                    <td>${d.tenSP}</td>
                    <td>${d.hangSP}</td>
                    <td>${d.loaiSP}</td>
                    <td><fmt:formatNumber value="${d.giaGoc}" pattern="#,##0"/> VNĐ</td>
                    <td><fmt:formatNumber value="${d.giaDaGiam}" pattern="#,##0"/> VNĐ</td>
                    <td>${d.soLuong}</td>
                    <td><fmt:formatNumber value="${d.giaDaGiam * d.soLuong}" pattern="#,##0"/> VNĐ</td>
                </tr>
            </c:forEach>
        </table>

        <div class="total">
            TỔNG THANH TOÁN: <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VNĐ
        </div>

        <a href="${pageContext.request.contextPath}/Load" class="back-btn">QUAY LẠI DANH SÁCH SẢN PHẨM</a>
    </c:if>
</div>

</body>
</html>