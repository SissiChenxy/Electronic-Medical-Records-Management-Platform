<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
   <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <c:set var="status" value="${requestScope.status}" />

	<c:if test="${status eq 'changeBasic'}">
		Basic Info changed successfully.
	</c:if> 
	<c:if test="${status eq 'changePwSuccess'}">
		Password changed successfully.
	</c:if>
	<c:if test="${status eq 'changePwFail'}">
		The old password is not correct.
	</c:if> 
	<br><a href="${contextPath}/AccountInfo/detail.htm">Back</a>
</body>
</html>