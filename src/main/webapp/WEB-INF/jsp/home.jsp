<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Ngwe Pone Gyi | Home</title>

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* ===== MAIN CONTENT ONLY ===== */
.main-content {
    margin-left: 250px;   /* must match sidebar width */
    padding: 20px;
    background: #f5f5f5;
    min-height: 100vh;
}

/* TOP BAR */
.topbar {
    background: #fff;
    padding: 10px 20px;
    border-bottom: 1px solid #ddd;
    display: flex;
    align-items: center;
}

/* SECTION */
.shop-section {
    padding: 20px 0;
}

/* PRODUCT CARD */
.product-card {
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 10px;
    text-align: center;
}

.product-card img {
    max-height: 130px;
    object-fit: contain;
}

.product-card h6 {
    font-size: 0.9rem;
    margin: 5px 0;
}

/* CATEGORY CARD */
.category-card {
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 15px;
    text-align: center;
    cursor: pointer;
}

.category-card:hover {
    background: #f1f1f1;
}

/* FOOTER */
.footer {
    background: #343a40;
    color: white;
    text-align: center;
    padding: 10px;
    font-size: 0.85rem;
}
</style>
</head>

<body>

<!-- SIDEBAR (FROM COMMON JSP) -->
<jsp:include page="/WEB-INF/jsp/common/layout.jsp"/>

<!-- MAIN CONTENT -->
<div class="main-content">

    <!-- TOP BAR -->
    <div class="topbar mb-3">
        <span class="fw-bold">
            Welcome, ${sessionScope.user.user_fullname}
        </span>
    </div>

    <!-- CATEGORY SECTION -->
    <div class="shop-section">
        <h5 class="mb-3">Categories</h5>

        <div class="row g-3">
            <c:forEach var="c" items="${categories}">
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/products?categoryId=${c.categoryId}"
                       class="text-decoration-none text-dark">

                        <div class="category-card h-100">
                            <c:choose>
                                <c:when test="${c.categoryName == 'Construction'}">
                                    <i class="fas fa-building fa-2x text-primary"></i>
                                </c:when>
                                <c:when test="${c.categoryName == 'Hardware'}">
                                    <i class="fas fa-tools fa-2x text-success"></i>
                                </c:when>
                                <c:when test="${c.categoryName == 'Plumbing'}">
                                    <i class="fas fa-faucet fa-2x text-info"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-box fa-2x text-warning"></i>
                                </c:otherwise>
                            </c:choose>

                            <p class="mt-2 fw-bold mb-0">
                                ${c.categoryName}
                            </p>
                        </div>

                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- BEST SELLERS -->
    <div class="shop-section pt-0">
        <h5 class="mb-3 text-danger">🔥 Best Sellers</h5>

        <div class="row g-3">
            <c:forEach var="p" items="${bestSellers}">
                <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                    <div class="product-card border border-warning">
                        <span class="badge bg-warning text-dark mb-1">Best</span>

                        <img src="${pageContext.request.contextPath}/resources/product-images/${p.productImage}">
                        <h6>${p.itemName}</h6>
                        <p class="text-danger fw-bold">${p.unitPrice} MMK</p>

                        <form action="${pageContext.request.contextPath}/cart/add" method="post">
                            <input type="hidden" name="stockId" value="${p.stockId}">
                            <input type="hidden" name="quantity" value="1">
                            <button class="btn btn-sm btn-primary w-100">
                                Add
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- ALL PRODUCTS -->
    <div class="shop-section">
        <h5 class="mb-3">Available Products</h5>

        <div class="row g-3">
            <c:forEach var="p" items="${products}">
                <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                    <div class="product-card">
                        <img src="${pageContext.request.contextPath}/resources/product-images/${p.productImage}">
                        <h6>${p.itemName}</h6>
                        <p class="text-primary fw-bold">${p.unitPrice} MMK</p>

                        <a href="${pageContext.request.contextPath}/cart/add/${p.stockId}"
                           class="btn btn-primary btn-sm w-100">
                            Add to Cart
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- FOOTER -->
    <div class="footer mt-4">
        © 2025 Ngwe Pone Gyi Online Sale
    </div>

</div>

</body>
</html>
