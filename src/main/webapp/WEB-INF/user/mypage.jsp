<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="../../resource/css/boot.css">
    <link rel="stylesheet" href="../../resource/css/layout.css">
<style>
@import url("https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap");
body {
	display: flex; /* 자식 요소들을 Flex 아이템으로 만듭니다. */
	justify-content: space-around; /* 자식 요소들 사이에 균일한 공간을 만듭니다. */
	align-items: flex-start; /* 자식 요소들을 상단에 맞춥니다. */
}

/* 마이페이지 전체 컨테이너 */
.mypage-container {
	border: 1px solid var(--main-back);
	border-radius: 8px;
	padding: 30px 40px;
	width: 45%;
	height: 80vh;
	margin: 50px 20px;
	background-color: #fff;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	box-sizing: border-box;
	font-family: Arial, sans-serif;
	color: #333;
}

/* 제목 스타일 */
.mypage-container h1 {
	text-align: center;
	color: var(--main-back);
	margin-bottom: 25px;
	font-size: 28px;
}

/* 유저 정보 */
.user-info-box {
	display: flex;
	justify-content: space-between;
  	align-items: flex-start;
  	font-family: "Gowun Batang", serif;
    font-weight: 600;
    font-style: normal;
}

.user-info-list h5 {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
	font-size: 16px;
	font-weight: bold;
	background: #fff;
	padding: 5px 15px;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s, box-shadow 0.2s;
	width: 200px;	
}

.user-info-list p:first-of-type {
	font-weight: bold;
	font-size: 18px;
	color: var(--sub-back);
}

.user-info-list p span:first-child {
	font-weight: bold;
	color: #555;
	width: 80px;
	display: inline-block;
}

.user-info-image {
	border: 1px solid #ccc8;
	width: 200px;
	height: 300px;
	
	
}

.user-info-image img {
	width: 100%;
	border-radius: 5px;
}

/* 비밀번호 변경 섹션 */
.changePwd {
	margin-top: 30px;
	padding-top: 20px;
	border-top: 1px solid #ddd;
	display: flex;
	flex-direction: column;
	align-items: left;
	gap: 10px;
	opacity: 0.5;
}

.changePwd>span {
	display: flex;
	align-items: center;
	gap: 8px;
}

.changePwd button {
	background-color: var(--main-back);
	color: var(--main-color);
	border: none;
	padding: 6px 14px;
	border-radius: 4px;
	font-size: 14px;
	transition: background-color 0.2s;
	cursor: progress;
}

.changePwd button:hover {
	background-color: #79112C;
}

.changePwd input[type="password"] {
	width: 200px;
	padding: 4px 6px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

#checkPwdMsg {
	font-size: 13px;
	color: #990011;
	margin-top: 5px;
}

/* 탭 전환 기능 */
#turn-page-title {
	cursor: pointer;
}
/* 
.mypage-container {
    display: none;
}
.container-active {
    display: block;
}
*/

.msg-box{
	padding-left: 10px;
	padding-right: 20px;
}

table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 10px;
}

table td {
	background: #fff;
	padding: 5px 15px;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s, box-shadow 0.2s;
	cursor: pointer;
	overflow: auto;
}

table tr hover {
	transform: translateY(-2px);
	box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
}

.check, .content {
    padding: 0;
    background: none;
    border: none;
    box-shadow: none;
}
.check {
    text-align: center;
}
.content {
    padding-left: 15px;
}

.message-no {
	width: 100%;
	font-size: 14px;
	text-align: left;
	border: none;
	background: none;
	outline: none;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	padding: 0; /* 버튼 패딩 제거 */
	margin: 0; /* 버튼 마진 제거 */
}

.msg-container {
	display: flex;
	gap: 20px;
	height: 65vh;   /* 전체 컨테이너 높이 */
	align-items: stretch; /* 자식 요소 높이 동일 */
}

.msg-list {
	flex: 1;
	max-width: 50%;
	overflow-y: auto;
	scrollbar-width: none;
}

.msg-content-view {
	flex: 1;
	margin-top: 12px;
	overflow-y: auto;
	display: none;
	position: relative;
	background: #ddd3;
	padding: 20px 15px;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s, box-shadow 0.2s;
	cursor: pointer;
	font-family: "Gowun Batang", serif;
    font-weight: 600;
    font-style: normal;
}

.msg-content-box {
	margin-top: 20px;
	border: 1px solid ccc8;
}

.msg-btn-group {
    position: absolute;
    bottom: 20px;   /* div 아래쪽에서 20px 위 */
    left: 50%;      /* 가운데 기준 */
    transform: translateX(-50%); /* 정확히 중앙 */
}

