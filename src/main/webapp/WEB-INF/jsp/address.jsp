<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>My Addresses</title>
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

    <h3 class="store-title">Ngwe Pone Gyi Sale</h3> 

    <div class="sidebar">

        <div class="sidebar-title">Your Shop Menu</div>

        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/products">Browse Products</a>
        <a href="${pageContext.request.contextPath}/cart">My Cart</a>
        <a href="${pageContext.request.contextPath}/order-history">Order History</a>
        <a href="${pageContext.request.contextPath}/address">User Address</a>
        
        <a href="${pageContext.request.contextPath}/logout" >Logout</a>

        <div class="sidebar-title mt-4">Warehouse Management</div>
        
        <a href="${pageContext.request.contextPath}/profile">Profile</a>
        <a href="${pageContext.request.contextPath}/customer">Customer</a>
        <a href="${pageContext.request.contextPath}/stockin">Stock In</a>
        <a href="${pageContext.request.contextPath}/stockout/report">Stock Out Report</a>
        <a href="${pageContext.request.contextPath}/stockbalance/report">Stock Balance Report</a>
        <a href="${pageContext.request.contextPath}/supplier">Supplier</a>

    </div>

    <div class="main-content">

        <div class="container-fluid mt-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                 <h3 class="fw-bold m-0">My Addresses</h3>
               
            </div>
            
            <button class="btn btn-primary mb-4" data-bs-toggle="modal" data-bs-target="#addModal">
                Add New Address
            </button>

            <table class="table table-bordered table-hover shadow-sm bg-white">
                <thead class="table-dark">
                <tr>
                    <th>Full Name</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th width="150">Action</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="a" items="${addresses}">
                    <tr>
                        <td>${a.fullName}</td>
                        <td>${a.phone}</td>
                        <td>
                            ${a.addressLine}<br>
                            ${a.city}, ${a.region}
                        </td>

                        <td>
                            <button class="btn btn-warning btn-sm"
                                    data-bs-toggle="modal"
                                    data-bs-target="#editModal${a.addressId}">
                                Edit
                            </button>

                            <a href="${pageContext.request.contextPath}/address/delete?id=${a.addressId}"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Delete this address?')">
                                Delete
                            </a>
                        </td>
                    </tr>

                    <div class="modal fade" id="editModal${a.addressId}" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <form action="${pageContext.request.contextPath}/address/edit" method="post">

                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit Address</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>

                                    <div class="modal-body">

                                        <input type="hidden" name="addressId" value="${a.addressId}"/>

                                        <label>Full Name</label>
                                        <input type="text" name="fullName" class="form-control"
                                               value="${a.fullName}" required>

                                        <label class="mt-2">Phone</label>
                                        <input type="text" name="phone" class="form-control"
                                               value="${a.phone}" required>

                                        <label class="mt-2">Address Line</label>
                                        <textarea name="addressLine" class="form-control"
                                                  required>${a.addressLine}</textarea>

                                        <label class="mt-2">City</label>
                                        <select name="city" class="form-control" required>
                                            <option ${a.city == 'Yangon' ? 'selected' : ''}>Yangon</option>
                                            <option ${a.city == 'Mandalay' ? 'selected' : ''}>Mandalay</option>
                                            <option ${a.city == 'Naypyidaw' ? 'selected' : ''}>Naypyidaw</option>
                                            <option ${a.city == 'Mawlamyine' ? 'selected' : ''}>Mawlamyine</option>
                                            <option ${a.city == 'Taunggyi' ? 'selected' : ''}>Taunggyi</option>
                                            <option ${a.city == 'Bago' ? 'selected' : ''}>Bago</option>
                                            <option ${a.city == 'Magway' ? 'selected' : ''}>Magway</option>
                                            <option ${a.city == 'Sittwe' ? 'selected' : ''}>Sittwe</option>
                                            <option ${a.city == 'Pathein' ? 'selected' : ''}>Pathein</option>
                                        </select>

                                        <label class="mt-2">Region / State</label>
                                        <select name="region" class="form-control" required>
                                            <option ${a.region == 'Yangon Region' ? 'selected' : ''}>Yangon Region</option>
                                            <option ${a.region == 'Mandalay Region' ? 'selected' : ''}>Mandalay Region</option>
                                            <option ${a.region == 'Bago Region' ? 'selected' : ''}>Bago Region</option>
                                            <option ${a.region == 'Magway Region' ? 'selected' : ''}>Magway Region</option>
                                            <option ${a.region == 'Sagaing Region' ? 'selected' : ''}>Sagaing Region</option>
                                            <option ${a.region == 'Tanintharyi Region' ? 'selected' : ''}>Tanintharyi Region</option>
                                            <option ${a.region == 'Ayeyarwady Region' ? 'selected' : ''}>Ayeyarwady Region</option>
                                            <option ${a.region == 'Shan State' ? 'selected' : ''}>Shan State</option>
                                            <option ${a.region == 'Kachin State' ? 'selected' : ''}>Kachin State</option>
                                            <option ${a.region == 'Kayah State' ? 'selected' : ''}>Kayah State</option>
                                            <option ${a.region == 'Kayin State' ? 'selected' : ''}>Kayin State</option>
                                            <option ${a.region == 'Chin State' ? 'selected' : ''}>Chin State</option>
                                            <option ${a.region == 'Mon State' ? 'selected' : ''}>Mon State</option>
                                            <option ${a.region == 'Rakhine State' ? 'selected' : ''}>Rakhine State</option>
                                        </select>

                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">Close</button>
                                        <button class="btn btn-primary">Save Changes</button>
                                    </div>

                                </form>

                            </div>
                        </div>
                    </div>

                </c:forEach>
                </tbody>

            </table>

        </div>
        
    </div> <div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <form action="${pageContext.request.contextPath}/address/add" method="post">

                <div class="modal-header">
                    <h5 class="modal-title">Add New Address</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <label>Full Name</label>
                    <input type="text" name="fullName" class="form-control" required>

                    <label class="mt-2">Phone</label>
                    <input type="text" name="phone" class="form-control" required>

                    <label class="mt-2">Address Line</label>
                    <textarea name="addressLine" class="form-control" required></textarea>

                    <label class="mt-2">City</label>
                    <select name="city" class="form-control" required>
                        <option value="">-- Select City --</option>
                        <option>Yangon</option>
                        <option>Mandalay</option>
                        <option>Naypyidaw</option>
                        <option>Mawlamyine</option>
                        <option>Taunggyi</option>
                        <option>Bago</option>
                        <option>Magway</option>
                        <option>Sittwe</option>
                        <option>Pathein</option>
                    </select>

                    <label class="mt-2">Region / State</label>
                    <select name="region" class="form-control" required>
                        <option value="">-- Select Region/State --</option>
                        <option>Yangon Region</option>
                        <option>Mandalay Region</option>
                        <option>Bago Region</option>
                        <option>Magway Region</option>
                        <option>Sagaing Region</option>
                        <option>Tanintharyi Region</option>
                        <option>Ayeyarwady Region</option>
                        <option>Shan State</option>
                        <option>Kachin State</option>
                        <option>Kayah State</option>
                        <option>Kayin State</option>
                        <option>Chin State</option>
                        <option>Mon State</option>
                        <option>Rakhine State</option>
                    </select>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Cancel</button>
                    <button class="btn btn-primary">Save Address</button>
                </div>

            </form>

        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>