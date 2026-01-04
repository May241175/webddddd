<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body class="bg-light">

<div class="container mt-5" style="max-width:600px;">
    
    <h3 class="mb-4">Edit Product</h3>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary btn-sm mb-3">&laquo; Back</a>

    <form action="${pageContext.request.contextPath}/product/update"
          method="post"
          enctype="multipart/form-data"
          class="card p-4 shadow">

        <input type="hidden" name="stockId" value="${product.stockId}"/>

        <div class="mb-3">
            <label>Item ID</label>
            <input type="number" name="itemId" class="form-control" value="${product.itemId}" required>
        </div>

        <div class="mb-3">
            <label>Stock Name</label>
            <input type="text" name="stockName" class="form-control" value="${product.stockName}" required>
        </div>

        <div class="mb-3">
            <label>Stock Location</label>
            <input type="text" name="stockLocation" class="form-control" value="${product.stockLocation}" required>
        </div>

        <div class="mb-3">
            <label>Stock Remark</label>
            <input type="text" name="stockRemark" class="form-control" value="${product.stockRemark}">
        </div>

        <div class="mb-3">
            <label>Current Image</label><br>
            <img src="${pageContext.request.contextPath}/resources/product-images/${p.productImage}"
     style="height:60px; width:60px; object-fit:cover;">

        </div>

        <div class="mb-3">
            <label>Change Image (optional)</label>
            <input type="file" name="image" class="form-control">
        </div>

        <button class="btn btn-primary w-100">Update Product</button>
    </form>

</div>

</body>
</html>
