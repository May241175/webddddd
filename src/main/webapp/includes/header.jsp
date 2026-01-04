<%-- WEB-INF/views/includes/header.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Warehouse Management System</title>
    
    <!-- Bootstrap CSS (Optional) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    
    <!-- JavaScript ကို ဒီလိုခေါ်ရမယ် -->
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <!-- Font Awesome (Optional) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <header class="header">
        <nav class="navbar container">
            <a href="${pageContext.request.contextPath}/" class="logo">
                <i class="fas fa-warehouse"></i> Warehouse Management
            </a>
            
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                
                <c:if test="${empty sessionScope.user}">
                    <li><a href="${pageContext.request.contextPath}/auth/login">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/auth/register">Register</a></li>
                </c:if>
                
                <c:if test="${not empty sessionScope.user}">
                    <li><a href="${pageContext.request.contextPath}/profile">My Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                    
                    <c:if test="${sessionScope.is_admin == 1}">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a></li>
                    </c:if>
                    
                    <li>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-danger">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                    
                    <!-- Cart icon with count -->
                    <li>
                        <a href="${pageContext.request.contextPath}/cart" class="btn">
                            <i class="fas fa-shopping-cart"></i> Cart
                            <c:if test="${sessionScope.cart_count > 0}">
                                <span class="badge bg-danger">${sessionScope.cart_count}</span>
                            </c:if>
                        </a>
                    </li>
                    
                    <!-- Wishlist icon with count -->
                    <li>
                        <a href="${pageContext.request.contextPath}/wishlist" class="btn">
                            <i class="fas fa-heart"></i> Wishlist
                            <c:if test="${sessionScope.wishlist_count > 0}">
                                <span class="badge bg-danger">${sessionScope.wishlist_count}</span>
                            </c:if>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </header>
    
    <main class="container">