<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="/register" method="post">
		아이디(이메일) : <input type="text" name="email"><br>
		비밀번호 : <input type="text" name="password"><br>
		이름 : <input type="text" name="name"><br>
		<input type="submit" value="회원가입">
	</form>
</body>
</html>