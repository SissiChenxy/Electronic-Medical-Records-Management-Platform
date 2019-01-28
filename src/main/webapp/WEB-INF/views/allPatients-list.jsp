<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"
	integrity="sha256-VAvG3sHdS5LqTT+5A/aeq/bZGa/Uj04xKxY8KM/w9EE="
	crossorigin="anonymous"></script>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.custab {
	border: 1px solid #ccc;
	padding: 5px;
	margin: 5% 0;
	box-shadow: 3px 3px 2px #ccc;
	transition: 0.5s;
}

.custab:hover {
	box-shadow: 3px 3px 0px transparent;
	transition: 0.5s;
}
</style>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div class="container">
		<div class="row">
			<table class="table table-striped custab">
				<thead>
					<td class="text-center">Appointment Id</td>
					<td class="text-center">Visit Reason</td>
					<td class="text-center">Patient Name</td>
					<td class="text-center">Age</td>
					<td class="text-center">Action</td>
				</thead>
				<c:forEach items="${requestScope.appointmentList}" var="appointment">
					<tr>
					<td class="text-center">${appointment.appointmentid}</td>
						<td class="text-center">${appointment.visitReason}</td>
							<c:if test="${appointment.receiver.name eq requestScope.doctorName}">
								<td class="text-center">${appointment.sender.name}</td>
								<td class="text-center">${appointment.sender.age}</td>
							</c:if>
							<c:if test="${appointment.sender.name eq requestScope.doctorName}">
								<td class="text-center">${appointment.receiver.name}</td>
								<td class="text-center">${appointment.receiver.age}</td>
							</c:if>
						<td class="text-center"><a class='btn btn-info btn-xs'
							href="${contextPath}/patientManage/detail.htm?action=recipe&appointmentid=${appointment.appointmentid}"><span
								class="glyphicon glyphicon-edit"></span> Recipe</a> <a
							href="${contextPath}/patientManage/detail.htm?action=history&appointmentid=${appointment.appointmentid}"
							class="btn btn-success btn-xs"><span
								class="glyphicon glyphicon-ok"></span> History</a></td>
					</tr>
				</c:forEach>

			</table>
		</div>
	</div>
</body>
</html>