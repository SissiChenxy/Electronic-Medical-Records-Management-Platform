<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"
	integrity="sha256-VAvG3sHdS5LqTT+5A/aeq/bZGa/Uj04xKxY8KM/w9EE="
	crossorigin="anonymous"></script>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
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

		<div class="container">
			<div class="row col-md-6 col-md-offset-2 custyle">
				<table class="table table-striped custab">
					<thead>
						<td class="text-center">Date / Time</td>
						<td class="text-center">Visit Reason</td>
						<td class="text-center">Provider</td>
						<td class="text-center">Status</td>
						<td class="text-center">Actions</td>
					</thead>
					<c:forEach items="${requestScope.appointmentList}"
						var="appointment">
						<tr>
							<c:choose>
								<c:when test="${appointment.confirmedTimes eq 'null-null-null-null' }">
									<td class="col-md-3">${appointment.preferredDateBegin} To
										${appointment.preferredDateEnd}</td>
								</c:when>
								<c:otherwise>
									<td class="col-md-3">${appointment.confirmedTimes}</td>
								</c:otherwise>
							</c:choose>

							<td class="col-md-2">${appointment.visitReason}</td>
							<td class="col-md-1">${appointment.receiver.name}</td>
							<td class="col-md-2">${appointment.status}</td>
							<td class="text-center col-md-4"><a
								class='btn btn-info btn-xs'
								href="${contextPath}/appointments.htm?action=request&replyReceiver=${appointment.sender.accountid}&edit=yes&visitReason=${appointment.visitReason}"><span
									class="glyphicon glyphicon-edit"></span> Edit</a> <a
								href="${contextPath}/appointments.htm?action=confirmed&appointmentid=${appointment.appointmentid}&startDate=${appointment.preferredDateBegin}&startTime=${appointment.preferredTimeBegin}&endDate=${appointment.preferredDateEnd}&endTime=${appointment.preferredTimeEnd}"
								class="btn btn-success btn-xs"><span
									class="glyphicon glyphicon-ok"></span>Confirm</a> <a
								href="${contextPath}/appointments.htm?action=cancel&appointmentid=${appointment.appointmentid}"
								class="btn btn-danger btn-xs"><span
									class="glyphicon glyphicon-remove"></span>Cancel</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
</body>
</html>