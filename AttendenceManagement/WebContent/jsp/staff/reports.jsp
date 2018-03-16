<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="org.vpmpt.attendancemanage.business.Report"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Reports</title>
</head>
<jsp:useBean id="reportBean" scope="request"
	class="org.vpmpt.attendancemanage.business.Report">
	<jsp:setProperty name="reportBean" property="userDTO"
		value="${sessionScope.user}" />
</jsp:useBean>
<body>
	<jsp:include page="../../header.jsp" />
<div class="container pull-left">
		<div class="panel panel-default"
			style="width: 20%; float: left; background-color: #323232;">
			<ul class="nav nav-pills nav-stacked">
					<li><a href="manage_leaves.jsp">Leaves</a></li>
					<li><a href="manage_attendance.jsp">Attendance</a></li>
					<li class="active"><a href="reports.jsp">Reports</a></li>
				</ul>
		</div>
		<div class="pull-right col-md-10" style="float: right; width: 80%;">
			<div>
				<div>
					<button id="btn-delete-user" type="button"
						class="btn btn-primary pull-right">Export to Excel</button>
				</div>
				<p style="font-size: 16px; font-weight: 200;">Get Report</p>
			</div>
			<div id="div-add-attendance" style="margin-top: 3%">
				<div>
					<form id="form-get-users" role="form col-md-10" action="">
						<div class="row">
							<div class="form-group col-md-4">
								<label class="">Select Class:</label> 
								<select name="role" class="form-control" id="select-class">
								<c:set var="subMap" value="${reportBean.teacherInfo.classSubjectMap}"></c:set>
									<c:forEach items="${subMap}" var="entry" >
									        <option value="${entry.key}">${entry.key}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label class="">Select Subject:</label> 
								<select name="subject" class="form-control" id="select-subject">
									<option value="4">Java</option>
									<option value="5">Advance Java</option>
									<option value="3">C Language</option>
								</select>
							</div>
							<div class="form-group col-md-2">
								<button id="btn-get-report" type="button"
								class="btn btn-primary pull-right" style="margin-top: 18%;">Get Report</button>
							</div>
						</div>
					</form>
				</div>
				<div>
					<table id="mytb" class="table table-hover table-condensed">
						<thead>
							<tr>
								<th>User ID</th>
								<th>Name</th>
								<th>Total Days</th>
								<th>Present Days</th>
								<th>Percentage</th>
							</tr>
						</thead>
						<tbody id="users-table-body">
							 
						</tbody>
						</table>
					</div>
				</div>
			</div>
	</div>
	<jsp:include page="../../footer.jsp" />
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btn-get-report").click(
				function() {
					$.ajax({type : "POST",
							url : "/AttendenceManagement/adminService",
							data : {
									className : $("#select-class").val(),
									subject : $("#select-subject").val(),
									requestType : "getReport"},
								success : function(result) {
									/*$("#update-success").show();*/
									clearAllData();
									$("#update-success").slideDown();
									/*$("#update-success").fadeOut(1000);*/
									setTimeout(function(){
									$("#update-success").slideUp();
										/*$("#update-success").hide();*/
									}, 2500);
									
								},
								error : function(xmlHttpRequest) {
									// Show the error.
									alert('error is '+xmlHttpRequest.status);
									switch (xmlHttpRequest.status) {
									case 404:
										
										break;
									case 400:
										
										break;
									
									case 1000:
										window.location.href = "/DisApp/index.jsp";
										break;
									}
								}
							});
				});
			
			
			 /*	$("#select-class").change(function () {
			   var htmlTextToChange = '';
			    	var mapval = ${subMap};
			    	alert(mapval);
			    	var selectedVal  = $("#select-class").val();
			        $("#select-subject").html(htmlTextToChange); 
			    });*/
		});
</script>
</body>
</html>