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
<title>Leaves</title>
</head>
<body>
	<jsp:include page="../../header.jsp" />
		<div class="container pull-left">
			<div class="panel panel-default"
				style="width: 20%; float: left; background-color: #323232;">
				<ul class="nav nav-pills nav-stacked">
				<li class="active"><a href="manage_leaves.jsp">Leaves</a></li>
				<li><a href="manage_attendance.jsp">Attendance</a></li>
				</ul>
			</div>
			<div class="pull-right col-md-10" style="float: right; width: 80%;">
				<div>
					<p style="font-size: 16px; font-weight: 200;">Manage Leaves</p>
				</div>
				<div >
	  				<ul class="nav nav-tabs">
	  					<li  class="active"><a href="#" data-toggle="tab" id="show-holidays-tab">Show Holidays</a></li>
	    				<li><a href="#" data-toggle="tab" id="my-leaves-tab">My Leaves</a></li>
	    				<li><a href="#" data-toggle="tab" id="apply-for-leave-tab">Apply for Leave</a></li>
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
			<div id="div-my-leaves" style="margin-top: 3%">
				<div>
					<table id="my-leaves-table" class="table table-hover table-condensed">
						<thead>
							<tr>
								<th>From</th>
								<th>To</th>
								<th>Approved</th>
								<th>Approval Pending</th>
								<th>Total Days</th>
							</tr>
						</thead>
						<tbody id="my-leaves-table-body">
							
						</tbody>
					</table>
				
				</div>
			</div>
			<div id="div-apply-for-leaves" style="margin-top: 3%">
				<div>
					<form id="form-search-holidays" role="form col-md-10" action="">
						<div class="row">
							<div class="form-group col-md-4">
								<label for="">From :</label>
									<div class="input-group date" id="fromdp" data-date="12-02-2012" data-date-format="dd-mm-yyyy">
				        				<input class="form-control" id="attendance-date" type="text"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				    				</div>
							</div>
							<div class="form-group col-md-4">
								<label for="">To:</label>
									<div class="input-group date" id="todp" data-date="12-02-2012" data-date-format="dd-mm-yyyy">
				        				<input class="form-control" id="attendance-date" type="text"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				    				</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-8">
									<label for="address">Reason :</label> <textarea
								class="form-control" id="address" name="address"></textarea>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-8">
								<button id="btn-apply-leaves" type="button"
								class="btn btn-primary pull-right"">Apply</button>
							</div>
						</div>
					</form>
				</div>
			</div>
								
			</div>
		</div>
	<jsp:include page="../../footer.jsp" />
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function() {
		
		$(function () {
	        $('#fromdp').datetimepicker({
	        		defaultDate: false,
	        		format: 'DD/MM/YYYY'
	            });
	        
	        $('#todp').datetimepicker({
        		defaultDate: false,
        		format: 'DD/MM/YYYY'
            });
	    });
		
		$("#div-show-holidays").show();
		$("#div-my-leaves").hide();
		$("#div-apply-for-leaves").hide();
	
			$("#show-holidays-tab").click(function() {
				$("#div-show-holidays").show();
				$("#div-my-leaves").hide();
				$("#div-apply-for-leaves").hide();
			});
			
			$("#my-leaves-tab").click(function() {
				$("#div-my-leaves").show();
				$("#div-show-holidays").hide();
				$("#div-apply-for-leaves").hide();
			});
			
			$("#apply-for-leave-tab").click(function() {
				$("#div-apply-for-leaves").show();
				$("#div-show-holidays").hide();
				$("#div-my-leaves").hide();
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