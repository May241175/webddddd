<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* 🎨 Global Styling (Sidebar Fixed အတွက် Body ကို ပြင်ဆင်ခြင်း) */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background-color: #f8f9fa; /* Light background */
        }
        
        /* Main content ဧရိယာသည် Sidebar ၏ညာဘက်တွင် နေရာယူစေရန် */
        .main-content {
            margin-left: 250px; /* Sidebar ရဲ့ အကျယ် (250px) 만큼 နေရာချန်ထားသည် */
            padding: 20px;
        }

        /* --- Fixed Sidebar Container --- */
        .sidebar {
            /* 🌟 Fixed Position */
            position: fixed; 
            top: 0;
            left: 0;
            width: 250px; /* Sidebar ရဲ့ အကျယ် */
            height: 100vh; /* မျက်နှာပြင် အပေါ်မှ အောက်ဆုံးအထိ */
            background: #ffffff; 
            border-right: 1px solid #e0e0e0;
            padding-top: 55px; /* Store Title နေရာအတွက် နေရာချန်ထားသည် */
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
            color: #007bff; 
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
            border-left: 4px solid #007bff; 
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
            border-bottom: none; 
        }
        
        .sidebar-title:first-child {
            margin-top: 0;
        }
    </style>
</head>

<body class="bg-light">
<jsp:include page="/WEB-INF/jsp/common/layout.jsp"/>
   

    <div class="main-content">

        <div class="container-fluid"> <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold m-0">🛒 Your Cart</h3>
                
           
            </div>
            
            <a href="${pageContext.request.contextPath}/product/list" class="btn btn-outline-secondary mb-3">
                ← Continue Shopping
            </a>
        
        
            <c:if test="${empty cartItems}">
                <div class="alert alert-info text-center p-4">
                    <h5>Your cart is empty.</h5>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-2">
                        Browse Products
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty cartItems}">

                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-body">

                        <table class="table align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Product</th>
                                <th width="140" class="text-center">Qty</th> <th width="120">Price</th>
                                <th width="140">Subtotal</th>
                                <th>Action</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:set var="grandTotal" value="0" />

                            <c:forEach var="item" items="${cartItems}">
                                <c:set var="subtotal" value="${item.unitPrice * item.quantity}" />
                                <c:set var="grandTotal" value="${grandTotal + subtotal}" />

                                <tr>

                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${pageContext.request.contextPath}/resources/product-images/${item.productImage}"
                                                 style="width:65px;height:65px;object-fit:cover;border-radius:8px;margin-right:12px;">
                                            <div>
                                                <strong>${item.stockName}</strong><br>
                                                <small class="text-muted">${item.itemName}</small>
                                            </div>
                                        </div>
                                    </td>

                                    <td class="text-center">
                                        <span class="fw-bold fs-6">${item.quantity}</span>
                                    </td>

                                    <td>
                                        <strong>${item.unitPrice} Ks</strong>
                                    </td>

                                    <td class="fw-bold text-primary">
                                        ${subtotal} Ks
                                    </td>

                                    <td>
                                        <a href="${pageContext.request.contextPath}/cart/delete?id=${item.cartItemId}"
                                           class="btn btn-sm btn-danger">
                                            Remove
                                        </a>
                                    </td>
                                </tr>

                            </c:forEach>

                            </tbody>
                        </table>

                    </div>
                </div>

                <div class="card shadow-sm border-0 p-3">
                    <div class="d-flex justify-content-between align-items-center">

                        <h4 class="fw-bold">
                            Total: <span class="text-success">${grandTotal} Ks</span>
                        </h4>

                        <div>
                            <a href="${pageContext.request.contextPath}/cart/clear"
                               class="btn btn-outline-warning me-2">
                                Clear Cart
                            </a>

                            <a href="${pageContext.request.contextPath}/checkout"
                               class="btn btn-primary">
                                Checkout →
                            </a>
                        </div>

                    </div>
                </div>

            </c:if>

        </div> </div> </body>
</html>