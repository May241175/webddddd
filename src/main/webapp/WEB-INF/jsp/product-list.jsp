<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Products List</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            margin: 0;
            background: #f8f9fa;
        }

        /* Main Content (sidebar width = 250px) */
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        /* SMALL PRODUCT CARD */
        .product-card {
            font-size: 13px;
        }

        .product-card img {
            height: 140px;
            object-fit: cover;
        }

        .product-card h5 {
            font-size: 15px;
            margin-bottom: 4px;
        }

        .product-card p {
            margin-bottom: 3px;
            font-size: 12px;
        }

        .product-card .btn {
            padding: 4px 8px;
            font-size: 12px;
        }
    </style>
</head>

<body>

<!-- ✅ COMMON NAV (SIDEBAR) -->
<jsp:include page="/WEB-INF/jsp/common/layout.jsp"/>

<!-- MAIN CONTENT -->
<div class="main-content">

    <h3 class="fw-bold mb-3">Products</h3>

    <div class="row g-3">
        <c:forEach var="p" items="${products}">
            <div class="col-lg-3 col-md-4 col-sm-6">

                <div class="card h-100 shadow-sm product-card">

                    <img src="${pageContext.request.contextPath}/resources/product-images/${p.productImage}"
                         class="card-img-top">

                    <div class="card-body p-2">
                        <h5>${p.stockName}</h5>
                        <p>Item: ${p.itemName}</p>
                        <p>Location: ${p.stockLocation}</p>
                        <p class="text-success fw-bold">Price: ${p.unitPrice} Ks</p>
                        <p class="text-primary fw-bold">Available: ${p.availableQty}</p>

                        <form action="${pageContext.request.contextPath}/cart/add"
                              method="post"
                              class="d-flex align-items-center mt-1">

                            <input type="hidden" name="stockId" value="${p.stockId}">

                            <input type="number"
                                   name="quantity"
                                   value="1"
                                   min="1"
                                   class="form-control form-control-sm me-2"
                                   style="width:60px;">

                            <button class="btn btn-sm btn-primary">
                                Add
                            </button>
                        </form>
                    </div>

                </div>

            </div>
        </c:forEach>
    </div>

</div>

</body>
</html>
