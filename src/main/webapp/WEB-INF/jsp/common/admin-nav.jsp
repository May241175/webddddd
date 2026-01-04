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
        color: #dc3545;
        margin-bottom: 20px;
    }

    .sidebar a {
        display: block;
        padding: 10px;
        margin-bottom: 4px;
        color: #333;
        text-decoration: none;
        border-radius: 5px;
        transition: 0.2s;
    }

    .sidebar a:hover {
        background: #ffecec;
        color: #dc3545;
    }

    .sidebar-title {
        font-size: 12px;
        font-weight: bold;
        margin-top: 20px;
        margin-bottom: 5px;
        color: #6c757d;
        text-transform: uppercase;
    }

    .main-content {
        margin-left: 250px;
        padding: 20px;
    }
</style>

<!-- ADMIN SIDEBAR -->
<div class="sidebar">
    <h4>Admin Panel</h4>

    <a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a>
    <a href="${pageContext.request.contextPath}/order-history">🧾 Orders</a>
    <a href="${pageContext.request.contextPath}/product/list">📦 Products</a>

    <div class="sidebar-title">Warehouse Management</div>

    <a href="${pageContext.request.contextPath}/customer">👥 Customer</a>
    <a href="${pageContext.request.contextPath}/supplier">🏭 Supplier</a>
    <a href="${pageContext.request.contextPath}/stockin">📥 Stock In</a>
    <a href="${pageContext.request.contextPath}/stockout/report">📤 Stock Out Report</a>
    <a href="${pageContext.request.contextPath}/stockbalance/report">📊 Stock Balance</a>

    <div class="sidebar-title">System</div>
     <a href="${pageContext.request.contextPath}/admin/profile"> 👤Profile</a>
    <a href="${pageContext.request.contextPath}/logout" class="text-danger">🚪 Logout</a>
</div>
