<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/logo.ico" />
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />	
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker-standalone.css" rel="stylesheet" />
<title>Staff Portal</title>
</head>
<body>
	<jsp:include page="../../header.jsp" />
		<div class="container pull-left">
			<div class="panel panel-default"
				style="width: 20%; float: left; background-color: #323232;">
				<ul class="nav nav-pills nav-stacked">
					<li><a href="manage_leaves.jsp">Leaves</a></li>
					<li class="active"><a href="manage_attendance.jsp">Attendance</a></li>
					<li><a href="reports.jsp">Reports</a></li>
				</ul>
			</div>
			<div class="pull-right col-md-10" style="float: right; width: 80%;">
				<div>
					<p style="font-size: 16px; font-weight: 200;">Manage Attendance</p>
				</div>
				<div >
	  				<ul class="nav nav-tabs">
	  					<li  class="active"><a href="#" data-toggle="tab" id="add-attendance-tab">Add Attendance</a></li>
	    				<li><a href="#" data-toggle="tab" id="my-attendance-tab">My Attendance</a></li>
	  				</ul>
				</div>
				<div id="div-add-attendance" style="margin-top: 3%">
				<div>
					<form id="form-get-users" role="form col-md-10" action="">
						<div class="row">
							<div class="form-group col-md-4">
								<label for="">Attendance Date:</label>
									<div class="input-group date" id="adp" data-date="12-02-2012" data-date-format="dd-mm-yyyy">
				        				<input class="form-control" id="attendance-date" type="text"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				    				</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-4">
								<label class="">Select Users:</label> 
								<select name="role" class="form-control" id="select-role">
									<option value="all">All</option>
									<option value="admin">Admin</option>
									<option value="staff">Staff</option>
									<option value="student">Student</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label class="">Class (Only for Students):</label> <input type="text" 
									class="form-control" id="student-class" name="student-class">
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
								<th>User ID</th>
								<th>Name</th>
								<th>Role</th>
								<th>Designation</th>
								<th>Present</th>
							</tr>
						</thead>
						<tbody id="users-table-body">
							<jsp:useBean id="userBean" scope="request"
								class="org.vpmpt.attendancemanage.business.User">
							</jsp:useBean>
							<c:set var="userList" value="${userBean.userList}"></c:set>
							<c:choose>
								<c:when test= "${fn:length(userList) gt 0}">
									<c:forEach items="${userList}" varStatus="i" var="userDTO">
										<tr>
											<td>${userDTO.userId}</td>
											<td>${userDTO.firstName} ${userDTO.lastName}</td>
											<c:choose>
												<c:when test= "${userDTO.role eq 1}">
													<td>Admin</td>
												</c:when>
												<c:when test= "${userDTO.role eq 2}">
													<td>Staff</td>
												</c:when>
												<c:otherwise>
													<td>Student</td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test= "${userDTO.designation ne null}">
													<td>${userDTO.designation}</td>
												</c:when>
												<c:otherwise>
													<td>-</td>
												</c:otherwise>
											</c:choose>
											<td class="vcenter"><input type="checkbox" id="${userDTO.userId}" value="1" /></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div colspan="6" style="font-size: 60; font-weight: bold; text-align: center; margin-top: 20%;">No Data found</div>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		
			<div id="div-my-attendance" style="margin-top: 3%">
					<form id="form-my-attendance" role="form col-md-10" action="">
					
					</form>
				</div>
			</div>
		</div>
	<jsp:include page="../../footer.jsp" />
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript">
			$(document).ready(function() {
				$("#div-add-attendance").show();
				$("#div-my-attendance").hide();

				$("#add-attendance-tab").click(function() {
					$("#div-add-attendance").show();
					$("#div-my-attendance").hide();
				});
				
				$("#my-attendance-tab").click(function() {
					$("#div-add-attendance").hide();
					$("#div-my-attendance").show();
				});
				
				$(function () {
			        $('#adp').datetimepicker({
			        		defaultDate: false,
			        		format: 'DD/MM/YYYY'
			            });
			    });
				
				$("#btn-submit-attendance").click(
						function() {
							var userObj={};
							userObj.usersPresent=[];
			
							$("input:checkbox").each(function(){
							    var $this = $(this);
							    if($this.is(":checked")){
							    	userObj.usersPresent.push($this.attr("id"));
							    }
							});
							var userIds = ''+userObj.usersPresent;
							alert(userIds+' '+$("#attendance-date").val());
							$.ajax({type : "POST",
								url : "/AttendenceManagement/adminService",
								data : {
										userIdsPresent : userIds,
										attendanceDate : $("#attendance-date").val(),
										requestType : "addAttendance"
									},
									success : function(result) {
										alert("Attendence Added Successfully!");
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
				
				$("#btn-search-user").click(
						function() {
							$.ajax({type : "POST",
									url : "/AttendenceManagement/adminService",
									data : {
											userType : $("#").val(),
											studentClass : $("#").val(),
											requestType : "getUsersForAttendance"
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