<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Đơn Hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-left: 80px;           /* dành chỗ cho sidebar */
            transition: padding-left 0.4s;
            color: white;
        }

        /* ==================== SIDEBAR ==================== */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 80px;
            height: 100vh;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(10px);
            transition: width 0.4s ease;
            z-index: 1000;
            overflow: hidden;
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.3);
        }

        .sidebar:hover {
            width: 260px;
        }

        .sidebar-header {
            padding: 20px;
            text-align: center;
            color: white;
            font-size: 22px;
            font-weight: 700;
        }

        .sidebar-menu {
            list-style: none;
            margin-top: 20px;
        }

        .sidebar-menu li {
            padding: 18px 25px;
            cursor: pointer;
            transition: background 0.25s ease, transform 0.2s;
        }

        .sidebar-menu li:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateX(5px);
        }

        .sidebar-menu li a {
            text-decoration: none;
            color: white;
            display: flex;
            align-items: center;
            width: 100%;
            font-size: 16px;
        }

        .sidebar-menu li span {
            margin-left: 15px;
            opacity: 0;
            transition: opacity 0.3s;
            white-space: nowrap;
        }

        .sidebar:hover li span {
            opacity: 1;
        }
        /* ================================================ */

        .container {
            max-width: 1200px;
            margin: 40px auto;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(16px);
            border-radius: 28px;
            padding: 50px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4);
        }

        h2 {
            text-align: center;
            font-size: 36px;
            margin-bottom: 40px;
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
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        .view-link {
            background: #4a90e2;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
        }

        .view-link:hover {
            background: #357abd;
        }

        .no-data {
            text-align: center;
            font-size: 20px;
            color: rgba(255, 255, 255, 0.7);
            margin-top: 40px;
        }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="sidebar-header">PM</div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/Load"><span>Trang Chủ</span></a></li>
        <li><a href="${pageContext.request.contextPath}/Load"><span>Sản Phẩm</span></a></li>
        <li><a href="${pageContext.request.contextPath}/Add"><span>Thêm sản phẩm</span></a></li>
        <li><a href="${pageContext.request.contextPath}/Coupon-Load"><span>Coupon</span></a></li>
        <li><a href="${pageContext.request.contextPath}/OrderList"><span>Đơn Hàng</span></a></li>
        <li><a href="${pageContext.request.contextPath}/AccountList"><span>Tài Khoản</span></a></li>
    </ul>
</div>
<!-- END SIDEBAR -->

<div class="container">
    <h2>DANH SÁCH ĐƠN HÀNG</h2>

    <c:if test="${empty orderList}">
        <p class="no-data">Chưa có đơn hàng nào!</p>
    </c:if>

    <c:if test="${not empty orderList}">
        <table>
            <tr>
                <th>Mã Đơn</th>
                <th>Khách Hàng</th>
                <th>Ngày Đặt</th>
                <th>Tổng Tiền</th>
                <th>Trạng Thái</th>
                <th>Action</th>
            </tr>
            <c:forEach items="${orderList}" var="o">
                <tr>
                    <td>#${o.orderId}</td>
                    <td>${o.customerName}</td>
                    <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0"/> VNĐ</td>
                    <td>${o.status}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/OrderDetail?id=${o.orderId}" class="view-link">
                            Xem Chi Tiết
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>

</body>
</html>