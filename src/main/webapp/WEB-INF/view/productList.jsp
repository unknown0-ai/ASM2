<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 08/12/2025
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #fff;
            padding-left: 80px;
            padding-top: 80px;
            transition: padding-left 0.4s;
        }

        /* ==================== SIDEBAR ==================== */
        .sidebar {
            position: fixed; left: 0; top: 0; width: 80px; height: 100vh;
            background: rgba(0,0,0,0.7); backdrop-filter: blur(10px);
            transition: width .4s ease; z-index: 1000; overflow: hidden;
            box-shadow: 5px 0 15px rgba(0,0,0,.3);
        }
        .sidebar:hover { width: 260px; }
        .sidebar-header { padding: 20px; text-align: center; color: white; font-size: 22px; font-weight: 700; }
        .sidebar-menu { list-style: none; margin-top: 20px; }
        .sidebar-menu li { padding: 18px 25px; cursor: pointer; transition: all .25s; }
        .sidebar-menu li:hover { background: rgba(255,255,255,.25); transform: translateX(5px); }
        .sidebar-menu li a { color: white; text-decoration: none; display: flex; align-items: center; font-size: 16px; }
        .sidebar-menu li span { margin-left: 15px; opacity: 0; transition: opacity .3s; white-space: nowrap; }
        .sidebar:hover li span { opacity: 1; }

        /* ==================== ICON GIỎ HÀNG - ĐƠN GIẢN, NHẸ NHÀNG ==================== */
        .cart-icon {
            position: fixed;
            top: 20px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 999;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 2px solid rgba(255,255,255,0.3);
        }
        .cart-icon:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.1);
        }
        .cart-icon svg {
            width: 24px;
            height: 24px;
            stroke: white;
        }
        .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #e53e3e;
            color: white;
            font-size: 12px;
            font-weight: bold;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .main-content { max-width: 1400px; margin: 0 auto; padding: 20px; }

        h1 {
            text-align: center;
            font-size: 38px;
            margin: 20px 0 50px;
            text-shadow: 0 4px 15px rgba(0,0,0,.4);
            font-weight: 700;
        }

        .filter-form {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(12px);
            padding: 35px;
            border-radius: 20px;
            margin-bottom: 40px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
        }
        .filter-form label { color: white; font-weight: 600; display: block; margin: 18px 0 8px; font-size: 16px; }
        .filter-form select, .filter-form input[type=text] {
            width: 100%; padding: 16px 20px; border: none; border-radius: 14px;
            background: rgba(255,255,255,0.25); color: white; font-size: 16px;
            appearance: none;
        }
        .filter-form select {
            padding-right: 50px;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat; background-position: right 18px center; background-size: 14px;
        }
        .filter-form select option {
            background: #4c51bf !important; color: white !important; padding: 12px;
        }
        .filter-form button {
            margin-top: 30px; width: 100%; padding: 18px;
            background: linear-gradient(to right, #48bb78, #38a169);
            color: white; border: none; border-radius: 14px;
            font-size: 18px; font-weight: 600; cursor: pointer;
        }
        .filter-form button:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(72,187,120,.6);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.1);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
        }
        th {
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white; padding: 20px; text-align: center; font-weight: 600;
        }
        td { padding: 18px; text-align: center; color: white; }
        tr:hover { background: rgba(255,255,255,0.15); }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all .3s;
            min-width: 90px;
            font-size: 14px;
        }
        .btn-update { background: #4a90e2; color: white; }
        .btn-delete { background: #e53e3e; color: white; }
        .btn-cart   { background: #ff9800; color: white; }

        .btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.4);
        }

        .no-data {
            text-align: center;
            color: rgba(255,255,255,0.9);
            font-size: 24px;
            margin-top: 80px;
            font-weight: 500;
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
        <li><a href="${pageContextPath}/Add"><span>Thêm sản phẩm</span></a></li>
        <li><a href="${pageContext.request.contextPath}/Coupon-Load"><span>Coupon</span></a></li>
        <li><a href="${pageContext.request.contextPath}/OrderList"><span>Đơn Hàng</span></a></li>
        <li><a href="${pageContext.request.contextPath}/AccountList"><span>Tài Khoản</span></a></li>
        <li><a href="${pageContext.request.contextPath}/logout"><span>Đăng xuất</span></a></li>
    </ul>
</div>

<!-- ICON GIỎ HÀNG ĐƠN GIẢN, NHẸ NHÀNG -->
<a href="${pageContext.request.contextPath}/Cart" class="cart-icon" title="Giỏ hàng">
    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="9" cy="21" r="1"></circle>
        <circle cx="20" cy="21" r="1"></circle>
        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
    </svg>
    <c:if test="${not empty cart && cart.size() > 0}">
        <span class="cart-count">${cart.size()}</span>
    </c:if>
</a>

<div class="main-content">
    <h1>DANH SÁCH SẢN PHẨM</h1>

    <div class="filter-form">
        <form method="post">
            <label>Loại Sản Phẩm:</label>
            <select name="loaiSP">
                <option value="">-- Tất cả --</option>
                <c:forEach items="${listType}" var="t">
                    <option value="${t}">${t}</option>
                </c:forEach>
            </select>

            <label>Hãng Sản Phẩm:</label>
            <select name="hang">
                <option value="">-- Tất cả --</option>
                <c:forEach items="${hangSP}" var="s">
                    <option value="${s}">${s}</option>
                </c:forEach>
            </select>

            <label>Giá thấp nhất</label>
            <input type="text" name="minprice" placeholder="VD: 10000000">

            <label>Giá cao nhất</label>
            <input type="text" name="maxprice" placeholder="VD: 300000000">

            <button type="submit" formaction="${pageContext.request.contextPath}/Fillter">
                LỌC SẢN PHẨM
            </button>
        </form>
    </div>

    <table>
        <tr>
            <th>Mã Sản Phẩm</th>
            <th>Tên Sản Phẩm</th>
            <th>Giá Sản Phẩm</th>
            <th>Trạng Thái</th>
            <th>Số Lượng</th>
            <th>Hãng</th>
            <th>Loại</th>
            <th>Thao tác</th>
        </tr>
        <c:forEach items="${productList}" var="product">
            <tr>
                <td>${product.maSP}</td>
                <td>${product.tenSP}</td>
                <td><fmt:formatNumber value="${product.giaSP}" pattern="#,##0"/> VNĐ</td>
                <td>${product.isTrangthaiSP() ? "Còn hàng" : "Hết hàng"}</td>
                <td>${product.soluongSP}</td>
                <td>${product.hangSP}</td>
                <td>${product.loaiSP}</td>
                <td>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/Update?id=${product.maSP}">
                            <button class="btn btn-update">Sửa</button>
                        </a>
                        <a href="${pageContext.request.contextPath}/Delete?id=${product.maSP}" onclick="return confirm('Xóa sản phẩm này?')">
                            <button class="btn btn-delete">Xóa</button>
                        </a>
                        <a href="${pageContext.request.contextPath}/AddToCart?maSP=${product.maSP}">
                            <button class="btn btn-cart">Giỏ</button>
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>

    <c:if test="${empty productList}">
        <p class="no-data">Không tìm thấy sản phẩm nào!</p>
    </c:if>
</div>

</body>
</html>