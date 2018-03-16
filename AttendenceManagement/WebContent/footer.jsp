<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<c:set var="loc" value="en_US"/>
<%
	String contextPath = request.getContextPath();

	String locale = (String) session.getAttribute("locale");
	if (locale != null) {
%>
<fmt:setLocale value="<%=locale%>" />
<%
	}
%>
<fmt:bundle basename="app">
<head>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/stylesheet.css" rel="stylesheet" />
</head>
<body>
		<footer id="footer" class="footer-wrapper">
		</footer>
</body>
</fmt:bundle>
</html>