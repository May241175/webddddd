<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ngwe Pone Gyi | Premium Construction Shop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        /* Modern E-commerce Palette */
        :root {
            --shop-primary: #1a237e; /* Midnight Blue */
            --shop-accent: #ffd600;  /* Construction Gold */
            --shop-bg: #f4f7f9;
            --shop-text: #2d3436;
        }

        body {
            font-family: 'Inter', -apple-system, sans-serif;
            background-color: var(--shop-bg);
            color: var(--shop-text);
            padding-top: 80px;
        }

        /* --- Modern Top Navigation --- */
        .navbar-custom {
            background: white;
            height: 80px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }

        .brand-logo {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--shop-primary);
            letter-spacing: -1px;
            text-decoration: none;
        }

        .nav-link-custom {
            color: var(--shop-text);
            font-weight: 600;
            text-decoration: none;
            margin-left: 25px;
            font-size: 0.95rem;
            transition: color 0.2s;
        }

        .nav-link-custom:hover {
            color: var(--shop-primary);
        }

        /* --- Hero Banner Style --- */
        .hero-container {
            position: relative;
            border-radius: 20px;
            overflow: hidden;
            background: #000;
        }

        .hero-banner {
            width: 100%;
            height: 400px;
            object-fit: cover;
            opacity: 0.85;
        }

        .hero-overlay-text {
            position: absolute;
            top: 50%;
            left: 5%;
            transform: translateY(-50%);
            color: white;
            max-width: 500px;
        }

        /* --- Product Card - A-Shop Style --- */
        .product-card {
            border: 1px solid rgba(0,0,0,0.05);
            border-radius: 12px;
            background: white;
            transition: all 0.3s cubic-bezier(.25,.8,.25,1);
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .img-container {
            background: #fff;
            padding: 20px;
            border-bottom: 1px solid #f1f1f1;
            position: relative;
        }

        .badge-new {
            position: absolute;
            top: 10px;
            left: 10px;
            background: var(--shop-accent);
            color: #000;
            font-weight: 800;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.7rem;
            text-transform: uppercase;
        }

        .card-body { padding: 1.5rem; }

        .price-tag {
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--shop-primary);
        }

        .btn-buy {
            background-color: var(--shop-primary);
            color: white;
            border-radius: 8px;
            padding: 10px;
            font-weight: 600;
            border: none;
            transition: 0.3s;
        }

        .btn-buy:hover {
            background-color: #0d1440;
            color: white;
        }

        /* --- Footer --- */
        .shop-footer {
            background: var(--shop-primary);
            color: rgba(255,255,255,0.7);
            padding: 60px 0;
            margin-top: 100px;
        }
    </style>
</head>
<body>
 
    <nav class="navbar-custom fixed-top d-flex align-items-center">
        <div class="container d-flex justify-content-between align-items-center">
            <a href="#" class="brand-logo">NGWE PONE GYI.</a>
            
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/home" class="nav-link-custom">Home</a>
                <a href="${pageContext.request.contextPath}/cart" class="nav-link-custom position-relative">
                    <i class="fas fa-shopping-bag fa-lg"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">0</span>
                </a>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-dark ms-4 px-4 rounded-pill">Login</a>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="hero-container shadow-lg">
            <img src="resources/product-images/warehouse.jpg.png" class="hero-banner" alt="Store">
            <div class="hero-overlay-text">
                <span class="badge bg-warning text-dark mb-2">LIMITED TIME OFFER</span>
                <h1 class="display-4 fw-bold">Build Your Vision</h1>
                <p>Premium construction materials delivered to your site. High grade, high strength.</p>
                <button class="btn btn-light btn-lg rounded-pill fw-bold">Shop Collection</button>
            </div>
        </div>
    </div>

    <main class="container py-5">
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <h2 class="fw-bold mb-0">Featured Products</h2>
                <p class="text-muted">Explore our best-selling construction essentials</p>
            </div>
            <a href="#" class="text-primary text-decoration-none fw-bold">View All Items &rarr;</a>
        </div>
        
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty products}">
                    <c:forEach var="p" items="${products}">
                        <div class="col-md-4 col-lg-3">
                            <div class="card product-card h-100">
                                <div class="img-container">
                                    <span class="badge-new">Best Seller</span>
                                    <img src="${pageContext.request.contextPath}/resources/product-images/${p.productImage}" 
                                         class="img-fluid" style="height: 180px; object-fit: contain;"
                                         onerror="this.src='https://via.placeholder.com/300?text=Premium+Material'">
                                </div>

                                <div class="card-body d-flex flex-column">
                                    <small class="text-uppercase text-muted fw-bold" style="font-size: 0.7rem;">${p.itemName}</small>
                                    <h5 class="fw-bold mb-3">${p.stockName}</h5>
                                    
                                    <div class="mt-auto">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <span class="price-tag">${p.unitPrice} <small style="font-size: 0.6rem;">KS</small></span>
                                            <span class="text-muted" style="font-size: 0.8rem;">Stock: ${p.availableQty}</span>
                                        </div>
                                        
                                        <form action="${pageContext.request.contextPath}/cart/add" method="post">
                                            <input type="hidden" name="stockId" value="${p.stockId}">
                                            <div class="input-group mb-2">
                                                <input type="number" name="quantity" value="1" min="1" class="form-control form-control-sm">
                                                <button type="submit" class="btn btn-buy px-4 btn-sm">
                                                    <i class="fas fa-cart-plus me-2"></i> Add to Cart
                                                </button>
                                            </div>
                                        </form>
                                        <button class="btn btn-outline-light text-dark btn-sm w-100 border-0" style="font-size: 0.8rem;"
                                                onclick="alert('Warehouse: ${p.stockLocation}')">
                                            Quick View
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <img src="https://cdn-icons-png.flaticon.com/512/4076/4076549.png" width="100" class="mb-3 opacity-50">
                        <h4 class="text-muted">Store is currently updating...</h4>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <footer class="shop-footer">
        <div class="container text-center">
            <h4 class="text-white fw-bold mb-4">NGWE PONE GYI.</h4>
            <div class="mb-4">
                <a href="#" class="text-white mx-3 fs-5"><i class="fab fa-facebook"></i></a>
                <a href="#" class="text-white mx-3 fs-5"><i class="fab fa-instagram"></i></a>
                <a href="#" class="text-white mx-3 fs-5"><i class="fab fa-viber"></i></a>
            </div>
            <p class="small">&copy; 2025 Ngwe Pone Gyi Construction. Quality You Can Build On.</p>
        </div>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>