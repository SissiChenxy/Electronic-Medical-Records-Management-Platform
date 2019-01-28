<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"
	integrity="sha256-VAvG3sHdS5LqTT+5A/aeq/bZGa/Uj04xKxY8KM/w9EE="
	crossorigin="anonymous"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</head>
<body>
	<script type="text/javascript"
		src="http://js.nicedit.com/nicEdit-latest.js">
		
	</script>
	<script type="text/javascript">
		bkLib.onDomLoaded(function() {
			nicEditors.allTextAreas()
		});
	</script>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />


	<form action="${contextPath}/messages.htm?action=compose"
		method="POST" enctype="multipart/form-data" class="form-horizontal" class="form-horizontal">
		<c:choose>
			<c:when test="${requestScope.reply eq 'yes'}">
				<div class="container">
					<div class="row">
						<div class="form-group">
							<label class="col-md-4 control-label" >From
								:</label>
							<p class="col-md-4">${requestScope.sender.name}</p>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label">To
								the office of :</label>
							<p class="col-md-4">${requestScope.replyReceiver.name}</p>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="textinput">Subject
								:</label>
							<p class="col-md-4">${requestScope.subject}</p>
						</div>

						<input type="hidden" name="sender"
							value="${requestScope.sender.accountid}" /> <input type="hidden"
							name="receiver" value="${requestScope.replyReceiver.accountid}" />
						<input type="hidden" name="subject"
							value="${requestScope.subject}" /> <input type="hidden"
							name="replyFlag" value="finished" />
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
								the office of :</label>
								<select id="selectbasic" name="receiver" class="form-control col-md-4">
									<option>- choose a recipient -</option>
									<option>222</option>
									<option>333</option>
									<%-- <c:forEach items="${requestScope.doctorList}" var="doctor">
				<option>${doctor}</option>
			</c:forEach> --%>
								</select>
						</div>

						<div class="form-group">
							<label class="col-md-4 control-label" for="selectbasic">Subject
								:</label>
								<select id="selectbasic" name="subject" class="form-control col-md-4">
									<option>- select a subject -</option>
									<option>Non-Urgent Medical Question</option>
									<option>Prescription Question</option>
									<option>Test Results Question</option>
									<option>Visit Follow-up Question</option>
								</select>
						</div>
			</c:otherwise>
		</c:choose>

		<div class="form-group">
			<label class="col-md-4 control-label" for="textinput">Content
				:</label>
			<textarea class="col-md-4" name="content" cols="50" rows="10"></textarea>
			</br> Attached File: <input type="file" name="attachedfile"></br>
		</div>

		<div class="form-group">
			<input type="submit" name="send" class="btn btn-default col-md-4"
				value="Submit"></input> 
			<input type="submit" name="cancel"
				class="btn btn-default col-md-4" value="Cancel"></input>
		</div>

	</form>
</body>
</html>