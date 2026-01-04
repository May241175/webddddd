<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-header">
    <h5 class="modal-title">Order Details - ${orderNumber}</h5>
    <button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
    <table class="table">
        <thead>
        <tr>
            <th>Item</th>
            <th>Qty</th>
            <th>Price</th>
            <th>Total</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="i" items="${items}">
            <tr>
                <td>${i.itemName}</td>
                <td>${i.quantity}</td>
                <td>${i.unitPrice} Ks</td>
                <td>${i.totalPrice} Ks</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <h4 class="text-end mt-3">Total: <b>${total} Ks</b></h4>
</div>

<div class="modal-footer">
    <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
</div>
