<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Supplier Info</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* [CSS Styles are correct] */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background-color: #f8f9fa;
        }
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

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
        
        .sidebar a {
            padding: 12px 15px;
            display: block;
            color: #343a40; 
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.25s ease; 
        }

        .sidebar a:hover {
            background: #e6f7ff; 
            color: #0056b3; 
            border-left: 4px solid #0d6efd; 
            padding-left: 11px; 
        }
        
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
        .main-content h3 {
            margin-top: 0; 
        }

        .table {
            background-color: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-radius: 8px;
            overflow: hidden;
        }
        .table thead th a {
            color: white;
            text-decoration: none;
        }
        .table thead th a:hover {
            text-decoration: underline;
        }
        .table-dark {
            background-color: #0d6efd;
        }
    </style>
</head>

<body class="bg-light">
<jsp:include page="/WEB-INF/jsp/common/layout.jsp"/>

   

    <div class="main-content">

        <div class="container-fluid mt-4">
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                 <h3 class="fw-bold m-0">🤝 Supplier Information</h3>
               
            </div>

            <form method="get" action="${pageContext.request.contextPath}/supplier" class="mb-4">
                <div class="row g-2 align-items-center">
                    <div class="col-8 col-md-4">
                        <input type="text" name="keyword" value="${keyword}"
                               placeholder="Search supplier name or phone..."
                               class="form-control">
                    </div>
                    <input type="hidden" name="sortField" value="${sortField}">
                    <input type="hidden" name="sortDir" value="${sortDir}">
                    
                    <div class="col-4 col-md-2">
                        <button class="btn btn-primary w-100">Search</button>
                    </div>
                </div>
            </form>

            <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addModal">
                + Add Supplier
            </button>

            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>

                        <th>
                            <a href="${pageContext.request.contextPath}/supplier?keyword=${keyword}&sortField=supplier_name&sortDir=${reverseSortDir}">
                                Supplier Name
                            </a>
                        </th>

                        <th>Phone</th>
                        <th>Address</th>
                        <th>Item Name</th>
                        <th width="150">Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="s" items="${list}">
                        <tr>
                            <td>${s.supplierId}</td>
                            <td>${s.supplierName}</td>
                            <td>${s.phone}</td>
                            <td>${s.address}</td>
                             <td>
            <c:choose>
                <c:when test="${not empty s.stockName}">
                    ${s.stockName}
                </c:when>
                <c:otherwise>
                    <span class="text-muted">No Item</span>
                </c:otherwise>
            </c:choose>
        </td>

                            <td class="text-nowrap">
                                <a href="${pageContext.request.contextPath}/supplier/edit?id=${s.supplierId}&keyword=${keyword}&page=${currentPage}&sortField=${sortField}&sortDir=${sortDir}"
                                   class="btn btn-sm btn-warning">Edit</a>

                                <a href="${pageContext.request.contextPath}/supplier/delete?id=${s.supplierId}"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this supplier?');">
                                    Delete
                                </a>
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
                               href="${pageContext.request.contextPath}/supplier?page=${currentPage - 1}&keyword=${keyword}&sortField=${sortField}&sortDir=${sortDir}">
                                Previous
                            </a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/supplier?page=${i}&keyword=${keyword}&sortField=${sortField}&sortDir=${sortDir}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/supplier?page=${currentPage + 1}&keyword=${keyword}&sortField=${sortField}&sortDir=${sortDir}">
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

            <form action="${pageContext.request.contextPath}/supplier/add" method="post">

                <div class="modal-header">
                    <h5 class="modal-title">Add Supplier</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <label>Supplier Name</label>
                    <input type="text" name="supplierName" class="form-control" required>

                    <label class="mt-2">Phone</label>
                    <input type="text" name="phone" class="form-control" required>

                    <label class="mt-2">Address</label>
                    <input type="text" name="address" class="form-control" required>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-success">Save</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>

            </form>

        </div>
    </div>
</div>

<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <form action="${pageContext.request.contextPath}/supplier/update" method="post">

                <div class="modal-header">
                    <h5 class="modal-title">Edit Supplier</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="supplierId" value="${supplier.supplierId}">

                    <label>Supplier Name</label>
                    <input type="text" name="supplierName" class="form-control" value="${supplier.supplierName}" required>

                    <label class="mt-2">Phone</label>
                    <input type="text" name="phone" class="form-control" value="${supplier.phone}" required>

                    <label class="mt-2">Address</label>
                    <input type="text" name="address" class="form-control" value="${supplier.address}" required>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-success">Update</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>

            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Controller မှ "supplier" object ပါလာမှသာ Edit Modal ကို ဖွင့်ပေးပါမည်။
    // Check if the EL expression for 'supplier' is NOT empty.
    // We use a direct EL output inside JS, which the JSP compiler safely processes.
    
    <c:if test="${supplier != null}">
    document.addEventListener('DOMContentLoaded', function() {
        var editModalElement = document.getElementById('editModal');
        // Since the element is always present now, we just initialize and show.
        if (editModalElement) {
             var editModal = new bootstrap.Modal(editModalElement);
             editModal.show();
        }
    });
    </c:if>
</script>

</body>
</html>