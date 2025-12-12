<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            padding-left: 80px;           /* dành chỗ cho sidebar */
            transition: padding-left 0.4s;
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
        .sidebar-menu li { padding: 18px 25px; cursor: pointer; transition: all 0.25s; }
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


        .main-content {
            max-width: 1100px;
            margin: 40px auto;
            padding: 20px;
        }

        .container {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-radius: 28px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 50px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4);
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        h2, h3 {
            text-align: center;
            color: white;
            margin-bottom: 30px;
            font-weight: 700;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }
        h2 { font-size: 36px; }
        h3 { font-size: 24px; }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            overflow: hidden;
        }
        th, td { padding: 16px; text-align: center; color: white; }
        th { background: rgba(255, 255, 255, 0.2); font-weight: 600; }
        tr:hover { background: rgba(255, 255, 255, 0.15); }

        .total {
            font-size: 28px;
            font-weight: bold;
            color: #ffeb3b;
            text-align: right;
            margin: 30px 0;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .coupon-table { margin-top: 50px; }

        .input-group {
            position: relative;
            margin: 30px 0;
        }
        .input-group input,
        .input-group textarea {
            width: 100%;
            padding: 18px 20px;
            border: none;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 16px;
            outline: none;
            transition: all 0.4s;
        }
        .input-group textarea { min-height: 120px; resize: vertical; }
        .input-group input:focus,
        .input-group textarea:focus {
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 30px rgba(255, 255, 255, 0.4);
            transform: scale(1.02);
        }
        .input-group label {
            position: absolute;
            top: 50%;
            left: 20px;
            transform: translateY(-50%);
            color: rgba(255,255,255,0.85);
            font-size: 16px;
            pointer-events: none;
            transition: all 0.4s;
            font-weight: 500;
        }
        .input-group input:focus ~ label,
        .input-group input:valid ~ label,
        .input-group textarea:focus ~ label,
        .input-group textarea:valid ~ label {
            top: -12px;
            left: 15px;
            font-size: 13px;
            background: linear-gradient(to right, #667eea, #764ba2);
            padding: 0 12px;
            border-radius: 10px;
            font-weight: 600;
            color: white;
        }

        .btn {
            width: 100%;
            padding: 18px;
            margin-top: 30px;
            border: none;
            border-radius: 16px;
            font-size: 19px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s;
            box-shadow: 0 12px 30px rgba(0,0,0,0.3);
        }
        .btn-apply { background: linear-gradient(to right, #ff9800, #f57c00); color: white; }
        .btn-pay   { background: linear-gradient(to right, #28a745, #218838); color: white; }
        .btn:hover { transform: translateY(-6px); box-shadow: 0 20px 40px rgba(0,0,0,0.5); }

        .icon {
            text-align: center;
            font-size: 80px;
            margin-bottom: 20px;
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
<!-- END SIDEBAR -->

<div class="main-content">
    <div class="container">
        <div class="icon"></div>
        <h2>THANH TOÁN ĐƠN HÀNG</h2>

        <!-- Danh sách sản phẩm -->
        <h3>Sản phẩm trong giỏ</h3>
        <table>
            <tr>
                <th>Tên</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
            <c:forEach items="${cart}" var="sp">
                <tr>
                    <td>${sp.tenSP}</td>
                    <td><fmt:formatNumber value="${sp.giaSP}" pattern="#,##0"/> VNĐ</td>
                    <td>1</td>
                    <td><fmt:formatNumber value="${sp.giaSP}" pattern="#,##0"/> VNĐ</td>
                </tr>
            </c:forEach>
        </table>

        <!-- Bảng coupon -->
        <div class="coupon-table">
            <h3>Chọn mã giảm giá</h3>
            <form action="${pageContext.request.contextPath}/ApplyCoupon" method="post">
                <table>
                    <tr>
                        <th>Chọn</th>
                        <th>Mã</th>
                        <th>Giảm</th>
                        <th>Áp dụng cho</th>
                        <th>Hết hạn</th>
                    </tr>
                    <c:forEach items="${couponList}" var="c">
                        <tr>
                            <td><input type="radio" name="couponId" value="${c.id}" ${selectedCoupon != null && selectedCoupon.id == c.id ? 'checked' : ''}></td>
                            <td>${c.code}</td>
                            <td>${c.discount}%</td>
                            <td>${c.applyTo}</td>
                            <td><fmt:formatDate value="${c.endDate}" pattern="dd/MM/yyyy"/></td>
                        </tr>
                    </c:forEach>
                </table>
                <button type="submit" class="btn btn-apply">ÁP DỤNG COUPON</button>
            </form>
        </div>

        <!-- Tổng tiền -->
        <div class="total">
            Tổng thanh toán: <strong><fmt:formatNumber value="${totalAfterCoupon}" pattern="#,##0"/> VNĐ</strong>
        </div>

        <!-- Thông tin giao hàng -->
        <h3>Thông tin giao hàng</h3>
        <form action="${pageContext.request.contextPath}/ConfirmPayment" method="post">
            <div class="input-group">
                <input type="text" name="customerName" required>
                <label>Họ tên</label>
            </div>
            <div class="input-group">
                <input type="email" name="customerEmail" required>
                <label>Email</label>
            </div>
            <div class="input-group">
                <input type="text" name="customerPhone" required>
                <label>Số điện thoại</label>
            </div>
            <div class="input-group">
                <textarea name="address" required></textarea>
                <label>Địa chỉ giao hàng</label>
            </div>
            <button type="submit" class="btn btn-pay">XÁC NHẬN THANH TOÁN</button>
        </form>
    </div>
</div>

</body>
</html>