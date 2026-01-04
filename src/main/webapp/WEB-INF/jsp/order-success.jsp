<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Success</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4 text-center">

        <h2 class="text-success">✔ Order Placed Successfully!</h2>
        <p class="mt-3">Your order number is:</p>

        <h3 class="fw-bold text-primary">#${orderId}</h3>

        <p class="mt-3">Thank you for your purchase.</p>

        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-4">
            Continue Shopping
        </a>

        <a href="${pageContext.request.contextPath}/order-history" class="btn btn-secondary mt-4">
            View Order History
        </a>

    </div>

</div>

</body>
</html>
