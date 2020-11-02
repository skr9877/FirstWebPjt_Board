<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>

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

	<h1>Custom 로그인 페이지</h1>
	<h2><c:out value="${error}"/></h2>
	<h3><c:out value="${logout}"/></h3>
	
	<form role='form' method='post' action="/login">
		<fieldset>
			<div class="form-group">
				<input class="form-control" placeholder="userid" name="username" type="text" autofocus/>
			</div>
			
			<div class="form-group">
				<input class="form-control" placeholder="Password" name="password" type="password" value=""/>
			</div>
			<div class="checkbox">
				<label><input name="remember-me" type="checkbox">비밀번호 기억</label>
			</div>
			
			<a href="index.html" class="btn btn -lg btn-success btn-block">로그인</a>
		</fieldset>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
	
	<!--  jQuery -->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	
	<!--  BootStrap core js -->
	<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	
	<!--  Metis Menu Plugin Js -->
	<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>
	
	<!--  Custom Theme Js -->
	<script src="/resources/dist/js/sb-admin-2.js"></script>
	
	<script>
		$(".btn-success").on("click",function(e){
			e.preventDefault();
			alert("로그인 하셨습니다.");
			$("form").submit();
		});
	</script>
</body>
</html>