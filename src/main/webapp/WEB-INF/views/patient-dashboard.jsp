<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>patient dashboard</title>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"
	integrity="sha256-VAvG3sHdS5LqTT+5A/aeq/bZGa/Uj04xKxY8KM/w9EE="
	crossorigin="anonymous"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div class="container">
		<div class="row">
			<div class="col-sm-3 col-md-3">
				<div class="panel-group" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseOne" target="frame"><span
									class="glyphicon glyphicon-comment"> </span> Message</a>
							</h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse in">
							<div class="panel-body">
								<table class="table">
									<tr>
										<td><a
											href="${contextPath}/messages.htm?action=inbox"
											target="frame"> Inbox</a> <span class="badge">42</span>
										</td>
									</tr>
									<tr>
										<td></span><a
											href="${contextPath}/messages.htm?action=compose"
											target="frame"> Compose</a></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseTwo" target="frame"><span
									class="glyphicon glyphicon-th"> </span> Appointments</a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse">
							<div class="panel-body">
								<table class="table">
									<tr>
										<td><a
											href="${contextPath}/appointments.htm?action=view"
											target="frame">View Appointment</a> <span
											class="label label-success">$ 320</span></td>
									</tr>
									<tr>
										<td><a
											href="${contextPath}/appointments.htm?action=request"
											target="frame">Request Appointment</a></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseThree" target="frame"><span
									class="glyphicon glyphicon-user"> </span> Recipe</a>
							</h4>
						</div>
						<div id="collapseThree" class="panel-collapse collapse">
							<div class="panel-body">
								<table class="table">
									<tr>
										<td><a
											href="${contextPath}/patient/testresults.htm?testid=${test.id}"
											target="frame"> History</a></td>
									</tr>
									<c:forEach items="${requestScope.patientList}" var="patient">
										<tr>
											<td><a
												href="${contextPath}/patient/testresults.htm?testid=${test.id}"
												target="frame"> ${test.name}</a></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseFour" target="frame"><span
									class="glyphicon glyphicon-file"> </span> Account</a>
							</h4>
						</div>
						<div id="collapseFour" class="panel-collapse collapse">
							<div class="panel-body">
								<table class="table">
									<%-- <c:forEach items="${}"
										var="patient">
										<tr>
											<td><a
												href="${contextPath}/patient/prescription.htm?prescriptionid=${}"
												target="frame"> ${}</a></td>
										</tr>
									</c:forEach> --%>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-sm-9 col-md-9">
				<div class="well">
					<iframe name="frame" frameborder="0" width="100%"
						height="100%" scrolling="yes"
						onload="this.height=frame.document.body.scrollHeight+20"
						src="${contextPath}/messages.htm?action=inbox"></iframe>
				</div>
			</div>
		</div>
	</div>
</body>
</html>