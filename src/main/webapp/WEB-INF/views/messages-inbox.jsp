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
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<style>
	.custab{
    border: 1px solid #ccc;
    padding: 5px;
    margin: 5% 0;
    box-shadow: 3px 3px 2px #ccc;
    transition: 0.5s;
    }
.custab:hover{
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
					<td>MessageId</td>
					<td>Sender</td>
					<td>subject</td>
					<td>Content</td>
					<td>AttachedFile</td>
					<td>Actions</td>
				</thead>
				<c:forEach items="${requestScope.messageList}" var="message">
					<tr>
						<td class="col-sm-1 col-md-1">${message.messageid}</td>
						<td class="col-sm-1 col-md-1">${message.sender.accountid}</td>
						<td class="col-sm-2 col-md-2">${message.subject}</td>
						<td class="col-sm-3 col-md-3">${message.content}</td>
						<td class="col-sm-2 col-md-2"><a
							href="${contextPath}/message/downloadFile.htm?filename=${message.attachedfile}">${message.attachedfile}</a></td>
						<td class="text-center col-sm-3 col-md-3">
						    <a href="${contextPath}/messages.htm?action=compose&replyReceiver=${message.sender.accountid}&reply=yes&subject=${message.subject}"
							class='btn btn-info btn-xs'><span class="glyphicon glyphicon-edit"></span> reply</a> 
							<a href="${contextPath}/messages.htm?action=delete&messageid=${message.messageid}" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span>delete</a>
					    </td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

</body>
</html>