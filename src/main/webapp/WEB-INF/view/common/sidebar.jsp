<!-- /WEB-INF/view/common/sidebar.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .sidebar {
        position: fixed;
        left: 0;
        top: 0;
        width: 80px;
        height: 100vh;
        background: rgba(0, 0, 0, 0.8);
        backdrop-filter: blur(10px);
        transition: width 0.35s ease;
        z-index: 1000;
        overflow: hidden;
        box-shadow: 5px 0 15px rgba(0, 0, 0, 0.25);
    }

    .sidebar:hover {
        width: 250px;
    }

    .sidebar-header {
        padding: 25px 20px;
        text-align: center;
        color: white;
        font-size: 22px;
        font-weight: 700;
        letter-spacing: 1px;
    }

    /* Menu */
    .sidebar-menu {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .sidebar-menu li {
        padding: 16px 25px;
        cursor: pointer;
        transition: 0.25s;
        border-radius: 8px;
    }

    .sidebar-menu li:hover {
        background: rgba(255, 255, 255, 0.22);
        transform: translateX(5px);
    }

    .sidebar-menu li a {
        color: white;
        text-decoration: none;
        display: flex;
        align-items: center;
        width: 100%;
        font-size: 16px;
        font-weight: 500;
        letter-spacing: 0.3px;
    }

    /* Text fade-in khi mở rộng */
    .sidebar-menu li span {
        margin-left: 12px;
        opacity: 0;
        transition: opacity 0.3s ease;
        white-space: nowrap;
    }

    .sidebar:hover li span {
        opacity: 1;
    }
</style>

<div class="sidebar">
    <div class="sidebar-header">Menu</div>

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
