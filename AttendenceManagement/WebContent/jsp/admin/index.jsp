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
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />	
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker-standalone.css" rel="stylesheet" />
<title>Add Attendance</title>
</head>
<jsp:useBean id="reportBean" scope="request"
	class="org.vpmpt.attendancemanage.business.Report">
	<jsp:setProperty name="reportBean" property="userDTO"
		value="${sessionScope.user}" />
</jsp:useBean>
<body>
<body>
	<jsp:include page="../../header.jsp" />
		<div class="container pull-left">
			<div class="panel panel-default"
				style="width: 20%; float: left; background-color: #323232;">
				<ul class="nav nav-pills nav-stacked">
					<li class="active"><a href="index.jsp">Add	Attendance</a></li>
					<li><a href="add_user.jsp">Add User</a></li>
					<li><a href="remove_user.jsp">Remove	User</a></li>
					<li><a href="manage_holidays.jsp">Manage Holidays</a></li>
					<li><a href="reports.jsp" >Reports</a></li>
					<li><a href="send_notifications.jsp" >Send Notifications</a></li>
				</ul>
			</div>
			<div class="pull-right col-md-10" style="float: right; width: 80%;">
			<div >
  				<ul class="nav nav-tabs">
  					<li class="active"><a href="#" data-toggle="tab" id="tab-bulk-attendance">Bulk Attendance</a></li>
  					<li><a href="#" data-toggle="tab" id="tab-attendance">Add Attendance</a></li>
    				
  				</ul>
			</div>
			<div id="tab-attendance-div" style="margin-top: 3%;">
			<div>
				<div>
					<button id="btn-submit-attendance" type="button"
						class="btn btn-primary pull-right">Submit</button>
				</div>
				<p style="font-size: 16px; font-weight: 200;">Add Attendance</p>
			</div>
				<div>
					<form id="form-get-users" role="form col-md-10" action="">
						<div class="row">
							<div class="form-group col-md-4">
								<label for="">Attendance Date:</label>
									<div class="input-group date" id="adp" data-date="12-02-2012" data-date-format="dd-mm-yyyy">
				        				<input class="form-control" id="attendance-date" type="text"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				    				</div>
							</div>
							<div class="form-group col-md-4">
								<label for="">From : </label>
								<div class="input-group bootstrap-timepicker timepicker" id="fromtimepick">
									<input id="fromtime" type="text"
										class="form-control input-small"> <span
										class="input-group-addon"><i
										class="glyphicon glyphicon-time"></i></span>
								</div>
							</div>
							<div class="form-group col-md-4">
								<label for="">To : </label>
								<div class="input-group bootstrap-timepicker timepicker" id="totimepick">
									<input id="totime" type="text"
										class="form-control input-small"> <span
										class="input-group-addon"><i
										class="glyphicon glyphicon-time"></i></span>
								</div>
							</div>
						</div>
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
			<div id="tab-bulk-attendance-div" style="margin-top: 3%;">
				<form id="form-bulk-attendance" role="form col-md-10">
						<div class="row">
							<div class="form-group col-md-4">
								<label for="">Attendance Date:</label>
								<div class="input-group date" id="bulkadp" data-date="12-02-2012"
									data-date-format="dd-mm-yyyy">
									<input class="form-control" id="attendance-date-bulk" type="text">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-calendar"></i></span>
								</div>
							</div>
							<div class="form-group col-md-4">
								<label for="">From : </label>
								<div class="input-group bootstrap-timepicker timepicker" id="fromtimepickbulk">
									<input id="fromtimebulk" type="text"
										class="form-control input-small"> <span
										class="input-group-addon"><i
										class="glyphicon glyphicon-time"></i></span>
								</div>
							</div>
							<div class="form-group col-md-4">
								<label for="">To : </label>
								<div class="input-group bootstrap-timepicker timepicker" id="totimepickbulk">
									<input id="totimebulk" type="text"
										class="form-control input-small"> <span
										class="input-group-addon"><i
										class="glyphicon glyphicon-time"></i></span>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-4">
								<label class="">Select Class:</label> 
								<select name="role" class="form-control" id="select-class-bulk">
								<c:set var="subMap" value="${reportBean.teacherInfo.classSubjectMap}"></c:set>
									<c:forEach items="${subMap}" var="entry" >
									        <option value="${entry.key}">${entry.key}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label class="">Select Subject:</label> 
								<select name="subject" class="form-control" id="select-subject-bulk">
									<option value="4">Java</option>
									<option value="5">Advance Java</option>
									<option value="3">C Language</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-12">
								<label class="">Absent ID's:</label> <span class="pull-right" style="color: red;">*Absent Id's should be comma separared only. No other special characters allowed.</span>
								<textarea class="form-control" id="user-ids-area" 
								name="user-ids"></textarea>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-12">
								<button id="btn-submit-bulk-attendance" type="button" class="btn btn-primary pull-right">Submit</button>
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
		$(function () {
	        $('#adp').datetimepicker({
	        		defaultDate: false,
	        		format: 'DD/MM/YYYY'
	            });
	        
	        $('#bulkadp').datetimepicker({
        		defaultDate: false,
        		format: 'DD/MM/YYYY'
            });
	    });
		
		$("#tab-bulk-attendance-div").show();
		$("#tab-attendance-div").hide();
		
		$("#tab-attendance").click(function(){
			$("#tab-bulk-attendance-div").hide();
			$("#tab-attendance-div").show();
		});
		$("#tab-bulk-attendance").click(function(){
			$("#tab-attendance-div").hide();
			$("#tab-bulk-attendance-div").show();
		});
		
         $('#fromtimepick').datetimepicker({
             format: 'LT'
         });
         
         $('#totimepick').datetimepicker({
             format: 'LT'
         });
         $('#fromtimepickbulk').datetimepicker({
             format: 'LT'
         });
         
         $('#totimepickbulk').datetimepicker({
             format: 'LT'
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
		
		$("#btn-submit-bulk-attendance").click(
				function() {
					$.ajax({type : "POST",
						url : "/AttendenceManagement/adminService",
						data : {
								userIdsAbsent : $("#user-ids-area").val(),
								attendanceDate : $("#attendance-date-bulk").val(),
								presentDate : $("#attendance-date").val(),
								fromTime : $("#fromtimebulk").val(),
								toTime : $("#totimebulk").val(),
								subjectId : $("#select-subject-bulk").val(),
								classId : $("#select-class-bulk").val(),
								requestType : "addBulkAttendance"
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