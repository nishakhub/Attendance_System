<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Student Portal</title>
</head>
<body>
	<jsp:include page="../../header.jsp" />
		<div class="container pull-left">
			<div class="panel panel-default"
				style="width: 20%; float: left; background-color: #323232;">
				<ul class="nav nav-pills nav-stacked">
					<li><a href="manage_leaves.jsp">Leaves</a></li>
					<li class="active"><a href="manage_attendance.jsp">Attendance</a></li>
				</ul>
			</div>
			<div class="pull-right col-md-10" style="float: right; width: 80%;">
				<div>
					<p style="font-size: 16px; font-weight: 200;">Attendance</p>
				</div>
				<div >
	  				<ul class="nav nav-tabs">
	    				<li class="active"><a href="#" data-toggle="tab" id="my-leaves-tab">My Attendance</a></li>
	  				</ul>
				</div>
			</div>
		</div>

	<jsp:include page="../../footer.jsp" />
</body>
</html>