<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${sessionScope.isAdmin}">
        <jsp:include page="/WEB-INF/jsp/common/admin-nav.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/jsp/common/user-nav.jsp"/>
    </c:otherwise>
</c:choose>
