<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 08/12/2025
  Time: 11:04 SA
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Cập Nhật Sản Phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border-radius: 28px;
            border: 1px solid rgba(255, 255, 255, 0.25);
            padding: 50px;
            width: 100%;
            max-width: 580px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4);
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            font-size: 34px;
            color: white;
            margin-bottom: 40px;
            font-weight: 700;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        label {
            display: block;
            font-weight: 600;
            color: rgba(255, 255, 255, 0.95);
            margin: 20px 0 8px;
            font-size: 15px;
        }

        input[type=text],
        input[type=number],
        select {
            width: 100%;
            padding: 16px 20px;
            border: none;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.25);
            color: white;
            font-size: 16px;
            outline: none;
            transition: all 0.4s;
        }

        input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        input:focus, select:focus {
            background: rgba(255, 255, 255, 0.35);
            box-shadow: 0 0 30px rgba(255, 255, 255, 0.4);
            transform: scale(1.02);
        }

        /* Radio button đẹp */
        .radio-group {
            display: flex;
            gap: 30px;
            margin: 25px 0;
            justify-content: center;
            flex-wrap: wrap;
        }

        .radio-group label {
            display: flex;
            align-items: center;
            font-size: 16px;
            color: rgba(255, 255, 255, 0.9);
            cursor: pointer;
            transition: 0.3s;
        }

        .radio-group input[type=radio] {
            width: 22px;
            height: 22px;
            margin-right: 10px;
            accent-color: #667eea;
            transform: scale(1.2);
        }

        .radio-group label:hover {
            color: white;
        }

        /* Nút Update đẹp */
        button {
            width: 100%;
            padding: 18px;
            margin-top: 35px;
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 16px;
            font-size: 19px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s;
            box-shadow: 0 12px 30px rgba(102, 126, 234, 0.5);
            letter-spacing: 1px;
        }

        button:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 40px rgba(102, 126, 234, 0.7);
            background: linear-gradient(to right, #764ba2, #667eea);
        }

        .icon {
            text-align: center;
            font-size: 70px;
            margin-bottom: 20px;
        }

        /* Dropdown hiển thị chữ rõ ràng */
        select option {
            background: #2a5298;
            color: white;
            padding: 10px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <div class="icon"></div>
    <h2>CẬP NHẬT SẢN PHẨM</h2>

    <form method="post">

        <label>Mã Sản Phẩm</label>
        <input type="text" name="id" value="${sp.maSP}" readonly style="background:rgba(255,255,255,0.1);">

        <label>Tên Sản Phẩm</label>
        <input type="text" name="ten" value="${sp.tenSP}" required>

        <label>Giá Sản Phẩm</label>
        <fmt:formatNumber value="${sp.giaSP}" pattern="0.##" var="giaNumber"/>
        <input type="number" name="giaSP" value="${giaNumber}" step="0.01" required>

        <label>Trạng Thái Sản Phẩm</label>
        <select name="status" disabled>
            <option value=true ${sp.trangthaiSP ? "selected":""}>Còn Hàng</option>
            <option value=false ${!sp.trangthaiSP ? "selected":""}>Hết Hàng</option>
        </select>

        <label>Số lượng Sản Phẩm</label>
        <input type="text" name="soluong" value="${sp.soluongSP}"  style="background:rgba(255,255,255,0.1);">

        <label>Hãng Sản Phẩm</label>
        <div class="radio-group">
            <label><input type="radio" name="hangSP" value="KingStone" ${sp.hangSP == 'KingStone' ?'checked':''}> KingStone</label>
            <label><input type="radio" name="hangSP" value="SamSung" ${sp.hangSP == 'SamSung'?'checked':''}> SamSung</label>
            <label><input type="radio" name="hangSP" value="Seagate" ${sp.hangSP == 'Seagate'?'checked':''}> Seagate</label>
        </div>

        <label>Loại Sản Phẩm</label>
        <select name="loaiSP" required>
            <c:forEach var="loai" items="${listType}">
                <option value="${loai}" ${loai == sp.loaiSP ? 'selected' : ''}>
                        ${loai}
                </option>
            </c:forEach>
        </select>

        <button type="submit" formaction="${pageContext.request.contextPath}/Update">
            ✔ LƯU THAY ĐỔI
        </button>
    </form>
</div>

</body>
</html>