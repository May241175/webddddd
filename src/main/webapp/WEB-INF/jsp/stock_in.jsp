<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Stock In</title>
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
        
        /* Table Styling */
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
    </style>
</head>

<body class="bg-light">
<jsp:include page="/WEB-INF/jsp/common/layout.jsp"/>


    <div class="main-content">

        <div class="container-fluid mt-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                 <h3 class="fw-bold m-0">Stock In Management</h3>
                
               
            </div>

            <form method="get" action="${pageContext.request.contextPath}/stockin" class="mb-4">
                <div class="row g-2 align-items-center">
                    <div class="col-8 col-md-4">
                        <input type="text" name="keyword" value="${keyword}" class="form-control"
                               placeholder="Search by stock name or remarks...">
                    </div>
                    <div class="col-4 col-md-2">
                        <button class="btn btn-primary w-100">Search</button>
                    </div>
                </div>
            </form>

            <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addModal">
                + Add Stock In
            </button>

            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>

                        <th>
                            <a href="${pageContext.request.contextPath}/stockin?keyword=${keyword}&page=${currentPage}&sortField=stock_name&sortDir=${reverseSortDir}">
                                Stock Name
                            </a>
                        </th>

                        <th>
                            <a href="${pageContext.request.contextPath}/stockin?keyword=${keyword}&page=${currentPage}&sortField=quantity&sortDir=${reverseSortDir}">
                                Quantity
                            </a>
                        </th>

                        <th>
                            <a href="${pageContext.request.contextPath}/stockin?keyword=${keyword}&page=${currentPage}&sortField=date_in&sortDir=${reverseSortDir}">
                                Date In
                            </a>
                        </th>

                        <th>Remarks</th>
                    
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="s" items="${list}">
                        <tr>
                            <td>${s.inId}</td>
                            <td>${s.stockName}</td>
                            <td>${s.quantity}</td>
                            <td><fmt:formatDate value="${s.dateIn}" pattern="yyyy-MM-dd"/></td>
                            <td>${s.remarks}</td>
                           <!--  <td>${s.binId}</td> -->

                            <td class="text-nowrap">
                                <a href="${pageContext.request.contextPath}/stockin/edit?id=${s.inId}"
                                   class="btn btn-sm btn-warning">Edit</a>

                                <a href="${pageContext.request.contextPath}/stockin/delete?id=${s.inId}"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this record?');">
                                    Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <nav>
                <ul class="pagination">

                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/stockin?page=${currentPage - 1}&keyword=${keyword}&sortField=${sortField}&sortDir=${sortDir}">
                            Previous
                        </a>
                    </li>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/stockin?page=${i}&keyword=${keyword}&sortField=${sortField}&sortDir=${sortDir}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/stockin?page=${currentPage + 1}&keyword=${keyword}&sortField=${sortField}&sortDir=${sortDir}">
                            Next
                        </a>
                    </li>

                </ul>
            </nav>

        </div>
        
    </div> <div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <form action="${pageContext.request.contextPath}/stockin/add" method="post">

                <div class="modal-header">
                    <h5 class="modal-title">Add Stock In</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                
					<label>Stock Name</label>
					<input type="text" name="stockName" class="form-control" required>

                    <label class="mt-2">Quantity</label>
                    <input type="number" name="quantity" class="form-control" required>

                    <label class="mt-2">Date In</label>
                    <input type="date" name="dateIn" class="form-control" required>

                    <label class="mt-2">Remarks</label>
                    <input type="text" name="remarks" class="form-control">

                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Save</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>

            </form>

        </div>
    </div>
</div>

<c:if test="${stockIn != null}">
    <div class="modal fade show" id="editModal" style="display:block; background-color: rgba(0,0,0,0.5);" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">

                <form action="${pageContext.request.contextPath}/stockin/update" method="post">

                    <div class="modal-header">
                        <h5 class="modal-title">Edit Stock In</h5>
                         <a href="${pageContext.request.contextPath}/stockin" class="btn-close"></a>
                    </div>

                    <div class="modal-body">

                        <input type="hidden" name="inId" value="${stockIn.inId}"/>

                        <label>Stock Name</label>
                        <input type="text" class="form-control" value="${stockIn.stockName}" disabled>

                        <label class="mt-2">Quantity</label>
                        <input type="number" name="quantity" class="form-control"
                               value="${stockIn.quantity}" required>

                        <label class="mt-2">Date In</label>
                        <input type="date" name="dateIn"
                               value="<fmt:formatDate value='${stockIn.dateIn}' pattern='yyyy-MM-dd'/>"
                               class="form-control" required>

                        <label class="mt-2">Remarks</label>
                        <input type="text" name="remarks" class="form-control"
                               value="${stockIn.remarks}">

                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Update</button>
                        <a href="${pageContext.request.contextPath}/stockin" class="btn btn-secondary">Cancel</a>
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