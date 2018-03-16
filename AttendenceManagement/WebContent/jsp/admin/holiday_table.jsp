<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import="org.vpmpt.attendancemanage.business.Holiday"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="holidayBean" scope="request"
	class="org.vpmpt.attendancemanage.business.Holiday">
	<jsp:setProperty name="holidayBean" property="year"
		value="${year}" />
</jsp:useBean>
<c:set var="holidayList" value="${holidayBean.holidays}"></c:set>
<c:choose>
	<c:when test= "${fn:length(holidayList) gt 0}">
		<c:forEach items="${holidayList}" varStatus="i" var="holidayDTO">
			<tr>
				<td>${holidayDTO.holidayDate}</td>
				<td>${holidayDTO.discription}</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div colspan="6" style="font-size: 60; font-weight: bold; text-align: center; margin-top: 20%;">No Data found</div>
	</c:otherwise>
</c:choose>