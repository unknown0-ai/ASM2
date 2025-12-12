<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 09/12/2025
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Sản Phẩm</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        /* ==== SIDEBAR COPY FROM LIST PAGE ==== */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            padding-left: 80px;    /* Chừa chỗ cho sidebar giống file 1 */
            transition: padding-left 0.4s;
            display: flex;
            align-items: center;
            justify-content: center;
            padding-top: 40px;
        }

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
            border-radius: 8px;
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

        /* ==== FORM STYLE (GIỮ NGUYÊN) ==== */
        .form-container {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(16px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 45px 50px;
            width: 100%;
            max-width: 560px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.7s ease-out;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 35px;
            color: #fff;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            letter-spacing: 1px;
        }

        .input-group {
            position: relative;
            margin: 32px 0;
        }

        .input-group input,
        .input-group select {
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

        .input-group select {
            padding-right: 50px;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 20px center;
            background-size: 12px;
        }

        .input-group label {
            position: absolute;
            top: 50%;
            left: 20px;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.85);
            pointer-events: none;
            transition: all 0.4s;
            font-weight: 500;
        }

        .input-group input:focus ~ label,
        .input-group input:valid ~ label,
        .input-group select:focus ~ label,
        .input-group select ~ label {
            top: -12px;
            left: 15px;
            font-size: 13px;
            background: linear-gradient(to right, #667eea, #764ba2);
            padding: 0 12px;
            border-radius: 10px;
            color: white;
        }

        button {
            width: 100%;
            padding: 18px;
            margin-top: 30px;
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 16px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s;
        }

        button:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 40px rgba(102, 126, 234, 0.7);
        }

        .icon {
            text-align: center;
            font-size: 60px;
            margin-bottom: 20px;
        }

    </style>
</head>
<body>

<!-- ==== SIDEBAR COPY ==== -->
<div class="sidebar">
    <div class="sidebar-header">Menu</div>

    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/Load"><span>Trang Chủ</span></a></li>
        <li><a href="${pageContext.request.contextPath}/Load"><span>Sản Phẩm</span></a></li>
        <li><a href="${pageContext.request.contextPath}/Add"><span>Thêm Sản Phẩm</span></a></li>
        <li><a href="${pageContext.request.contextPath}/Coupon-Load"><span>Coupon</span></a></li>
        <li><a href="${pageContext.request.contextPath}/OrderList"><span>Đơn Hàng</span></a></li>
        <li><a href="${pageContext.request.contextPath}/AccountList"><span>Tài Khoản</span></a></li>
    </ul>
</div>

<div class="form-container">
    <div class="icon"></div>
    <h2>THÊM SẢN PHẨM</h2>

    <form method="post">

        <div class="input-group">
            <input type="text" name="ten" value="${sp.tenSP}" required>
            <label>Tên Sản Phẩm</label>
        </div>

        <div class="input-group">
            <input type="number" name="giaSP" value="${giaNumber}" step="0.01" required>
            <label>Giá Sản Phẩm</label>
        </div>

        <div class="input-group">
            <select name="status" required>
                <c:forEach var="t" items="${trangThai}">
                    <option value="${t}" ${t == (sp.trangthaiSP ? 'Còn' : 'Hết') ? 'selected' : ''}>${t}</option>
                </c:forEach>
            </select>
            <label>Trạng Thái</label>
        </div>

        <div class="input-group">
            <input type="text" name="soluong" value="${sp.soluongSP}" required>
            <label>Số Lượng</label>
        </div>

        <label style="display: block; margin: 25px 0 10px;">Hãng Sản Phẩm</label>
        <div class="radio-group">
            <label><input type="radio" name="hangSP" value="KingStone" ${sp.hangSP == 'KingStone' ? 'checked' : ''}> KingStone</label>
            <label><input type="radio" name="hangSP" value="SamSung" ${sp.hangSP == 'SamSung' ? 'checked' : ''}> SamSung</label>
            <label><input type="radio" name="hangSP" value="Seagate" ${sp.hangSP == 'Seagate' ? 'checked' : ''}> Seagate</label>
        </div>

        <div class="input-group">
            <select name="loaiSP" required>
                <c:forEach var="loai" items="${listType}">
                    <option value="${loai}" ${loai == sp.loaiSP ? 'selected' : ''}>${loai}</option>
                </c:forEach>
            </select>
            <label>Loại Sản Phẩm</label>
        </div>

        <button type="submit" formaction="${pageContext.request.contextPath}/Add">
             THÊM SẢN PHẨM
        </button>
    </form>
</div>

</body>
</html>
