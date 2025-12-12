<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 09/12/2025
  Time: 1:41 CH
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

    <title>Danh Sách Coupon</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
            padding: 40px 20px;
            color: #333;
        }

        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
            justify-content: center;
            align-items: flex-start;
        }

        /* Form thêm coupon bên trái */
        .add-form {
            flex: 1;
            min-width: 400px;
            max-width: 500px;
            background: white;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .add-form h2 {
            text-align: center;
            color: #5a67d8;
            margin-bottom: 30px;
            font-size: 26px;
        }

        .add-form label {
            display: block;
            margin: 18px 0 8px;
            font-weight: 600;
            color: #4c51bf;
        }

        .add-form input[type=text],
        .add-form input[type=number],
        .add-form input[type=date],
        .add-form select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s;
        }

        .add-form input:focus,
        .add-form select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
            outline: none;
        }

        .add-form button {
            width: 100%;
            padding: 14px;
            margin-top: 25px;
            background: linear-gradient(to right, #48bb78, #38a169);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .add-form button:hover {
            background: linear-gradient(to right, #38a169, #2f855a);
            transform: translateY(-2px);
        }

        /* Bảng danh sách bên phải */
        .coupon-table {
            flex: 2;
            min-width: 600px;
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .coupon-table h2 {
            text-align: center;
            color: #5a67d8;
            margin-bottom: 25px;
            font-size: 26px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th {
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: 600;
        }

        td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #e2e8f0;
        }

        tr:hover {
            background-color: #f8f9ff;
        }

        tr:nth-child(even) {
            background-color: #fdfbfe;
        }

        /* Nút Delete đẹp */
        .btn-delete {
            background: #e53e3e;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn-delete:hover {
            background: #c53030;
            transform: translateY(-2px);
        }

        @media (max-width: 992px) {
            .main-container {
                flex-direction: column;
                align-items: center;
            }
            .add-form, .coupon-table {
                min-width: 100%;
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/view/common/sidebar.jsp"/>

<div class="main-container">

    <div class="add-form">
        <h2>THÊM MÃ GIẢM GIÁ MỚI</h2>

        <form method="post" action="${pageContext.request.contextPath}/Coupon-Add">

            <label>Mã Coupon (Code)</label>
            <input type="text" name="code" placeholder="VD: SALE2025" required>

            <label>Mức giảm (%)</label>
            <input type="number" name="discount" min="1" max="99" placeholder="VD: 20" required>

            <label>Áp dụng cho (ApplyTo)</label>
            <select name="applyto" required>
                <option value="all">Tất cả sản phẩm</option>
                <option value="Phụ kiện">Phụ kiện</option>
                <option value="Thiết bị">Thiết bị</option>
            </select>

            <label>Ngày bắt đầu</label>
            <input type="date" name="date" required>

            <label>Ngày kết thúc</label>
            <input type="date" name="endDate" required>

            <button type="submit">THÊM COUPON</button>
        </form>
    </div>

    <!-- Bảng danh sách coupon bên phải -->
    <div class="coupon-table">
        <h2>DANH SÁCH COUPON</h2>

        <table>
            <tr>
                <th>Id</th>
                <th>Code</th>
                <th>Discount</th>
                <th>StartDate</th>
                <th>EndDate</th>
                <th>Apply to</th>
                <th>Action</th>
            </tr>
            <c:forEach items="${List}" var="i">
                <tr>
                    <td>${i.id}</td>
                    <td>${i.code}</td>
                    <td>${i.discount}%</td>
                    <td><fmt:formatDate value="${i.startDate}" pattern="dd/MM/yyyy"/></td>
                    <td><fmt:formatDate value="${i.endDate}" pattern="dd/MM/yyyy"/></td>
                    <td>${i.applyTo}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/Coupon-delete?id=${i.id}"
                           onclick="return confirm('Bạn có chắc muốn xóa coupon ${i.code}?')">
                            <button class="btn-delete">Delete</button>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <c:if test="${empty List}">
            <p style="text-align:center;color:#888;margin-top:30px;">Chưa có coupon nào!</p>
        </c:if>
    </div>

</div>

