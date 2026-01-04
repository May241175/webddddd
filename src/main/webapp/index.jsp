<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ngwe Pone Gyi</title>

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
html, body {
    height: 100%;
    margin: 0;
}

body {
    font-family: Arial, sans-serif;
    background: #f5f5f5;
}

/* PAGE LAYOUT */
.page-wrapper {
    min-height: 100%;
    display: flex;
    flex-direction: column;
}

.page-content {
    flex: 1;
}

/* NAVBAR */
.shop-navbar {
    background: #fff;
    border-bottom: 1px solid #ddd;
    padding: 10px 20px;
    display: flex;
    align-items: center;
}

.shop-logo {
    font-size: 1.6rem;
    font-weight: bold;
}

.shop-links {
    margin-left: auto;
}

.shop-links a {
    margin-right: 10px;
    font-size: 0.9rem;
    text-decoration: none;
}

/* ORANGE REGISTER BUTTON */
.btn-register {
    background-color: #ff9800;
    border: none;
    color: #fff;
    font-size: 0.85rem;
    padding: 6px 12px;
    border-radius: 4px;
    font-weight: 600;
}

.btn-register:hover {
    background-color: #e68900;
    color: #fff;
}

/* HERO */
.shop-hero {
    background: linear-gradient(to right, #007bff, #0056b3);
    color: white;
    padding: 25px 20px;
}

.shop-hero h2 {
    font-size: 1.5rem;
    margin-bottom: 5px;
}

.shop-hero p {
    font-size: 0.9rem;
}

/* PRODUCTS */
.shop-section {
    padding: 25px 15px;
}

.product-card {
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 10px;
    text-align: center;
}

.product-card img {
    max-height: 140px;
    object-fit: contain;
    margin-bottom: 5px;
}

.product-card h6 {
    font-size: 0.9rem;
    margin-bottom: 4px;
}

.product-card p {
    font-size: 0.85rem;
    margin-bottom: 6px;
}

/* FOOTER (BOTTOM FIXED VIA FLEX) */
.shop-footer {
    background: #343a40;
    color: white;
    padding: 12px;
    text-align: center;
    font-size: 0.85rem;
}
</style>
</head>

<body>

<div class="page-wrapper">

    <!-- PAGE CONTENT -->
    <div class="page-content">

        <!-- NAVBAR -->
        <div class="shop-navbar">
            <div class="shop-logo">Ngwe Pone Gyi</div>

            <div class="shop-links">
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/contact">Contact</a>


                <a href="${pageContext.request.contextPath}/login"
                   class="btn btn-primary btn-sm">
                    Login
                </a>
            </div>
        </div>

        <!-- HERO -->
        <div class="shop-hero">
            <div class="container">
                <h2>Mega Sale – Build for Less</h2>
                <p>Construction materials at wholesale prices</p>

                <a href="${pageContext.request.contextPath}/register"
                   class="btn btn-register btn-sm">
                    Register Now
                </a>
            </div>
        </div>

        <!-- PRODUCTS -->
        <div class="shop-section">
            <div class="container">
                <div class="row g-3">

                    <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/resources/product-images/Cement 50kg.jpg">
                            <h6>Cement 50kg</h6>
                            <p class="text-primary fw-bold">15,000 MMK</p>
                            <a href="${pageContext.request.contextPath}/login"
                               class="btn btn-primary btn-sm w-100">Add</a>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/resources/product-images/GWire.jpg">
                            <h6>G Wire</h6>
                            <p class="text-primary fw-bold">8,500 MMK</p>
                            <a href="${pageContext.request.contextPath}/login"
                               class="btn btn-primary btn-sm w-100">Add</a>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/resources/product-images/PTFE Tape 10m.jpg">
                            <h6>PTFE Tape</h6>
                            <p class="text-primary fw-bold">450 MMK</p>
                            <a href="${pageContext.request.contextPath}/login"
                               class="btn btn-primary btn-sm w-100">Add</a>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>

    <!-- FOOTER -->
    <div class="shop-footer">
        © 2025 Ngwe Pone Gyi Online Sale
    </div>

</div>

</body>
</html>
