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
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
.btn-glyphicon {
	padding: 8px;
	background: #ffffff;
	margin-right: 4px;
}

.icon-btn {
	padding: 1px 15px 3px 2px;
	border-radius: 50px;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<form action="${contextPath}/patientManage/detail.htm?action=recipe"
		method="POST" class="form-horizontal">
		<div class="container">
			<div class="row">
				<div class="form-group">
					<label class="col-md-4 control-label" for="textinput">Patient
						:</label>
					<p class="col-md-4">${requestScope.patientName}</p>
					<input type="hidden" name="appointmentid" value="${requestScope.appointmentid}" />
					<input type="hidden" name="patientName" value="${requestScope.patientName}" />
					<label class="col-md-4 control-label" for="textinput">Ordered
						By :</label>
					<p class="col-md-4">${requestScope.doctorName}</p>
				</div>
				<div class="form-group">
					<a id="addTestButton" class="btn icon-btn btn-success" href="#"><span
						class="glyphicon btn-glyphicon glyphicon-plus img-circle text-success"></span>Add
						Test</a>
				</div>
				<script>
					$('#addTestButton')
							.click(
									function() {
										$('#testComponent')
												.append(
														'<div class="form-group">'
																+ '<label class="col-md-4 control-label" for="selectbasic">'
																+ "Test Name :"
																+ '</label>'
																+ '<select id="selectbasic" name="testName" class="form-control col-md-4">'
																+ '<option>- choose a test -</option>'
																+ '<option>Thyroid monitoring panel</option>'
																+ '<option>Sedimentation rate (ESR)</option>'
																+ '</select>'
																+ '</div>'
																+ '<div class="form-group">'
																+ '<label class="col-md-4 control-label" for="content">Result</label>'
																+ '<textarea class="form-control col-md-4" id="content" name="testResult" cols="5" rows="5"></textarea>'
																+ '</div>')
									})
				</script>
				<div id="testComponent"></div>
				<div class="form-group">
					<a id="addPrescriptionButton" class="btn icon-btn btn-success"
						><span
						class="glyphicon btn-glyphicon glyphicon-plus img-circle text-success"></span>Add
						Prescription</a>
				</div>
				<script>
					$('#addPrescriptionButton')
							.click(
									function() {
										$('#prescriptionComponent')
												.append(
														'<div class="form-group">'
																+ '<label class="col-md-4 control-label" for="selectbasic">'
																+ "Medicine Name :"
																+ '</label>'
																+ '<input type="text" id="medicineName" class="form-control input-md" name="medicineName" onkeyup="ajaxFunction()"/>'
																+ '<p id="medicineTip"/>'
																+ '<label class="col-md-4 control-label" for="selectbasic">'
																+ "Quantity :"
																+ '</label>'
																+ '<input type="text" name="quantity" class="form-control input-md" />'
																+ '<label class="col-md-4 control-label" for="selectbasic">'
																+ "Instructions :"
																+ '</label>'
																+ '<input type="text" name="instructions" class="form-control input-md"/>'
																+ '</div>' 
																+ '<hr>'
																)
									})
									
					function ajaxFunction() {

						var xmlHttp;
						try // Firefox, Opera 8.0+, Safari
						{
							xmlHttp = new XMLHttpRequest();
						} catch (e) {
							try // Internet Explorer
							{
								xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
							} catch (e) {
								try {
									xmlHttp = new ActiveXObject(
											"Microsoft.XMLHTTP");
								} catch (e) {
									alert("Your browser does not support AJAX!");
									return false;
								}
							}
						}

						xmlHttp.onreadystatechange = function() {
							if (xmlHttp.readyState == 4) {
								document.getElementById("medicineTip").innerHTML = xmlHttp.responseText;
								JSON.parse(xmlHttp)
							}
						}

						var medicineName = document
								.getElementById("medicineName").value;

						xmlHttp.open("POST", "${contextPath}/prescription/medicineAdd.htm?medicineName="
								+ medicineName, true);
						xmlHttp.send();
					}
				</script>
				<div id="prescriptionComponent"></div>
			</div>
			<div class="form-group">
				<input name="submit" type="submit" class="btn btn-default col-md-4"
					value="Submit"></input> <input name="cancel" type="submit"
					class="btn btn-default col-md-4" value="Cancel"></input>
			</div>
		</div>
	</form>
</body>
</html>