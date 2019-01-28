<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
	</br>
	<div class="container">
		<div class="row">
			<div class="col-sm-3 col-md-3">
				<div class="panel-group" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseOne" target="messageframe"><span
									class="glyphicon glyphicon-comment"> </span> Message</a>
							</h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse in">
							<div class="panel-body">
								<table class="table">
									<tr>
										<td><a href="${contextPath}/messages.htm?action=inbox"
											target="frame"> Inbox</a> <span class="badge">42</span></td>
									</tr>
									<tr>
										<td></span><a href="${contextPath}/messages.htm?action=compose"
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
									href="#collapseTwo" target="appointmentframe"><span
									class="glyphicon glyphicon-th"> </span> Appointments</a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse">
							<div class="panel-body">
								<table class="table">
									<tr>
										<td><a href="${contextPath}/appointments.htm?action=view"
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
								<a data-toggle="collapse" data-parent="#accordion" id="a"
									href="#collapseThree" target="frame" onclick="show()"><span
									class="glyphicon glyphicon-user"> </span> Patient</a>
							</h4>
							<script>
								function show() {
									$.ajax({
												url : "${contextPath}/patientManage/list.htm",
												type : 'post',
												dataType : 'JSON',
												timeout : '10000',
												cache : 'false',
												success : function(data) {
													console.log("1");
													var html = "";
													for(var i = 0;i<data.length;i++){
														html += '<tr><td><a target="frame" href="${contextPath}/patientManage/detail.htm?patientid='
															+ data[i].accountid 
															+ '">'
															+ data[i].name
															+ '</a></td></tr>';
														}
													var tdContent = $('#patientName');
													tdContent.html(html);

												}
											})
								}
							</script>
						</div>
						<div id="collapseThree" class="panel-collapse collapse">
							<div class="panel-body">
								<table class="table" id="patientName">
								</table>
								<a href="${contextPath}/patientManage/detail.htm?action=view" target="frame">
												View All Patients</a>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseFour"><span class="glyphicon glyphicon-file">
								</span> Account</a>
							</h4>
						</div>
						<div id="collapseFour" class="panel-collapse collapse">
							<div class="panel-body">
								<table class="table">
									<tr>
										<td><a
											href="${contextPath}/AccountInfo/detail.htm" target="frame">
												Change Password</a></td>
									</tr>
									<tr>
										<td><a
											href="${contextPath}/doctor/account.htm?action=contact" target="frame">
												Contact Information</a></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-9 col-md-9">
				<div class="well">
					<iframe name="frame" frameborder="0" width="100%" height="100%"
						scrolling="yes"
						onload="this.height=frame.document.body.scrollHeight+20"
						src="${contextPath}/messages.htm?action=inbox"> </iframe>
				</div>
			</div>
		</div>
	</div>
</body>
</html>