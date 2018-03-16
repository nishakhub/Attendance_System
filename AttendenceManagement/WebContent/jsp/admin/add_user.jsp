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
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/stylesheet.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />	
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker-standalone.css" rel="stylesheet" />
<title>Admin - Attendance Management System</title>
</head>
<body>
	<jsp:include page="../../header.jsp" />
	<div class="container pull-left">
		<div class="panel panel-default"
			style="width: 20%; float: left; background-color: #323232;">
			<ul class="nav nav-pills nav-stacked">
				<li><a href="add_attendance.jsp">Add Attendance</a></li>
				<li class="active"><a href="index.jsp">Add User</a></li>
				<li><a href="remove_user.jsp">Remove User</a></li>
				<li><a href="manage_holidays.jsp">Manage Holidays</a></li>
				<li><a href="reports.jsp">Reports</a></li>
				<li><a href="send_notifications.jsp">Send Notifications</a></li>
			</ul>
		</div>
		<div id="form-add-user" class="col-md-10 pull-right" style="float: right; width: 70%;">
				<p style="font-size: 16px; font-weight: 200;">Add User</p>
				<div id="update-success" class="alert alert-success">
					<!-- a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> -->
					<strong>Success!</strong> Record updated successfully.
				</div>
				<form id="form-sub-add-user" role="form col-md-10" action="">
					<div class="row">
						<div class="form-group col-md-6">
							<label class="">First Name:</label> <input type="text"
								class="form-control" id="first-name" name="first-name">
						</div>

						<div class="form-group col-md-6">
							<label class="">Last Name:</label> <input type="text" 
								class="form-control" id="last-name" name="last-name">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="">Email ID:</label> <input type="text"
								class="form-control  date-pick" id="email-id">
						</div>
						<div class="form-group col-md-6">
							<label for="">Mobile No:</label> <input type="text"
								class="form-control" id="mobile-no" name="mobile-no">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="address">Address:</label> <textarea
								class="form-control" id="address" name="address"></textarea>
						</div>
						<div class="form-group col-md-6">
							<label for="age">Age:</label> <input type="number" name="age"
								class="form-control date-pick" id="age">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="">Sex:</label> <select name="sex" id="sex" class="form-control" placeholder="Enter Sex">
								<option value="M">Male</option>
								<option value="F">Female</option>
							</select>
						</div>
						<div class="form-group col-md-6">
							<label for="">Role:</label> 
							<select name="role" class="form-control" id="select-role">
								<option value="select-role">Select Role</option>
								<option value="1">Admin</option>
								<option value="2">Staff</option>
								<option value="3">Student</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="">Designation:</label> <input type="text"
								class="form-control" id="designation" name="designation">
						</div>
						<div class="form-group col-md-6">
							<label for="">Date of Birth:</label>
								<div class="input-group date" id="dp3" data-date="12-02-2012" data-date-format="dd-mm-yyyy">
        							<input class="form-control" id="birth-date" type="text"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
    							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<button id="btn-submit-add-user" type="button"
							class="btn btn-primary pull-right">Submit</button>
						</div>
						<div class="form-group col-md-6">
							<button id="btn-clear-add-user" type="button"
							class="btn btn-primary pull-left" >Reset</button>
						</div>
					</div>
				</form>
			</div>
	</div>
	<jsp:include page="../../footer.jsp" />
	
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(function () {
                $('#dp3').datetimepicker({
                		defaultDate: false,
                		format: 'DD/MM/YYYY'
                    });
            });
			$("#update-success").hide();
			
			$("#select-role").change(function(){
				var selectval =$("#select-role").val();
				if(selectval==2){
					 $('#designation').attr('readonly', false);
				}else{
					 $('#designation').attr('readonly', true);
				}
			});
			
			$("#update-success").slideUp();
			$("#btn-submit-add-user").click(
				function() {
					$.ajax({type : "POST",
							url : "/AttendenceManagement/adminService",
							data : {firstName : $("#first-name").val(),
									lastName : $("#last-name").val(),
									dob : $("#birth-date").val(),
									sex : $("#sex").val(),
									emailId : $("#email-id").val(),
									address : $("#address").val(),
									role : $("#select-role").val(),
									age : $("#age").val(),
									designation : $("#designation").val(),
									mobileNo : $("#mobile-no").val(), 
									requestType : "addUser"},
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

			function clearAllData(){
				$("#first-name").val('');
				$("#last-name").val('');
				$("#birth-date").val('');
				$("#sex").val('M');
				$("#email-id").val('');
				$("#address").val('');
				$("#select-role").val('select-role');
				$("#age").val('');
				$("#designation").val('');
				$("#mobile-no").val('');
				};
				
				$("#btn-clear-add-user").click(
					function(){
					clearAllData();
					});
		});
</script>
</body>
</html>