<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>

<body class="bg-light">

<div class="container mt-5" style="max-width:450px;">
    <h3 class="text-center mb-3">Create Account</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="register" method="post" class="card p-4 shadow">

        <label>Username</label>
        <input type="text" name="user_name" class="form-control mb-3" required>

        <label>Email</label>
        <input type="email" name="user_email" class="form-control mb-3" required>

        <label>Password</label>
        <input type="password" name="user_password" class="form-control mb-3" required>

        <label>Full Name</label>
        <input type="text" name="user_fullname" class="form-control mb-3">

        <label>Phone</label>
        <input type="text" name="user_phone_number" class="form-control mb-3">

        <button class="btn btn-success w-100">Register</button>

        <p class="text-center mt-3">
            Already have an account?
            <a href="login">Login</a>
        </p>

    </form>
</div>

</body>
</html>
