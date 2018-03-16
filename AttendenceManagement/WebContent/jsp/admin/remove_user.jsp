<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="org.vpmpt.attendancemanage.business.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/logo.ico" />
<link	href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<title>Remove User</title>
</head>
<body>
	<jsp:include page="../../header.jsp" />
	<div class="container pull-left">
		<div class="panel panel-default" style="width: 20%; float: left; background-color: #323232;">
			<ul class="nav nav-pills nav-stacked">
			<li><a href="index.jsp">Add Attendance</a></li>
				<li><a href="add_user.jsp">Add User</a></li>
				<li class="active"><a href="remove_user.jsp">Remove User</a></li>
				<li><a href="manage_holidays.jsp">Manage Holidays</a></li>
				<li><a href="reports.jsp" >Reports</a></li>
				<li><a href="send_notifications.jsp">Send Notifications</a></li>
			</ul>
		</div>
		<div class="pull-right col-md-10" style="float: right; width: 80%;">
			<div>
				<div>
					<button id="btn-delete-user" type="button"
						class="btn btn-primary pull-right">Delete</button>
				</div>
				<p style="font-size: 16px; font-weight: 200;">Delete User</p>
			</div>
			<div>
				<p>Search By: </p>
				<form id="form-sub-add-user" role="form col-md-10" action="">
					<div class="row">
						<div class="form-group col-md-2">
							<label class="">User ID:</label> <input type="text"
								class="form-control" id="user-id" name="user-id">
						</div>
						<div class="form-group col-md-2">
							<label class="">First Name:</label> <input type="text"
								class="form-control" id="first-name" name="first-name">
						</div>
						<div class="form-group col-md-2">
							<label class="">Last Name:</label> <input type="text"
								class="form-control" id="last-name" name="last-name">
						</div>
						<div class="form-group col-md-2">
							<label class="">Email ID:</label> <input type="text"
								class="form-control" id="email-d" name="email-id">
						</div>
						<div class="form-group col-md-2">
							<button id="btn-search-user" type="button"
							class="btn btn-primary pull-right" style="margin-top: 18%;">Search</button>
						</div>
					</div>
				</form>
			</div>
			<div>
				<table id="mytb" class="table table-hover table-condensed">
					<thead>
						<tr>
							<th>Select</th>
							<th>User ID</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>Email ID</th>
							<th>Role</th>
						</tr>
					</thead>
					<tbody id="users-table-body">
						
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<jsp:include page="../../footer.jsp" />
	<script type="text/javascript">
			$(document).ready(function() {
				
				$("#btn-delete-user").click(
					function() {
						var userObj={};
						userObj.userToBeDeleted=[];
		
						$("input:checkbox").each(function(){
						    var $this = $(this);
						    if($this.is(":checked")){
						    	userObj.userToBeDeleted.push($this.attr("id"));
						    }
						});
						var userIds = ''+userObj.userToBeDeleted;
						$.ajax({type : "POST",
							url : "/AttendenceManagement/adminService",
							data : {
									usersToBeDeleted : userIds,
									requestType : "deleteUsers"
								},
								success : function(result) {
									$("input:checkbox").each(function(){
									    var $this = $(this);
									    if($this.is(":checked")){
									    	$(this).parent().parent().remove();
									    }
									});
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
				
				$("#update-success").hide();
				$("#update-success").slideUp();
				$("#btn-search-user").click(
					function() {
						$.ajax({type : "POST",
								url : "/AttendenceManagement/adminService",
								data : {
										firstName : $("#first-name").val(),
										lastName : $("#last-name").val(),
										emailId : $("#email-id").val(),
										userId : $("#user-id").val(),
										requestType : "getUsers"
										},
									success : function(result) {
										$("#users-table-body").html(result);
										
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
		
			});
	</script>
</body>
</html>