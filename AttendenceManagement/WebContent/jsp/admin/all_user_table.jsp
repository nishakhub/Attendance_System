<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import="org.vpmpt.attendancemanage.business.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="userBean" scope="request"
	class="org.vpmpt.attendancemanage.business.User">
	<jsp:setProperty name="userBean" property="criteriaMap"
		value="${criteriaMap}" />
</jsp:useBean>
<c:set var="userList" value="${userBean.userList}"></c:set>
<c:choose>
	<c:when test= "${fn:length(userList) gt 0}">
<c:forEach items="${userList}" varStatus="i" var="userDTO">
	<tr>
		<td class="vcenter"><input type="checkbox" id="${userDTO.userId}" value="1" /></td>
		<td>${userDTO.userId}</td>
		<td>${userDTO.firstName}</td>
		<td>${userDTO.lastName}</td>
		<td>${userDTO.emailId}</td>
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
	</tr>
</c:forEach>
</c:when>
	<c:otherwise>
		<div colspan="6" style="font-size: 60; font-weight: bold; text-align: center; margin-top: 20%;">No Data found</div>
	</c:otherwise>
</c:choose>
