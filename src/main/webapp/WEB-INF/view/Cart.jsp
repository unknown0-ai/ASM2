<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng & So sánh</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-left: 80px;
            transition: padding-left 0.4s;
            color: white;
        }

        /* ==================== SIDEBAR ==================== */

        .sidebar {
            position: fixed;
            left: 0; top: 0;
            width: 80px;
            height: 100vh;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(10px);
            transition: width 0.4s ease;
            z-index: 1000;
            overflow: hidden;
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.3);
        }
        .sidebar:hover { width: 260px; }
        .sidebar-header {
            padding: 20px;
            text-align: center;
            color: white;
            font-size: 22px;
            font-weight: 700;
        }
        .sidebar-menu { list-style: none; margin-top: 20px; }
        .sidebar-menu li { padding: 18px 25px; transition: all 0.25s; cursor: pointer; }
        .sidebar-menu li:hover { background: rgba(255,255,255,0.25); transform: translateX(5px); }
        .sidebar-menu li a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            font-size: 16px;
        }
        .sidebar-menu li span {
            margin-left: 15px;
            opacity: 0;
            transition: opacity 0.3s;
            white-space: nowrap;
        }
        .sidebar:hover li span { opacity: 1; }
        /* =================================================== */

        .container {
            max-width: 1100px;
            margin: 40px auto;
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(16px);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
        }

        h2 {
            text-align: center;
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 40px;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            overflow: hidden;
        }

        th, td {
            padding: 16px;
            text-align: center;
            color: white;
        }

        th {
            background: rgba(255, 255, 255, 0.2);
            font-weight: 600;
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        .compare-btn {
            background: linear-gradient(to right, #ff9800, #f57c00);
            color: white;
            padding: 14px 40px;
            border: none;
            border-radius: 30px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }
        .compare-btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(255,152,0,0.5);
        }

        .checkout-btn {
            background: linear-gradient(to right, #28a745, #20c997);
            color: white;
            padding: 18px 60px;
            border: none;
            border-radius: 30px;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }
        .checkout-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(40,167,69,0.6);
        }

        .compare-result {
            margin-top: 50px;
            background: rgba(72, 187, 120, 0.2);
            padding: 30px;
            border-radius: 16px;
            border-left: 6px solid #48bb78;
            text-align: center;
            font-size: 18px;
        }
        .compare-result h3 {
            color: #a0eec0;
            margin-bottom: 15px;
            font-size: 26px;
        }

        .delete-link {
            color: #e53e3e;
            font-weight: bold;
            text-decoration: none;
        }
        .delete-link:hover { text-decoration: underline; }

        .checkbox-col { width: 80px; }

        /* Khi giỏ hàng rỗng */
        .empty-cart {
            text-align: center;
            font-size: 22px;
            margin-top: 60px;
            color: rgba(255,255,255,0.8);
        }
        .empty-cart a { color: #ffeb3b; text-decoration: none; }
        .empty-cart a:hover { text-decoration: underline; }
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

<div class="container">
    <h2>GIỎ HÀNG CỦA BẠN</h2>

    <c:if test="${empty cart}">
        <p class="empty-cart">
            Giỏ hàng trống! <a href="${pageContext.request.contextPath}/Load">Tiếp tục mua sắm</a>
        </p>
    </c:if>

    <c:if test="${not empty cart}">
        <form action="${pageContext.request.contextPath}/CompareInCart" method="post">
            <table>
                <tr>
                    <th class="checkbox-col">Chọn so sánh</th>
                    <th>Mã SP</th>
                    <th>Tên</th>
                    <th>Giá</th>
                    <th>Hãng</th>
                    <th>Loại</th>
                    <th>Xóa</th>
                </tr>
                <c:forEach items="${cart}" var="sp" varStatus="status">
                    <tr>
                        <td><input type="checkbox" name="selected" value="${status.index}"></td>
                        <td>${sp.maSP}</td>
                        <td>${sp.tenSP}</td>
                        <td><fmt:formatNumber value="${sp.giaSP}" pattern="#,##0"/> VNĐ</td>
                        <td>${sp.hangSP}</td>
                        <td>${sp.loaiSP}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/RemoveFromCart?index=${status.index}" class="delete-link">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <div style="text-align:center; margin:40px 0;">
                <button type="submit" class="compare-btn">SO SÁNH CÁC SẢN PHẨM ĐÃ CHỌN</button>
            </div>
        </form>

        <div style="text-align:center;">
            <a href="${pageContext.request.contextPath}/Checkout">
                <button class="checkout-btn">TIẾN HÀNH THANH TOÁN</button>
            </a>
        </div>
    </c:if>

    <c:if test="${not empty compareResult}">
        <div class="compare-result">
            <h3>KẾT QUẢ SO SÁNH</h3>
                ${compareResult}
        </div>
    </c:if>
</div>

</body>
</html>