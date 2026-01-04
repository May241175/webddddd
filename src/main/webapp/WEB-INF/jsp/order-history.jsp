<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        /* 🎨 Sidebar Global Styles */
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
        /* End of Sidebar Styles */
        
        /* Content Header Adjustment */
        .main-content h3 {
            margin-top: 0; /* Remove default h3 top margin */
        }
    </style>
</head>

<body class="bg-light">
<jsp:include page="/WEB-INF/jsp/common/layout.jsp"/>


    <div class="main-content">

        <div class="container-fluid mt-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                 <h3 class="fw-bold m-0">Your Orders</h3>
              
            </div>

            <table class="table table-bordered table-striped shadow-sm bg-white">
                <thead class="table-dark">
                <tr>
                    <th>Order No</th>
                    <th>Status</th>
                    <th>Total</th>
                    <th>Payment</th>
                    <th>Date</th>
                    <th></th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td>${o.order_number}</td>
                        <td><span class="badge bg-info">${o.status}</span></td>
                        <td>${o.total} Ks</td>
                        <td>${o.payment_method}</td>
                        <td>${o.order_date}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/order-details?id=${o.id}"
                               class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#detailsModal"
                               onclick="openDetails('${o.id}')">
                                View
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
        
    </div> <div class="modal fade" id="detailsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" id="detailsContent">
        </div>
    </div>
</div>

<script>
function openDetails(id) {
    // Note: The fetch URL should use the context path correctly
    fetch('${pageContext.request.contextPath}/order-details?id=' + id)
        .then(res => {
            if (!res.ok) {
                throw new Error('Network response was not ok');
            }
            return res.text();
        })
        .then(html => {
            document.getElementById("detailsContent").innerHTML = html;
        })
        .catch(error => {
            console.error('Fetch error:', error);
            document.getElementById("detailsContent").innerHTML = 
                '<div class="modal-header"><h5 class="modal-title">Error</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div><div class="modal-body"><p>Could not load order details.</p></div>';
        });
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>