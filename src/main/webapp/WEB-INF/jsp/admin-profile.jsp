<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Admin Profile</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>

<body>

<jsp:include page="/WEB-INF/jsp/common/admin-nav.jsp"/>

<div class="main-content">

    <h3 class="fw-bold mb-4">👑 Admin Details</h3>

    <div class="card shadow-sm p-4" style="max-width: 500px;">

        <p><b>Name :</b> ${admin.user_fullname}</p>
        <p><b>Email :</b> ${admin.user_email}</p>
        <p><b>Phone :</b> ${admin.user_phone_number}</p>
       
<p><b>Role :</b> <span class="badge bg-danger">ADMIN</span></p>


        <hr>

        <a href="${pageContext.request.contextPath}/profile"
           class="btn btn-outline-primary">
            Edit Profile
        </a>

    </div>

</div>

</body>
</html>
