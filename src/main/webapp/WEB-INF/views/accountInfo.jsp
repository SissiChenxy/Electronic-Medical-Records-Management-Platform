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
	Account Info:
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <c:set var="patient" value="${requestScope.patient}" />
    <c:set var="doctor" value="${requestScope.doctor}" />

	Basic Info:<br>
	<form action="${contextPath}/AccountInfo/detail.htm?action=modify-basic" method="POST">
	<!-- show different info for two roles -->
	<c:if test="${not empty patient}">
    	Name: <input type="text" name="name" value="${patient.name}"/><br>
    	Age: <input type="text" name="age" value="${patient.age}"/><br>
    	Phone: <input type="text" name="phone" value="${patient.phone}"/><br>
    	Street Address: <input type="text" name="streetAddress" value="${patient.streetAddress}"/><br>
    	City: <input type="text" name="city" value="${patient.city}"/><br>
    	State: <input type="text" name="state" value="${patient.state}"/><br>
    	ZipCode: <input type="text" name="zipCode" value="${patient.zipCode}"/><br>
    </c:if>
    <c:if test="${not empty patient}">
    	Name: <input type="text" name="name" value="${doctor.name}"/><br>
    	Age: <input type="text" name="age" value="${doctor.age}"/><br>
    	Phone: <input type="text" name="phone" value="${doctor.phone}"/><br>
		Department <input type="text" name="department" value="${doctor.phone}"/><br>
    </c:if>
    	<input type="submit" name="Save Change"/><br>
    </form>

	Change Password:<br>
	<form action="${contextPath}/AccountInfo/detail.htm?action=modify-password" method="POST">
    	Old Password: <input type="password" name="oldPw" id="pw1" /><br>
    	Re-enter: <input type="password" id="pw2" onblur="check2pwd()"/><br>
    	<div id="pwNotSame"></div>
    	New Password: <input type="password" name="newPw" /><br>
    	<input type="submit" name="Save Change"/><br>
    </form>
    
    <script>  
    	// check two passwords
    	function check2pwd() {  
    		if(input1.value != input2.value) {  
    			document.getElementById("pwNotSame").innerHTML="The two input passwords are not the same";    
            }  
        }  
    </script>  

</body>
</html>