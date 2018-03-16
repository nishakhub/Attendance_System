<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html;"%>
<c:set var="loc" value="en_US" />
<%
	String contextPath = request.getContextPath();

	String locale = (String) session.getAttribute("locale");
%>
<fmt:setLocale value="<%=locale%>" />
<fmt:bundle basename="app">
	<!-- jsp:useBean id="notificationBean"
		class="com.quickheal.cloud.tenantbeans.TenantNotificationBean"
		scope="request">
		<jsp:setProperty name="notificationBean" property="user"
			value="${sessionScope.user}" />
	</jsp:useBean-->
	<c:if test="${not empty sessionScope.user}">
		<c:set var="list" value="${notificationBean.infoList}"></c:set>
	</c:if>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/assets/images/reseller.ico" />
	<link
		href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" />
	<link
		href="${pageContext.request.contextPath}/resources/css/stylesheet.css" rel="stylesheet" />
	<link
		href="${pageContext.request.contextPath}/resources/css/d3_tree.css" rel="stylesheet" />
	<link
		href="${pageContext.request.contextPath}/resources/css/jquery-ui.css"
		rel="stylesheet" />

	<link
		href="${pageContext.request.contextPath}/resources/css/bootstrap-sortable.css"
		rel="stylesheet" />

	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/javascripts.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/lib/d3.v3.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/lib/bootstrap-sortable.js"></script>
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
			$(".notify").append("<span style='margin-left: 130px;width: 100%;font-size: 14px;color:#666362;'> <fmt:message key='noNotifications'/></span>");
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

		/* jQuery('#SessionTimeout').dialog({
			autoOpen : false,
			height :120,
			width : 200,
			modal : true,
			autoResize : true,
			draggable : true,
			hide : null,
			 close:function(){
		        	window.location="${pageContext.request.contextPath}/Tenant/logout.jsp";
		        
			 }
		}); */
			  /*  $(".notify read-div button").click(function() {
				   var nId = $(this).attr("class");
				   alert(nId);
				   $.ajax({
						type : "POST",
						url : "/QuickHealCloudPlatform/cloud_reports",
						data : {id : nId, type : "notify"},
						success : function(result) {
							$(this).remove();
						},
						error: function(xmlHttpRequest){
						
						}
				});
			}); */
});

	
	function send_request(id,type, tooltip){
		var show=id;
		$.ajax({
			type : "POST",
			url : "/QuickHealCloudPlatform/cloud_reports",
			data : {id:id, action:type},
			success : function(result) {
				if(tooltip=="<fmt:message key="markAsRead"/>"){
					$("#"+show).parent().parent().css("background","#ccc");
					notificationCount = notificationCount - 1;
					jQuery(".badge").html(notificationCount);
					$("#"+show).prop('disabled', true);
				}else if(tooltip=="<fmt:message key="applyPolicy"/>"){
					$("#"+show).parent().parent().css("background","#ccc");
					notificationCount = notificationCount - 1;
					jQuery(".badge").html(notificationCount);
					$("#"+show).prop('disabled', true);
					$("#"+show).siblings().prop('disabled', true);
				}else if(tooltip=="<fmt:message key="reject"/>"){
					$("#"+show).parent().parent().css("background","#ccc");
					notificationCount = notificationCount - 1;
					jQuery(".badge").html(notificationCount);
					$("#"+show).prop('disabled', true);
					$("#"+show).siblings().prop('disabled', true);
				}
			},
			error: function(xmlHttpRequest){
				
			}
	   });
	}
