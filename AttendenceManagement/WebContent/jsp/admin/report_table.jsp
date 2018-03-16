<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import="org.vpmpt.attendancemanage.business.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="reportBean" scope="request"
	class="org.vpmpt.attendancemanage.business.Report">
	<jsp:setProperty name="reportBean" property="userDTO"
		value="${sessionScope.user}" />
		<jsp:setProperty name="reportBean" property="paramMap"
		value="${paramMap}" />
</jsp:useBean>
<c:set var="reportList" value="${reportBean.reportList}"></c:set>
<c:choose>
	<c:when test= "${fn:length(reportList) gt 0}">
		<c:forEach items="${reportList}" varStatus="i" var="reportDTO">
			<tr <c:if test="${reportDTO.percentage lt 70}">
				style="background-color: red; color: white;"
			</c:if>>
				<td>${reportDTO.userId}</td>
				<td>${reportDTO.studentName}</td>
				<td>${reportDTO.totalDays}</td>
				<td>${reportDTO.presentDays}</td>
				<td>${reportDTO.percentage}</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div colspan="6" style="font-size: 60; font-weight: bold; text-align: center; margin-top: 20%;">No Data found</div>
	</c:otherwise>
</c:choose>