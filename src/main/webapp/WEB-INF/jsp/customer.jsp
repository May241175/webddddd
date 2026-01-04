<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Info</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            margin-top: 0; 
        }

        /* Table Design Enhancement */
        .table {
            border-radius: 8px;
            overflow: hidden; /* For rounded corners to apply to the table */
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .table thead th {
            border-bottom: 2px solid #0d6efd;
        }
    </style>
</head>

<body class="bg-light">
<jsp:include page="/WEB-INF/jsp/common/admin-nav.jsp"/>

    

    <div class="main-content">

        <div class="container-fluid mt-4">
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                 <h3 class="fw-bold m-0">Customer Info</h3>
                
            
            </div>

            <form method="get" action="${pageContext.request.contextPath}/customer" class="mb-4">
                <div class="row g-2 align-items-center">
                    <div class="col-8 col-md-4">
                        <input type="text" name="keyword" value="${keyword}" class="form-control"
                               placeholder="Search username or phone...">
                    </div>
                    <div class="col-4 col-md-2">
                        <button class="btn btn-primary w-100">Search</button>
                    </div>
                </div>
            </form>

            <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addModal">
                Add Customer
            </button>

            <div class="table-responsive">
                <table class="table table-bordered table-striped bg-white">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Full Name</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Payment</th>
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="c" items="${list}">
                        <tr>
                            <td>${c.userId}</td>
                            <td>${c.userName}</td>
                            <td>${c.userEmail}</td>
                            <td>${c.userPassword}</td>
                            <td>${c.userFullname}</td>
                            <td>${c.userPhoneNumber}</td>
                            <td>${c.userAddress}</td>
                            <td>${c.userPayment}</td>

                            <td class="text-nowrap">
                                <a href="${pageContext.request.contextPath}/customer/edit?id=${c.userId}"
                                   class="btn btn-sm btn-warning">Edit</a>

                                <a href="${pageContext.request.contextPath}/customer/delete?id=${c.userId}"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this customer?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="mt-3">
                <nav>
                    <ul class="pagination">

                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/customer?page=${currentPage - 1}&keyword=${keyword}">
                                Previous
                            </a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/customer?page=${i}&keyword=${keyword}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/customer?page=${currentPage + 1}&keyword=${keyword}">
                                Next
                            </a>
                        </li>

                    </ul>
                </nav>
            </div>

        </div>
        
    </div> <div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <form action="${pageContext.request.contextPath}/customer/add" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Customer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <label>Username</label>
                    <input type="text" name="userName" class="form-control" required>

                    <label class="mt-2">Email</label>
                    <input type="email" name="userEmail" class="form-control" required>

                    <label class="mt-2">Password</label>
                    <input type="password" name="userPassword" class="form-control" required>

                    <label class="mt-2">Full Name</label>
                    <input type="text" name="userFullname" class="form-control">

                    <label class="mt-2">Phone Number</label>
                    <input type="text" name="userPhoneNumber" class="form-control">

                    <label class="mt-2">Address</label>
                    <input type="text" name="userAddress" class="form-control">

                    <label class="mt-2">Payment Method</label>
                    <input type="text" name="userPayment" class="form-control">
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Save</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>

            </form>

        </div>
    </div>
</div>

<c:if test="${customer != null}">
<div class="modal fade show" id="editModal" style="display:block; background-color: rgba(0,0,0,0.5);" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <form action="${pageContext.request.contextPath}/customer/update" method="post">

                <div class="modal-header">
                    <h5 class="modal-title">Edit Customer</h5>
                    <a href="${pageContext.request.contextPath}/customer" class="btn-close"></a>
                </div>

                <div class="modal-body">

                    <input type="hidden" name="userId" value="${customer.userId}"/>

                    <label>Username</label>
                    <input type="text" name="userName" class="form-control" value="${customer.userName}" required>

                    <label class="mt-2">Email</label>
                    <input type="email" name="userEmail" class="form-control" value="${customer.userEmail}" required>

                    <label class="mt-2">Password</label>
                    <input type="text" name="userPassword" class="form-control" value="${customer.userPassword}" required>

                    <label class="mt-2">Full Name</label>
                    <input type="text" name="userFullname" class="form-control" value="${customer.userFullname}">

                    <label class="mt-2">Phone Number</label>
                    <input type="text" name="userPhoneNumber" class="form-control" value="${customer.userPhoneNumber}">

                    <label class="mt-2">Address</label>
                    <input type="text" name="userAddress" class="form-control" value="${customer.userAddress}">

                    <label class="mt-2">Payment Method</label>
                    <input type="text" name="userPayment" class="form-control" value="${customer.userPayment}">
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Update</button>
                    <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">Cancel</a>
                </div>

            </form>

        </div>
    </div>
</div>
<div class="modal-backdrop fade show" style="opacity: 0.5;"></div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>