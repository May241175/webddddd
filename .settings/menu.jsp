<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<html>
<head>
    <title><tiles:getAsString name="title" /></title>
  
     <link rel ="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div class="page-wrapper">

    <div class="header"><tiles:insertAttribute name="header" /></div>

    <div class="menu"><tiles:insertAttribute name="menu" /></div>

    <div class="body"><tiles:insertAttribute name="body" /></div>

    <div class="footer"><tiles:insertAttribute name="footer" /></div>

</div>
</body>

</html>