idleMax = 10;
idleTime = 0;
incrementBy =1*60*1000;
var timeoutMessage;/* min*seconds*milliseconds */
jQuery(document).ready(function () {
 setInterval("timerIncrement()", incrementBy); 
jQuery(this).mousemove(function (e) {idleTime = 0;});
jQuery(this).keypress(function (e) {idleTime = 0;});
jQuery(this).scroll(function (e) {idleTime = 0;});
});
function timerIncrement() {
idleTime = idleTime + 1;
if (idleTime > idleMax) { 
	$(window).on('unload', function(){
		window.location="${pageContext.request.contextPath}/Tenant/logout.jsp?timeoutMessage=sessionTimeoutMessage";
	});
	window.location="${pageContext.request.contextPath}/Tenant/logout.jsp?timeoutMessage=sessionTimeoutMessage";
	};
};
</script>

	<header class="header-wrapper">
		<div class="navbar navbar-inverse" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<a class="navbar-brand" href="<%=contextPath %>/Tenant/dashboard.jsp"> <img
						src="<%=contextPath%>/resources/assets/images/logo.png"
						alt="Quick Heal Cloud Platform" />
					</a>
				</div>
				<div class="collapse navbar-collapse pull-right">
					<ul class="nav navbar-nav">
						<li><a href="<%=contextPath%>/Tenant/dashboard.jsp"
							class="qh-icon icon-home"></a></li>
						<li><a class="qh-icon icon-bell" href="javascript:void(0);">
								<span class="badge"></span>
						</a>
						
						<c:if test="${not empty sessionScope.user}">
								<div class="notifications">
									<div class="notify">
										<c:forEach items="${list}" varStatus="i" var="notif">
											<c:if test="${date ne notif.date}">
												<span class="main_date">${notif.date}</span>
												<hr>
											</c:if>
											<ul>
												<c:set var="date" value="${notif.date}"></c:set>
												<li class="${notif.id}">
													<table id="notify_time">
														<tr>
															<td><span class="time">${notif.time}</span></td>
															<td><span class="heading">${notif.subject}</span> <br />
													<span class="desc">${notif.content}</span></td></tr></table>
										<c:if test="${notif.type eq 19}">
											<div class="btn-group pull-right" style="margin-right:1%;margin-bottom: 1%;">
		                                        <button type="button" id="${notif.id}" class="btn btn-default notification-icons " data-tooltip="<fmt:message key="applyPolicy"/>"><i class="qh-icon icon-remove notify-icon"></i>
															</button>
		                                        <button type="button" id="${notif.id}" class="btn btn-default notification-icons " data-tooltip="<fmt:message key="reject"/>"><i class="qh-icon icon-ok notify-icon"></i>
															</button>
														</div>
													</c:if> 
													<c:if test="${notif.type ne 19}">
	                                    	<div class="btn-group pull-right read-div" style="margin-right:1%;margin-bottom: 1%;">
	                                    		<button type="button" id="${notif.id}" class="btn btn-default notification-icons " data-tooltip="<fmt:message key="markAsRead"/>"><i class="qh-icon icon-remove notify-icon"></i>
															</button>
														</div>
													</c:if>
													<hr style="border-color: #2A6496;" />
												</li>
										</c:forEach>
									</div>
									<span class="show_history_link"><a
										href="<%=contextPath%>/Tenant/notificationhistory.jsp"><fmt:message
												key="viewNotificationHistory" /></a></span>
								</div>
							</c:if></li>
						<li class="pt-7">
							<div class="avtar">
								<c:choose>

									<c:when
										test="${(sessionScope.user.photoId eq null) or (sessionScope.user.photoId eq '')}">
										<img
											src="<%=contextPath%>/resources/assets/images/default_tenant.png" />
									</c:when>
									<c:otherwise>
										<img
											src="<%=contextPath%>/DisplayImage?dataID=${sessionScope.user.getPhotoId()}">
									</c:otherwise>

								</c:choose>
							</div>
						</li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">${sessionScope.user.getFirstName()} <b
								class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="<%=contextPath%>/Tenant/user/viewprofile.jsp"><fmt:message
											key="profile" /></a></li>
								<%--   <li><a href="<%=contextPath%>/Tenant/user/changepassword.jsp"><fmt:message key="changePassword"/></a>
                                </li> --%>
								<li class="divider"></li>
								<li><a href="<%=contextPath%>/Tenant/logout.jsp"><fmt:message
											key="logout" /></a></li>
							</ul></li>
					</ul>
				</div>
				<!--/.nav-collapse -->

			</div>
		</div>

	</header>
</fmt:bundle>