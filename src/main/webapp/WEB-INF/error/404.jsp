<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/error.css"></link>
	<style>
		body {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  margin: 200px, 30px;
}


.title {
  display: flex;
  align-items: center;
  justify-content: center;
  /*font-size: 2rem;
  color: navy;
  background: linear-gradient(to bottom, #1c509c, #77dfcdd7);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;*/
  transform-style: preserve-3d;
}

.title div {
 margin: -30px;	   
}	

#zero {
  /*font-size: 2rem;
  color: navy;
  background: linear-gradient(to bottom, #1c509c, #77dfcdd7);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;*/
  
	animation: rotate360 4s linear infinite;
	transform-style: preserve-3d;
}
@keyframes rotate360 {
  from {
    transform: rotateY(0deg); /* 0도에서 시작 */
  }
  to {
    transform: rotateY(360deg); /* 360도로 회전하여 한 바퀴 완료 */
  }
}

#notfound {
  font-size: 2.5rem;
  font-weight: bold;
  background: linear-gradient(to right, #1c509c, #77dfcdd7);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  margin-top: 100px;
  margin-bottom: -10px;
}

#notexist {
  color: grey;
}

img {
	width: 200px;
}


	</style>	
</head>
<body>
	<div class="title">
	
	<div><img src="../resource/static/no4.png" width="200px" alt="숫자 4"></div>
	<div id="zero"><img src="../resource/static/no0.png" width="200px" alt="숫자 0"></div>
	<div><img src="../resource/static/no4.png" width="200px" alt="숫자 4"></div>
	
	</div>
	
	<p id="notfound">페이지를 찾을 수 없습니다</p>
	<p id="notexist">요청하신 페이지가 존재하지 않거나 삭제되었습니다.</p>
	
</body>
</html>
