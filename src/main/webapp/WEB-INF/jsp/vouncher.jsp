<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>အမှာစာ အောင်မြင်စွာ တင်သွင်းပြီး</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        /* 🎨 Sidebar Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background-color: #f5f7fa;
        }
        
        /* --- Fixed Sidebar Container --- */
        .sidebar {
            position: fixed; 
            top: 0;
            left: 0;
            width: 250px; 
            height: 100vh; 
            background: #ffffff; 
            border-right: 1px solid #e0e0e0;
            padding-top: 55px; 
            padding-bottom: 20px;
            overflow-y: auto; 
            z-index: 999; 
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.05); 
            min-height: auto; 
        }

        /* --- Store Title Styling (Fixed Position ဖြင့် Sidebar အပေါ်ဆုံးတွင် ထားရန်) --- */
        .store-title {
            position: fixed; 
            top: 0;
            left: 0;
            width: 250px;
            font-size: 20px; 
            color: #0d6efd; 
            font-weight: 700; 
            padding: 15px 15px 10px 15px; 
            border-bottom: 1px solid #e0e0e0;
            background-color: #ffffff; 
            z-index: 1000;
            margin-bottom: 5px;
        }
        
        /* 🔗 Link Styling */
        .sidebar a {
            padding: 12px 15px;
            display: block;
            color: #343a40; 
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.25s ease; 
        }

        /* 🌟 Hover Effect (အပြာရောင် Glow) */
        .sidebar a:hover {
            background: #e6f7ff; 
            color: #0056b3; 
            border-left: 4px solid #0d6efd; 
            padding-left: 11px; 
        }
        
        /* 📖 Sidebar Section Title */
        .sidebar-title {
            font-size: 12px;
            font-weight: bold;
            color: #6c757d; 
            text-transform: uppercase;
            padding: 15px 15px 5px 15px;
            margin-top: 15px;
        }
        .sidebar-title:first-child {
            margin-top: 0;
        }

        /* --- Main Content Area (Layout and Positioning) --- */
        .main-content {
            margin-left: 250px; /* Sidebar ရဲ့ အကျယ် (250px) 만큼 နေရာချန်ထားသည် */
            width: calc(100% - 250px); /* ကျန်ရှိသော အကျယ် */
            min-height: 100vh; /* မျက်နှာပြင် အမြင့်အပြည့် */
            padding: 20px;
            /* Success Card ကို အလယ်တည့်တည့် ထားရန် */
            display: flex;
            justify-content: center;
            align-items: center;
        }
        /* End of Sidebar Styles */


        /* --- Original Success Card Styling --- */
        .success-card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
            border-top: 5px solid #198754; /* Green accent color */
            margin-top: auto; /* main-content ၏ center ချိန်ညှိမှုအတွက် */
            margin-bottom: auto;
        }
        
        .success-icon {
            font-size: 60px;
            color: #198754;
            margin-bottom: 20px;
        }
        
        .order-id {
            font-size: 1.5rem;
            font-weight: bold;
            color: #0d6efd;
            margin-top: 10px;
            display: inline-block;
            background: #e9f2ff;
            padding: 8px 20px;
            border-radius: 8px;
        }
        
        @media (max-width: 576px) {
            .success-card {
                padding: 25px;
            }
        }
    </style>
</head>

<body>
    
    <h3 class="store-title">Ngwe Pone Gyi Sale</h3> 

    <div class="sidebar">

        <div class="sidebar-title">Your Shop Menu</div>

        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/products">Browse Products</a>
        <a href="${pageContext.request.contextPath}/cart">My Cart</a>
        <a href="${pageContext.request.contextPath}/order-history">Order History</a>
        <a href="${pageContext.request.contextPath}/address">User Address</a>
        
        <a href="${pageContext.request.contextPath}/logout">Logout</a>

        <div class="sidebar-title mt-4">Warehouse Management</div>
        
        <a href="${pageContext.request.contextPath}/profile">Profile</a>
        <a href="${pageContext.request.contextPath}/customer">Customer</a>
        <a href="${pageContext.request.contextPath}/stockin">Stock In</a>
        <a href="${pageContext.request.contextPath}/stockout/report">Stock Out Report</a>
        <a href="${pageContext.request.contextPath}/stockbalance/report">Stock Balance Report</a>
        <a href="${pageContext.request.contextPath}/supplier">Supplier</a>

    </div>

    <div class="main-content">

        <div class="success-card">
            <div class="success-icon">
                &#x2714; </div>

            <h2 class="fw-bold text-success mb-3">အမှာစာ တင်သွင်းမှု အောင်မြင်ပါပြီ!</h2>
                                
            <p class="text-muted">
                ဝယ်ယူအားပေးမှုအတွက် ကျေးဇူးတင်ပါတယ်။ သင့်အမှာစာကို လက်ခံရရှိပြီး ပို့ဆောင်ရန် စီစဉ်နေပါပြီ။
            </p>

            <c:if test="${orderId != null}">
                <p class="mb-2 mt-4 text-secondary">သင့်အမှာစာနံပါတ်မှာ-</p>
                <span class="order-id">#${orderId}</span>
            </c:if>

                
            <div class="mt-5">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg me-2">
                 Logout
                </a>
            </div>

        </div>

    </div> </body>
</html>