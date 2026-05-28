<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h1>로그인</h1>
		<form action="/login" method="post">
			아이디(이메일) : <input type="text" name="email"><br>
			비밀번호 : <input type="text" name="password"><br>
			<input type="submit" value="로그인">
		</form>
</body>
</html>