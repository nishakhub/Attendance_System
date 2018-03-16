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
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />	
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker-standalone.css" rel="stylesheet" />
<title>Manage Holidays</title>
</head>
<body>
	<jsp:include page="../../header.jsp" />
		<div class="container pull-left">
		<div class="panel panel-default" style="width: 20%; float: left; background-color: #323232;">
			<ul class="nav nav-pills nav-stacked">
				<li><a href="index.jsp">Add Attendance</a></li>
				<li><a href="add_user.jsp" >Add User</a></li>
				<li><a href="remove_user.jsp">Remove User</a></li>
				<li class="active"><a href="manage_holidays.jsp">Manage Holidays</a></li>
				<li><a href="reports.jsp" >Reports</a></li>
				<li><a href="send_notifications.jsp">Send Notifications</a></li>
			</ul>
		</div>
		<div class="pull-right col-md-10" style="float: right; width: 80%;">
			<div>
				<p style="font-size: 16px; font-weight: 200;">Manage Holidays</p>
			</div>
			<div id="update-success" class="alert alert-success">
				<!-- a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> -->
				<strong>Success!</strong> Record updated successfully.
			</div>
			<div >
  				<ul class="nav nav-tabs">
  					<li  class="active"><a href="#" data-toggle="tab" id="show-holidays-tab">Show Holidays</a></li>
    				<li><a href="#" data-toggle="tab" id="add-holidays-tab">Add Holiday</a></li>
  				</ul>
			</div>
			<div id="div-show-holidays" style="margin-top: 3%">
				<div>
					<form id="form-search-holidays" role="form col-md-10" action="">
						<div class="row">
							<div class="form-group col-md-2">
								<label for="">Search Holidays: </label> 
								<select name="select-holiday-year" class="form-control" id="select-holiday-year">
									<option value="select-year">Select Year</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
								</select>
							</div>
							<div class="form-group col-md-2">
								<button id="btn-search-holiday" type="button"
								class="btn btn-primary pull-right" style="margin-top: 18%;">Search</button>
							</div>
						</div>
					</form>
				</div>
				<div>
					<table id="mytb" class="table table-hover table-condensed">
						<thead>
							<tr>
								<th>Date</th>
								<th>Description</th>
							</tr>
						</thead>
						<tbody id="holiday-table-body">
							
						</tbody>
					</table>
				</div>
			</div>
		
			<div id="div-add-holiday" style="margin-top: 3%">
				<form id="form-add-holiday" role="form col-md-10" action="">
					<div class="row">
						<div class="form-group col-md-4">
							<label for="">Holiday Date:</label>
								<div class="input-group date" id="dph">
        							<input class="form-control" id="holiday-date" type="text"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
    							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-10">
							<label for="address">Description:</label> <textarea
								class="form-control" id="holiday-discription" name="holiday-discription"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-10">
							<button id="btn-add-holiday" type="button"
							class="btn btn-primary pull-left" >Submit</button>
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
			$("#div-add-holiday").hide();
			
			$("#add-holidays-tab").click(function() {
				$("#div-add-holiday").show();
				$("#div-show-holidays").hide();
			});
			
			$("#show-holidays-tab").click(function() {
				$("#div-show-holidays").show();
				$("#div-add-holiday").hide();
			});
			
			
			$("#btn-add-holiday").click(
			function() {
				$.ajax({
					type : "POST",
					url : "/AttendenceManagement/adminService",
					data : {
						holidayDate : $("#holiday-date").val(),
						holidayDiscription : $("#holiday-discription").val(),
						requestType : "addHoliday"
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
			
	
		$("#btn-search-holiday").click(

			function() {
				$.ajax({
					type : "POST",
					url : "/AttendenceManagement/adminService",
					data : {
						year : $("#select-holiday-year").val(),
						requestType : "getHolidays"
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