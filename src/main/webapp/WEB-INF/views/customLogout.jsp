<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Logout Page</title>

<!--  BootStrap Core Css -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!--  Metismenu Css -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom Css -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Font -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>

	<h1>Custom 로그아웃 페이지</h1>
	
	<div class="col-md-4 cold-md-offset-4">
		<form id="logoutForm" method="post" action="/customLogout">			
			<button class="btn btn-lg btn-success btn-block">로그아웃</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
	</div>
	
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

	<script>
	$(document).ready(function(e){
		console.log("submit clicked");
		
		var logoutForm = $("#logoutForm");
		
		logoutForm.on("click", function(e){
			e.preventDefault();
			
			alert("로그아웃하였습니다.");
			logoutForm.submit();
		});
	});
	</script>
	
			

</body>

</html>