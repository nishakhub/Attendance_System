<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import="org.vpmpt.attendancemanage.business.Attendance"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="attendanceBean" scope="request"
	class="org.vpmpt.attendancemanage.business.Attendance">
	<jsp:setProperty name="attendanceBean" property="criteriaMap"
		value="${criteriaMap}" />
</jsp:useBean>
<c:set var="leaveList" value="${attendanceBean.userLeaves}"></c:set>
<c:choose>
	<c:when test= "${fn:length(leaveList) gt 0}">
<c:forEach items="${leaveList}" varStatus="i" var="leaves">
	<tr>
		<td>${leaves.leaveFromDate}</td>
		<td>${leaves.leaveTodate}</td>
		<td>${leaves.total}</td>
		<td>${leaves.description}</td>
	</tr>
</c:forEach>
</c:when>
	<c:otherwise>
		<div colspan="6" style="font-size: 60; font-weight: bold; text-align: center; margin-top: 20%;">No Data found</div>
	</c:otherwise>
</c:choose>
