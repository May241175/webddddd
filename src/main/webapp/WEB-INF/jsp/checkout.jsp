<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>

<body class="bg-light">
<jsp:include page="/WEB-INF/jsp/common/layout.jsp"/>

<div class="container mt-4">

    <h3 class="fw-bold mb-4">🛒 Checkout</h3>

    <!-- USER INFO -->
    <div class="card mb-3 p-3">
        <h5>👤 Your Information</h5>
        <p><b>Name:</b> ${user.user_fullname}</p>
        <p><b>Email:</b> ${user.user_email}</p>
        <p><b>Phone:</b> ${user.user_phone_number}</p>
    </div>

    <!-- CHECKOUT FORM -->
    <form action="${pageContext.request.contextPath}/checkout/place" method="post">

        <!-- DELIVERY ADDRESS -->
        <div class="card mb-3 p-3">
            <h5>📍 Delivery Address</h5>

            <c:choose>
                <c:when test="${not empty addresses}">
                    <c:forEach var="a" items="${addresses}">
                        <label class="d-block border rounded p-2 mb-2 bg-light">

                            <input type="radio"
                                   name="addressId"
                                   value="${a.addressId}"
                                   <c:if test="${a.isDefault}">checked</c:if>
                                   required />

                            <b>${a.fullName}</b><br>
                            ${a.phone}<br>
                            ${a.addressLine}, ${a.city}, ${a.region}

                            <button type="button"
                                    class="btn btn-sm btn-outline-primary ms-2"
                                    data-bs-toggle="modal"
                                    data-bs-target="#editModal${a.addressId}">
                                Edit
                            </button>
                        </label>
                    </c:forEach>

                    <button type="button"
                            class="btn btn-sm btn-outline-success"
                            data-bs-toggle="modal"
                            data-bs-target="#addModal">
                        + Add New Address
                    </button>
                </c:when>

                <c:otherwise>
                    <div class="alert alert-warning">
                        No delivery address found.
                        <button type="button"
                                class="btn btn-sm btn-primary ms-2"
                                data-bs-toggle="modal"
                                data-bs-target="#addModal">
                            Add Address
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- PAYMENT -->
        <div class="card mb-3 p-3">
            <h5>💳 Payment Method</h5>
            <select name="payment" class="form-select" required>
                <option value="Cash">Cash</option>
                <option value="KBZ Pay">KBZ Pay</option>
                <option value="Wave Pay">Wave Pay</option>
                <option value="Card">Card</option>
            </select>
        </div>

        <!-- ORDER SUMMARY -->
        <div class="card mb-3 p-3">
            <h5>🧾 Order Summary</h5>

            <c:forEach var="c" items="${cartItems}">
                <div class="d-flex justify-content-between">
                    <span>${c.itemName} (x${c.quantity})</span>
                    <span>${c.totalPrice} Ks</span>
                </div>
            </c:forEach>

            <hr>
            <div class="d-flex justify-content-between fw-bold text-success">
                <span>Total</span>
                <span>${total} Ks</span>
            </div>
        </div>

        <button type="submit" class="btn btn-success btn-lg w-100">
            ✓ Place Order
        </button>

    </form>
</div>

<!-- ================= EDIT ADDRESS MODALS ================= -->
<c:forEach var="a" items="${addresses}">
<div class="modal fade" id="editModal${a.addressId}" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/address/edit" method="post">
                <div class="modal-header">
                    <h5>Edit Address</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="addressId" value="${a.addressId}">
                    <input class="form-control mb-2" name="fullName" value="${a.fullName}" required>
                    <input class="form-control mb-2" name="phone" value="${a.phone}" required>
                    <textarea class="form-control mb-2" name="addressLine" required>${a.addressLine}</textarea>
                    <input class="form-control mb-2" name="city" value="${a.city}" required>
                    <input class="form-control" name="region" value="${a.region}" required>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
</c:forEach>

<!-- ================= ADD ADDRESS MODAL ================= -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/address/add" method="post">
                <div class="modal-header">
                    <h5>Add Address</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input class="form-control mb-2" name="fullName" placeholder="Full Name" required>
                    <input class="form-control mb-2" name="phone" placeholder="Phone" required>
                    <textarea class="form-control mb-2" name="addressLine" placeholder="Address" required></textarea>
                    <input class="form-control mb-2" name="city" placeholder="City" required>
                    <input class="form-control" name="region" placeholder="Region" required>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-success">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
