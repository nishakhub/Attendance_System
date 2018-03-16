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
<title>Change Password</title>
</head>
<body>
	<jsp:include page="header.jsp" />
		<div class="container pull-left">
		<div class="pull-right col-md-10" style="float: right; width: 80%;">
			<div>
				<p style="font-size: 16px; font-weight: 200;">Change Password</p>
			</div>
			<div>
				<form id="form-change-password" role="form col-md-10" action="">
					<div class="row">
						<div class="form-group col-md-8">
							<label class="">Old Password</label> <input type="text"
								class="form-control" id="old-password" name="old-password">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-8">
							<label class="">New Password</label> <input type="text"
								class="form-control" id="new-password" name="new-password">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-8">
							<label class="">Re-enter New Password</label> <input type="text"
								class="form-control" id="re-enter-password" name="re-enter-password">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-8">
							<button id="btn-change-password" type="button"
							class="btn btn-primary pull-right">Change Password</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<jsp:include page="footer.jsp" />
	<script type="text/javascript">
	$(document).ready(function() {
		
		$("#btn-change-password").click(
				function() {
					var newPass = ""+$("#new-password").val();
					var repeatPass =""+$("#re-enter-password").val();
					if(newPass == repeatPass){
					$.ajax({type : "POST",
							url : "/AttendenceManagement/adminService",
							data : {
									oldPassword : $("#old-password").val(),
									newPassword : $("#new-password").val(),
									newPassRepeat : $("#re-enter-password").val(),
									requestType : "changePassword"
									},
								success : function(result) {
									window.open(result, "_self");
									
								},
								error : function(xmlHttpRequest) {
									// Show the error.
									switch (xmlHttpRequest.status) {
									case 404:
										
										break;
									case 400:
										
										break;
									
									case 1000:
										window.location.href = "/DisApp/index.jsp";
										break;
									case 1001:
										alert("Wrong old password.");
										break;
									}
								}
							});
					}else{
						alert("New password does not match.");
					}
				});
		
	});
	</script>
	
</body>
</html>