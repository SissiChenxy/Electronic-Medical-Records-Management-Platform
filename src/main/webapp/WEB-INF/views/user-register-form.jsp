<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.captcha.botdetect.web.servlet.Captcha"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<!-- bootstrap -->
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
	
	<script>
    function ajaxEvent() {

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
                    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (e) {
                    alert("Your browser does not support AJAX!");
                    return false;
                }
            }
        }

        xmlHttp.onreadystatechange = function() {
            if (xmlHttp.readyState == 4) {
                document.getElementById("usernameHint").innerHTML = xmlHttp.responseText;
            }
        }
        
        var username = document.getElementById("username").value;

        xmlHttp.open("POST", "../checkUserExistence.htm?username="+username, true);
        xmlHttp.send();
    }
</script>
</head>
<body>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    
    <div id="login-overlay" class="modal-dialog" style="width:30%">
      <div class="modal-content">
          <div class="modal-header">
              <!-- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button> -->
              <h4 class="modal-title" id="myModalLabel">Register to site.com</h4>
          </div>
          <div class="modal-body">
              <div class="row">
                  <div class="col-xs-12">
                      <div class="well">
                          <form id="registerForm" method="POST" action="${contextPath}/user/register.htm" novalidate="novalidate">
                              <div class="form-group">
                                  <label for="username" class="control-label">Username</label>
                                  <input type="text" class="form-control" id="username" name="username" value="" required="required" title="Please enter you username" placeholder="example@gmail.com" onkeyup="ajaxEvent()">
                                  <div id="usernameHint"></div>
                              </div>
                              <div class="form-group">
                                  <label for="password" class="control-label">Password</label>
                                  <input type="password" class="form-control" id="password" name="password" value="" required="required" title="Please enter your password">
                              </div>
                              <!-- <div id="loginErrorMsg" class="alert alert-error hide">Wrong username og password</div>  -->
                              	<div class="form-group">
                              		<label for="role" class="control-label">Role</label>
									<input type="radio" class="checkbox-inline" name="role" value="patient"> Patient
									<input type="radio" class="checkbox-inline" name="role" value="doctor"> Doctor
								</div>
                             	<div class="form-group">
                                  	<label for="captchaCode" class="control-label">Retype the characters from the picture:</label>    									
								<%
 									// Adding BotDetect Captcha to the page
 									Captcha captcha = Captcha.load(request, "CaptchaObject");
 									captcha.setUserInputID("captchaCode");

 									String captchaHtml = captcha.getHtml();
 									out.write(captchaHtml);
 								%> 
                                  	<input id="captchaCode" type="text" class="form-control" name="captchaCode" required="required" />
                          		</div>

                              <button type="submit" class="btn btn-info btn-block">Register</button>
                          </form>
                      </div>
                  </div>

              </div>
          </div>
      </div>
  </div>
</body>
</html>