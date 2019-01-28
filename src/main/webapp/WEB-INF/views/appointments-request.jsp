<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://code.jquery.com/jquery-1.11.1.min.js"
	integrity="sha256-VAvG3sHdS5LqTT+5A/aeq/bZGa/Uj04xKxY8KM/w9EE="
	crossorigin="anonymous"></script>
<link rel="styleshee" type="text/css" href="${contextPath}/resources/jquery.timepicker.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap-datepicker.css" />
<script type="text/javascript" src="${contextPath}/resources/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${contextPath}/resources/jquery.timepicker.js"></script>
<script type="text/javascript" src="${contextPath}/resources/Datepair.js"></script>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="container">
		<div class="row">
			<form action="${contextPath}/appointments.htm?action=request"
				method="POST" class="form-horizontal">

				<c:choose>
					<c:when test="${requestScope.edit eq 'yes'}">
						<div class="container">
							<div class="row">
								<div class="form-group">
									<label class="col-md-4 control-label">From :</label>
									<p class="col-md-4">${requestScope.sender.name}</p>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label">To the office of
										:</label>
									<p class="col-md-4">${requestScope.replyReceiver.name}</p>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="textinput">Visit
										Reason :</label>
									<p class="col-md-4">${requestScope.visitReason}</p>
								</div>

								<input type="hidden" name="sender"
									value="${requestScope.sender.accountid}" /> <input
									type="hidden" name="receiver"
									value="${requestScope.replyReceiver.accountid}" /> <input
									type="hidden" name="subject"
									value="${requestScope.visitReason}" /> <input type="hidden"
									name="editFlag" value="finished" /> 
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="container">
							<div class="row">
								<div class="form-group">
									<label class="col-md-4 control-label" for="textinput">From
										:</label>
									<p class="col-md-4">${requestScope.sender.accountid}</p>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="selectbasic">To
										the office of :</label> <select id="selectbasic" name="receiver"
										class="form-control col-md-4">
										<option>- choose a recipient -</option>
										<option>3</option>
										<option>4</option>
										<%-- <c:forEach items="${requestScope.doctorList}" var="doctor">
				<option>${doctor}</option>
			</c:forEach> --%>
									</select>
								</div>

								<div class="form-group">
									<label class="col-md-4 control-label" for="selectbasic">Visit
										Reason :</label> <select id="selectbasic" name="visitReason"
										class="form-control col-md-4">
										<option>- select a visit reason -</option>
										<option>Non-Urgent Medical Question</option>
										<option>Prescription Question</option>
										<option>Test Results Question</option>
										<option>Visit Follow-up Question</option>
									</select>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>

				<div class="form-group">
					<label class="col-md-4 control-label" for="content">Preferred
						Date :</label>
					<p id="dateOnly" class="col-md-4">
						<input type="text" class="date start" name="startDate" /> to <input
							type="text" class="date end" name="endDate" />
					</p>
				</div>

				<div class="form-group">
					<label class="col-md-4 control-label" for="content">Preferred
						Time :</label>
					<p id="timeOnly" class="col-md-4">
						<input type="text" class="time start" name="startTime" /> to <input
							type="text" class="time end" name="endTime" />
					</p>
				</div>

				<script>
					$('#timeOnly .time').timepicker({
						'showDuration' : true,
						'timeFormat' : 'g:ia'
					});

					var timeOnlyEl = document.getElementById('timeOnly');
					var timeOnlyDatepair = new Datepair(timeOnlyEl);

					$('#dateOnly .date').datepicker({
						'format' : 'yyyy-m-d',
						'autoclose' : true
					});

					var dateOnlyEl = document.getElementById('dateOnly');
					var dateOnlyDatepair = new Datepair(dateOnlyEl);
				</script>

				<div class="form-group">
					<label class="col-md-4 control-label" for="content">Comments</label>
					<textarea class="form-control col-md-4" id="content" name="content"
						cols="50" rows="10"></textarea>
				</div>
				
				<input type="hidden" name="senderStatus" value="${requestScope.sender}"/>

				<div class="form-group">
					<input name="submit" type="submit" class="btn btn-default col-md-4"
						value="Submit"></input> <input name="cancel" type="submit"
						class="btn btn-default col-md-4" value="Cancel"></input>
				</div>
			</form>
		</div>
	</div>
</body>
</html>