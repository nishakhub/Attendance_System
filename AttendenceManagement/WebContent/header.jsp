<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="org.vpmpt.attendancemanage.business.Notification"%>
<%@ page language="java" contentType="text/html;"%>
<c:set var="loc" value="en_US" />
<%
	String contextPath = request.getContextPath();

	String locale = (String) session.getAttribute("locale");
%>
<fmt:setLocale value="<%=locale%>" />
<fmt:bundle basename="app">
	<jsp:useBean id="notificationBean"	class="org.vpmpt.attendancemanage.business.Notification"
		scope="request">
		<jsp:setProperty name="notificationBean" property="user"
			value="${sessionScope.user}" />
	</jsp:useBean>
	<c:if test="${not empty sessionScope.user}">
		<c:set var="list" value="${notificationBean.allNotificationsForUser}"></c:set>
	</c:if>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/assets/images/reseller.ico" />
	<link
		href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" /> 
	<link
		href="${pageContext.request.contextPath}/resources/css/stylesheet.css" rel="stylesheet" />
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
		<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/jquery-ui.css">
	<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
		<script
		src="${pageContext.request.contextPath}/resources/js/Moment.js"></script>
	<style>
</style>
	<script type="text/javascript">
var notificationCount;
jQuery(document).ready(function(){
	
	$(".btn-group button").prop('enabled','true');
	   $('body').not('.icon-bell').click(function(){
		   $('.notifications').slideUp();
		}); 
	 
	var listLength =${fn:length(list)};

	jQuery(".icon-bell").click(function(event){
		 if(listLength>0){ 
			$(".notifications").css("height","320px");
			$(".notify").css("height","300px");
			jQuery(".notifications").slideToggle();
			event.stopPropagation();
		 }else{
			$(".notifications").css("height","50px");
			$(".notify").html("");
			$(".notify").append("<span style='margin-left: 130px;width: 100%;font-size: 14px;color:#666362;'> No Notifications</span>");
			$(".notify").css("height","30px");
			jQuery(".notifications").slideToggle();
			event.stopPropagation();
		} 
		 jQuery(".navbar-nav li").removeClass('open');
	});
	notificationCount = jQuery( ".notifications li" ).length;
	if(notificationCount>0){
		jQuery(".badge").html(notificationCount);
	}
	
	jQuery('.notifications li .notification-icons').each(function() {
		var nId = $(this).attr("id");
		var type =jQuery(this).attr("data-tooltip");
		if(jQuery(this).attr("data-tooltip") == "<fmt:message key="markAsRead"/>"){
		jQuery(this).click(function(event){
					send_request(nId,"markAsRead", type);
					event.stopPropagation();
			});
		}else if(jQuery(this).attr("data-tooltip") == "<fmt:message key="applyPolicy"/>"){
			jQuery(this).click(function(event){
				send_request(nId,"applyPolicy", type);
				event.stopPropagation();
			});
		}else if(jQuery(this).attr("data-tooltip") == "<fmt:message key="reject"/>"){
			jQuery(this).click(function(event){
			send_request(nId,"reject", type);
			event.stopPropagation();
			});
		}
		});
	
	$(".btn-group button").removeAttr('disabled');

});

	
</script>

	<header class="header-wrapper">
		<div class="navbar navbar-inverse" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<a class="navbar-brand" href="#" style="font: italic;font-size: x-large; font-weight:bold; color: white;"> <img
						src="<%=contextPath%>/resources/images/logo.png"
						alt="Attandance Management System" height="80%" width="80%"/><!-- <span>Vidya Prasarak Mandal's Polytechnic</span> -->
					</a>
				</div>
				<div class="collapse navbar-collapse pull-right">
					<ul class="nav navbar-nav">
						<li><a class="qh-icon icon-home"
								<c:choose>
									<c:when test= "${sessionScope.user.role eq 1}">
										href="${pageContext.request.contextPath}/jsp/admin/index.jsp"
									</c:when>
									<c:when test= "${sessionScope.user.role eq 2}">
										href="${pageContext.request.contextPath}/jsp/staff/manage_leaves.jsp"
									</c:when>
									<c:otherwise>
										href="${pageContext.request.contextPath}/jsp/student/manage_leaves.jsp"
									</c:otherwise>
								</c:choose>
							></a>
						</li>
						<li><a class="qh-icon icon-bell" href="javascript:void(0);">
								<span class="badge"></span>
						</a>
						
						<c:if test="${not empty sessionScope.user}">
								<div class="notifications">
									<div class="notify">
										<c:forEach items="${list}" varStatus="i" var="notif">
											<c:if test="${date ne notif.sentDate}">
												<span class="main_date">${notif.sentDate}</span>
												<hr>
											</c:if>
											<ul>
												<c:set var="date" value="${notif.sentDate}"></c:set>
												<li class="${notif.notificationId}">
													<table id="notify_time">
														<tr>
															<%-- <td><span class="time">${notif.time}</span></td> --%>
															<td><span class="heading">${notif.subject}</span> <br />
													<span class="desc">${notif.content}</span></td></tr></table>
													<div class="btn-group pull-right" style="margin-right:1%;margin-bottom: 1%;">
		                                        		<button type="button" id="${notif.notificationId}" class="btn btn-default notification-icons " data-tooltip="<fmt:message key="applyPolicy"/>"><i class="qh-icon icon-remove notify-icon"></i>
															</button>
		                                        		<button type="button" id="${notif.notificationId}" class="btn btn-default notification-icons " data-tooltip="<fmt:message key="reject"/>"><i class="qh-icon icon-ok notify-icon"></i>
															</button>
														</div>
													<hr style="border-color: #2A6496;" />
												</li>
												</ul>
										</c:forEach>
									</div>
								</div>
							</c:if></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">${sessionScope.user.getFirstName()} ${sessionScope.user.getLastName()}<b
								class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="${pageContext.request.contextPath}/user_profile.jsp">View Profile</a></li>
								<li><a href="${pageContext.request.contextPath}/change_password.jsp">Change password</a>
                                </li>
								<li class="divider"></li>
								<li><a href="${pageContext.request.contextPath}/jsp/logout.jsp">logout</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</div>

	</header>
</fmt:bundle>