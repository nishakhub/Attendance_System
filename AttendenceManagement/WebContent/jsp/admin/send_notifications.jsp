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
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/logo.ico" />
<title>Admin Notifications</title>
</head>
<body>
	<jsp:include page="../../header.jsp" />
	<div class="container pull-left">
		<div class="panel panel-default"
			style="width: 20%; float: left; background-color: #323232;">
			<ul class="nav nav-pills nav-stacked">
				<li><a href="index.jsp">Add Attendance</a></li>
				<li><a href="add_user.jsp">Add User</a></li>
				<li><a href="remove_user.jsp">Remove User</a></li>
				<li><a href="manage_holidays.jsp">Manage Holidays</a></li>
				<li><a href="reports.jsp">Reports</a></li>
				<li class="active"><a href="send_notifications.jsp">Send Notifications</a></li>
			</ul>
		</div>
		<div class="pull-right col-md-10" style="float: right; width: 80%;">
			<div>
				<p style="font-size: 16px; font-weight: 200;">Send Notifications</p>
			</div>
			<div id="update-success" class="alert alert-success">
				<!-- a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> -->
				<strong>Success!</strong> Record updated successfully.
			</div>
			<div >
  				<ul class="nav nav-tabs">
  					<li class="active"><a href="#" data-toggle="tab" id="tab-notification">Send Notification</a></li>
    				<li><a href="#" data-toggle="tab" id="tab-broadcast">Send Broadcast</a></li>
  				</ul>
			</div>
			<div id="div-notification" style="margin-top: 3%">
				<form id="form-notification" role="form col-md-10" action="">
					<div class="row">
						<div class="form-group col-md-4">
							<label for="">User Id:</label> <input type="text"
								class="form-control" id="user-id" name="user-id">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-10">
							<label for="">Subject:</label> <input class="form-control"
								id="notification-subject" type="text">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-10">
							<label for="content">Content:</label>
							<textarea class="form-control" id="notification-content"
								name="notification-content"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-10">
							<button id="btn-send-notification" type="button"
								class="btn btn-primary pull-left">Send</button>
						</div>
					</div>
				</form>
			</div>
			<div id="div-broadcast" style="margin-top: 3%">
				<form id="form-broadcast" role="form col-md-10" action="">
					<div class="row">
						<div class="form-group col-md-10">
							<label for="subject">Subject:</label> <input class="form-control"
								id="broadcast-subject" type="text">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-10">
							<label for="content">Content:</label>
							<textarea class="form-control" id="broadcast-content"
								name="broadcast-content"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-10">
							<button id="btn-send-broadcast" type="button"
								class="btn btn-primary pull-left">Send</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
<jsp:include page="../../footer.jsp" />
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(function() {
				$('#dph').datetimepicker({
					defaultDate : false,
					format : 'DD/MM/YYYY'
				});
			});

			$("#update-success").hide();
			$("#update-success").slideUp();
			$("#div-broadcast").hide();
			
			$("#tab-notification").click(function() {
				$("#div-notification").show();
				$("#div-broadcast").hide();
			});
			
			$("#tab-broadcast").click(function() {
				$("#div-broadcast").show();
				$("#div-notification").hide();
			});
			
			$("#btn-send-notification").click(

			function() {
				$.ajax({
					type : "POST",
					url : "/AttendenceManagement/adminService",
					data : {
						userId : $("#user-id").val(),
						subject : $("#notification-subject").val(),
						content : $("#notification-content").val(),
						type : "N",
						requestType : "sendNotification"
					},
					success : function(result) {
						clearAllData();
						$("#update-success").slideDown();
						setTimeout(function() {
							$("#update-success").slideUp();
						}, 2500);

					},
					error : function(xmlHttpRequest) {
						// Show the error.
						alert('error is ' + xmlHttpRequest.status);
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
			
	
		$("#btn-send-broadcast").click(

			function() {
				$.ajax({
					type : "POST",
					url : "/AttendenceManagement/adminService",
					data : {
						subject : $("#broadcast-subject").val(),
						content : $("#broadcast-content").val(),
						type :"B",
						requestType : "sendBroadcast"
					},
					success : function(result) {
						$("#holiday-table-body").html(result);
					},
					error : function(xmlHttpRequest) {
						// Show the error.
						alert('error is ' + xmlHttpRequest.status);
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

		});
	</script>
</body>
</html>