<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .card h4 {
            margin: 0;
            font-weight: bold;
        }
    </style>
</head>

<body class="bg-light">

<jsp:include page="/WEB-INF/jsp/common/layout.jsp"/>

<div class="main-content">

    <h3 class="fw-bold mb-4">📊 Admin Dashboard</h3>

    <!-- SUMMARY CARDS -->
    <div class="row g-3 mb-4">

        <div class="col-md-3">
            <div class="card shadow-sm p-3 text-center">
                <h6>Total Orders</h6>
                <h4 class="text-primary">${totalOrders}</h4>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card shadow-sm p-3 text-center">
                <h6>Customers</h6>
                <h4 class="text-success">${totalCustomers}</h4>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card shadow-sm p-3 text-center">
                <h6>Suppliers</h6>
                <h4 class="text-warning">${totalSuppliers}</h4>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card shadow-sm p-3 text-center">
                <h6>Stocks</h6>
                <h4 class="text-danger">${totalStocks}</h4>
            </div>
        </div>

    </div>

    <!-- CHART -->
    <div class="card shadow-sm p-4">
        <h5 class="mb-3">📈 System Overview</h5>
        <canvas id="dashboardChart" height="120"></canvas>
    </div>

</div>

<script>
    const ctx = document.getElementById('dashboardChart');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Orders', 'Customers', 'Suppliers', 'Stocks'],
            datasets: [{
                label: 'Total Count',
                data: [
                    ${totalOrders},
                    ${totalCustomers},
                    ${totalSuppliers},
                    ${totalStocks}
                ],
                backgroundColor: [
                    '#0d6efd',
                    '#198754',
                    '#ffc107',
                    '#dc3545'
                ]
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

</body>
</html>
