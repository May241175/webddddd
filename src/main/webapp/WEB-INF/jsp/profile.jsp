<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f8f9fa;
        }

        /* ===== SIDEBAR ===== */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100vh;
            background: #ffffff;
            border-right: 1px solid #e0e0e0;
            padding-top: 60px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        }

        .store-title {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            padding: 15px;
            font-size: 20px;
            font-weight: 700;
            color: #0d6efd;
            background: #fff;
            border-bottom: 1px solid #e0e0e0;
            z-index: 1000;
        }

        .sidebar a {
            display: block;
            padding: 12px 15px;
            color: #343a40;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }

        .sidebar a:hover {
            background: #e6f7ff;
            color: #0d6efd;
            border-left: 4px solid #0d6efd;
            padding-left: 11px;
        }

        /* ===== MAIN CONTENT ===== */
        .main-content {
            margin-left: 250px;
            padding: 30px;
        }

        /* ===== CARDS ===== */
        .card {
            border-radius: 12px;
            border: none;
        }

        .section-title {
            font-weight: 700;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/jsp/common/layout.jsp"/>

<div class="main-content">

    <h3 class="fw-bold mb-4">My Profile</h3>

    <!-- ALERTS -->
    <c:if test="${param.updated == 1}">
        <div class="alert alert-success">Profile updated successfully!</div>
    </c:if>

    <c:if test="${param.password_changed == 1}">
        <div class="alert alert-success">Password changed successfully!</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="row g-4">

        <!-- LEFT : PROFILE INFO -->
        <div class="col-lg-7">

            <div class="card p-4 shadow-sm">
                <h5 class="section-title">👤 Personal Information</h5>

                <form action="${pageContext.request.contextPath}/profile/update"
                      method="post">

                    <label>Name</label>
                    <input name="name"
                           class="form-control mb-3"
                           value="${profile.user_fullname}" required>

                    <label>Email</label>
                    <input name="email"
                           class="form-control mb-3"
                           value="${profile.user_email}" required>

                    <label>Phone</label>
                    <input name="phone"
                           class="form-control mb-3"
                           value="${profile.user_phone_number}" required>

                    <button class="btn btn-primary">
                        Update Profile
                    </button>
                </form>
            </div>

        </div>

        <!-- RIGHT : CHANGE PASSWORD -->
        <div class="col-lg-5">

            <div class="card p-4 shadow-sm">
                <h5 class="section-title">🔐 Change Password</h5>

                <form action="${pageContext.request.contextPath}/profile/password"
                      method="post">

                    <label>Old Password</label>
                    <input type="password"
                           name="old_password"
                           class="form-control mb-3" required>

                    <label>New Password</label>
                    <input type="password"
                           name="new_password"
                           class="form-control mb-3" required>

                    <button class="btn btn-dark w-100">
                        Change Password
                    </button>
                </form>
            </div>

        </div>

    </div>
</div>

</body>
</html>