.msg-btn-group button {
	margin: 5px;
	background-color: rgb(150,150,150);
	color: var(--main-color);
	border: none;
	padding: 6px 11px;
	cursor: pointer;
	border-radius: 4px;
	font-size: 13px;
	transition: background-color 0.2s;
}
.msg-btn-group button:hover {
	background-color: #79112C;
}
</style>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<jsp:include page="../side.jsp"></jsp:include>

    <div id="info-box" class="mypage-container container-active">
        <h1 id="turn-page-title" data-target="info-box">마이페이지</h1>
        <div class="user-info-box">
        <div class="user-info-list">
        	<h5>사원명</h5>
        	<p><sec:authentication property="principal.name" /></p>
            <h5>아이디(e-mail)</h5>
            <p><sec:authentication property="principal.email" /></p>
            <h5>부서</h5>
            <p><sec:authentication property="principal.deptName" /></p>
            <h5>직급</h5>
            <p><sec:authentication property="principal.gradeName" /></p>
            <h5>메모</h5>
            <textarea style="width:360px; font-size:1.2rem;">안녕하세요. 임상개발부 선임 김유나입니다.</textarea>
        </div>
        <div class="user-info-image">
			<img src="../../resource/static/woman1.png" width=200px; alt="여성 인물사진"/>
		</div>
		</div>
        <div class="changePwd">
            <span>비밀번호 변경 : <input type="password" name="password">
                <button id="checkReusePwd">중복체크</button>
                <button id="changePwd">변경</button>	
            </span>
            <p id="checkPwdMsg"></p>
        </div>
    </div>
    
    <div id="msg-box" class="mypage-container msg-box">
    	<h1 id="turn-page-title" data-target="msg-box">알 림</h1>
    	<div class="msg-container">	
    		<div class="msg-list">
    	<table>
    		<tbody>
    		<c:forEach items="${messageView}" var="list">
	    		<tr>
	    		<td class="check">
	    			<c:choose>
	    			<c:when test="${list.isRead == 0}">
	    				<span class="text-danger fw-bold" style="font-size: 1.7rem;" >!</span>
	    			</c:when>
	    			<c:otherwise>
	    				<span class="text-danger fw-bold" style="font-size: 1.7rem;" >　</span>
	    			</c:otherwise>
	    			</c:choose>
	    		</td>
	    		<td>
	    		<c:choose>
	    			<c:when test="${list.isRead == 0}">
	    			<button data-id="${list.messageNo}" 
                                    data-title="${list.title}" 
                                    data-content="${list.content}" 
                                    data-type="${list.type}"
                                    data-target="${list.targetId}"
                                    class="message-no"><b>${list.title}</b></button>
	    			</c:when>
	    			<c:when test="${list.isRead != 0}">
	    			<button data-id="${list.messageNo}" 
                                    data-title="${list.title}" 
                                    data-content="${list.content}" 
                                    data-type="${list.type}"
                                    data-target="${list.targetId}"
                                    class="message-no">${list.title}</button>
	    			</c:when>
	    		</c:choose>
	    		</td>
	    		</tr>
    		</c:forEach>
    		</tbody>
    	</table>
    	</div>
    	<div class="msg-content-view">
    		<h5 id="msg-title" style="font-weight:bolder; color:var(--main-back);"></h5>
    		<div class="msg-content-box">
            <p id="msg-content"></p>
            </div>
            <div class="msg-btn-group">
            <button type="button" class="transfer-page">이동</button>
            <button type="button" class="close-message">닫기</button>
            <button type="button" class="delete-message">삭제</button>
            </div>
    	</div>
    </div>
   	</div>
<script>

	
$(document).ready(function() {
    // '클릭 가능한 제목'을 클릭했을 때 이벤트 처리
    $('.clickable-title').on('click', function() {
        // 모든 컨테이너에서 활성화 클래스 제거
        $('.mypage-container').removeClass('container-active');
        
        // 클릭된 제목의 data-target 속성값을 가져옴
        const targetId = $(this).data('target');
        
        // 해당 ID를 가진 컨테이너에 활성화 클래스 추가
        $('#' + targetId).addClass('container-active');
    });
});

	   function turnPage(tabName){
	  	 $(".erp-detail-tab").removeClass("active");
	      $("#" + tabName + "Tab").addClass("active");
	      $("#detailContent > div").hide();
	      $("#" + tabName + "Content").show();
	  }
	
	  let hash = location.hash.replace("#", "");
	  if(hash) turnPage(hash);
	  else turnPage("member");
	
	  $(".erp-detail-tab").click(function(e){
	      e.preventDefault();
	      let tabName = $(this).attr("id").replace("Tab","");
	      turnPage(tabName);
	      location.hash = tabName;
	  });
	
	  $(window).on("hashchange", function(){
	      let hash = location.hash.replace("#", "");
	      if(hash) turnPage(hash); else showTab("member");
	  });
	  let openMessageId = null; 

	  $(".message-no").click(function() {
	      const messageNo = $(this).data("id");
	      const title = $(this).data("title");
	      const content = $(this).data("content");
	      const type = $(this).data("type");
	      const target = $(this).data("target");
			//console.log(target);
		
	      if (openMessageId === messageNo) {
	          $(".msg-content-view").hide();
	          openMessageId = null;
	      } else {
	          $("#msg-title").text(title);
	          $("#msg-content").text(content);
	          $(".msg-content-view").show();

	          $(".transfer-page").data("id", messageNo);
	          $(".transfer-page").data("type", type);
	          $(".transfer-page").data("target", target);
	          $(".delete-message").data("id", messageNo);
	          
	          openMessageId = messageNo;

	          $.ajax({
	              url: "/messageRead",
	              method: "post",
	              data: { messageNo: messageNo }
	          });
	      }
	  });
	  
	// 삭제 버튼 클릭 이벤트
	  $(".delete-message").click(function() {
	      const messageNo = $(this).data("id");
	      

	          $.ajax({
	              url: "/message/delete",
	              method: "post",
	              data: { messageNo: messageNo },
	              success: function() {
	                  alert("메시지가 삭제되었습니다.");
	                  location.reload(); // ✅ 응답 내용 확인 없이 바로 새로고침
	              },
	              error: function() {
	                  alert("오류가 발생했습니다.");
	              }
	          });
	  });
	  $(".transfer-page").click(function() {
		    if($(this).data("type") == 'schedule'){
		    	location.href = "/today/my";  
		    } else if ($(this).data("type") == 'approval'){
				location.href = "/approval/my";
		    } else if ($(this).data("type") == 'claim'){
		    	location.href = "/project/detail?projectId=" + $(this).data("target") +"#claim";
		    }
		});
	  
	 $(".close-message").click(()=>{
		 $(".msg-content-view").hide();
		 location.reload();
		 openMessageId = null;
	 });
</script>
</body>
</html>