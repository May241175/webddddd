<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<style>
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 250px;
        height: 100vh;
        background: #ffffff;
        border-right: 1px solid #ddd;
        padding: 15px;
        z-index: 1000;
    }

    .sidebar h4 {
        font-weight: bold;
        color: #0d6efd;
        margin-bottom: 20px;
    }

    .sidebar a {
        display: block;
        padding: 10px;
        margin-bottom: 5px;
        color: #333;
        text-decoration: none;
        border-radius: 5px;
        transition: 0.2s;
    }

    .sidebar a:hover {
        background: #e6f7ff;
        color: #0d6efd;
    }

    .sidebar-title {
        font-size: 12px;
        font-weight: bold;
        color: #6c757d;
        margin-top: 20px;
        margin-bottom: 5px;
    }

    .main-content {
        margin-left: 250px;
        padding: 20px;
    }
</style>

<!-- USER SIDEBAR -->
<div class="sidebar">
    <h4>Ngwe Pone Gyi</h4>

    <a href="${pageContext.request.contextPath}/home">🏠 Home</a>
    <a href="${pageContext.request.contextPath}/product/list">📦 Products</a>
    <a href="${pageContext.request.contextPath}/cart">🛒 Cart</a>
    <a href="${pageContext.request.contextPath}/order-history">🧾 Orders</a>

    <div class="sidebar-title">Account</div>
    <a href="${pageContext.request.contextPath}/profile">👤 Profile</a>
    <a href="${pageContext.request.contextPath}/logout" class="text-danger">🚪 Logout</a>
</div>
