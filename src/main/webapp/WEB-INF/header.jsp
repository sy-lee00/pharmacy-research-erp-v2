<%@page import="com.sh.haagendazo.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page import="org.springframework.security.core.Authentication"%>
<%@ page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="com.sh.haagendazo.model.User"%>
<%@ page import="com.sh.haagendazo.service.UserService"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Quantico:ital,wght@0,400;0,700;1,400;1,700&display=swap')
	;

@import
	url('https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap')
	;

.company a {
	text-decoration: none; /* 밑줄 제거 */
	color: inherit; /* 부모 요소의 색상을 상속받음 */
}

.current-time {
	background-color: #ffd7ed1f;
	border-radius: 8px;
	padding: 7px 25px;
	font-size: 15px;
	font-weight: bolder;
	color: #fff;
	margin: 10px 30px;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	font-family: "Gowun Batang", serif;
	font-style: normal;
}

.user-role {
	position: relative; /* 자식 요소인 툴팁의 위치 기준이 됩니다. */
}

.role-tooltip {
	position: absolute;
	top: 100%;
	left: -200%;
	transform: translateX(-50%);
	background-color: #333;
	color: #fff;
	padding: 15px;
	border-radius: 4px;
	font-size: 12px;
	transition: opacity 0.3s; /* 부드러운 효과 */
	z-index: 100; /* 다른 요소 위에 표시되도록 합니다. */
}

/* 알림 컨테이너 */
.notification-container {
	position: relative; /* 자식 요소인 카운트와 박스 위치 기준 */
	display: block;
}

.notification-count {
	position: absolute;
	top: -8px;
	right: 12px;
	background-color: red;
	color: white;
	font-size: 11px;
	font-weight: bold;
	border-radius: 25%;
	padding: 2px 2px;
	min-width: 18px;
	text-align: center;
}

/* 알림 텍스트 박스 스타일 */
.notification-box {
	font-size: 12px;
	display: none;
	position: absolute;
	top: 35px;
	left: -100%;
	transform: translateX(-50%);
	border-radius: 10px;
	background: rgba(0, 0, 0, 0.6);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	padding: 15px;
	margin: 0 auto;
	min-width: 200px;
	z-index: 1000;
	white-space: nowrap;
}

.notification-item {
	margin-bottom: 5px;
}

.notification-box.hidden {
	display: none;
}
</style>
<%
int approvalCount = 0;
int rejectCount = 0;
int scheduleCount = 0;
int claimCount = 0;
int total = 0; // 기본값

Authentication auth = SecurityContextHolder.getContext().getAuthentication();
if (auth != null && auth.getPrincipal() instanceof User) {
	User loginUser = (User) auth.getPrincipal();
	int id = loginUser.getUserId();

	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
	UserService service = (UserService) ctx.getBean("userService"); // Bean 이름 확인

	approvalCount = service.countApproval(id);
	rejectCount = service.countReject(id);
	scheduleCount = service.countSchedule(id);
	claimCount = service.countClaim(id);

	total = approvalCount + rejectCount + scheduleCount + claimCount;
}
%>
<header>
	<sec:authorize access="hasAnyRole('RESEARCHER','MANAGER')">
		<h1 class="company">
			<a id="logo" href="/">Häagen-Dazo</a>
		</h1>
	</sec:authorize>	
	<sec:authorize access="hasRole('ADMIN')">
		<h1 class="company">
			<a id="logo" href="/statistics">Häagen-Dazo</a>
		</h1>
	</sec:authorize>
	
	<sec:authorize access="isAuthenticated()">
		<form action="/project/searchBar" method="get" class="header-search">
			<input type="text" id="search" name="search"
				placeholder="검색을 원하시는 프로젝트를 입력해주세요.">
			<button type="submit">검색</button>
		</form>
		<div class="current-time">
			<span id="date"></span><span
				style="font-weight: normal; color: black;">|</span><span id="timer"></span>
		</div>
		<div class="header-links">
			<sec:authorize access="hasAnyRole('RESEARCHER','MANAGER')">
				<div class="notification-container">
					<a href="#" style="padding-right: 30px;"> <i
						class="fas fa-bell" style="font-size: 20px;"></i>
					</a>
					<% if (total != 0) {%>
					<span class="notification-count"><%=total%></span>
					<%}	%>
					<div class="notification-box hidden">
							<a href="/mypage"><div class="notification-item">
								'<%=scheduleCount%>건'의 스케쥴 알림이 있습니다.
							</div></a> 
							<a href="/mypage"><div class="notification-item">
								요청하신 결재 '<%=rejectCount%>건'이 반려되었습니다.
							</div></a> 
							<a href="/mypage"><div class="notification-item">
								요청하신 결재 '<%=approvalCount%>건'이 승인되었습니다.
							</div></a>
							<a href="/mypage"><div class="notification-item">
								클레임 처리 '<%=claimCount%>건'이 있습니다.
							</div></a>
					</div>
				</div>
				<div>
					<a href="/mypage" class="user-role"
						data-role="${pageContext.request.userPrincipal != null ? pageContext.request.userPrincipal.authorities[0].authority : ''}">
						<i class="fa-solid fa-user" style="font-size: 20px;"></i>
					</a>
				</div>
			</sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
				<a href="/user" class="user-role" data-role="${pageContext.request.userPrincipal != null ? pageContext.request.userPrincipal.authorities[0].authority : ''}">
					<i class="fa-solid fa-user-gear" style="font-size:20px; margin-right:10px;"></i>Admin
				</a>
			</sec:authorize>
		</div>
	</sec:authorize>
</header>

<script>
	$(document)
			.ready(
					function() {
						$('.user-role')
								.hover(
										function() {
											const role = $(this).data('role');
											if (role) {
												// 툴팁 생성
												//const tooltip = $('<div>').addClass('role-tooltip').html("해당 사원은 <br>" + role + "<br> 권한을 가지고 있습니다.");
												if (role == 'ROLE_RESEARCHER'
														|| 'ROLE_MANAGER') {
													const tooltip = $('<div>')
															.addClass(
																	'role-tooltip')
															.html(
																	'마이페이지 <br><span style="color: #ccc8;">('
																			+ role
																			+ ')</span>');
													$(this).append(tooltip);
												} else if (role == 'ROLE_ADMIN') {
													const tooltip = $('<div>')
															.addClass(
																	'role-tooltip')
															.html(
																	'어드민페이지 <br><span style="color: #FFDFB9;">('
																			+ role
																			+ ')</span>');
													$(this).append(tooltip);
												}
												tooltip.stop().animate({
													opacity : 1
												}, 200);
											}
										},
										function() {
											$(this).find('.role-tooltip')
													.stop().animate({
														opacity : 0
													}, 200, function() {
														$(this).remove();
													});
										});

						// 날짜와 시간을 표시할 DOM 요소를 선택합니다.
						const date = document.querySelector("#date");
						const timer = document.querySelector("#timer");

						// 날짜 업데이트 함수를 정의합니다.
						function updateDate() {
							if (date) {
								const now = new Date();
								const year = now.getFullYear();
								const month = (now.getMonth() + 1).toString()
										.padStart(2, '0');
								const day = now.getDate().toString().padStart(
										2, '0');
								const daysOfWeek = [ '일', '월', '화', '수', '목',
										'금', '토' ];
								const dayOfWeek = daysOfWeek[now.getDay()];

								date.textContent = year + "-" + month + "-"
										+ day + " (" + dayOfWeek + ")";
							}
						}

						// 타이머 업데이트 함수를 정의합니다.
						function updateTimer() {
							if (timer) {
								timer.textContent = " "
										+ new Date().toLocaleTimeString(
												'ko-KR', {
													hour12 : true
												});
							}
						}

						// 모든 함수 정의가 끝난 후, 이 부분에서 함수를 호출하여 실행합니다.
						updateDate();
						updateTimer();
						setInterval(updateTimer, 1000);

					});

	const notificationIcon = document.querySelector('.fa-bell');
	const notificationBox = document.querySelector('.notification-box');

	//아이콘 클릭 시 알림 박스 토글
	if (notificationIcon != null) { // 관리자로 로그인 시 notificationIcon이 null로 받아져 error 발생하므로 조건문으로 막아둠
		notificationIcon
				.addEventListener(
						'click',
						function(event) {
							event.preventDefault(); // 링크 이동 방지
							notificationBox.style.display = notificationBox.style.display === 'block' ? 'none'
									: 'block';
						});

		// 알림 박스 외 다른 곳 클릭 시 닫기
		document.addEventListener('click', function(event) {
			if (!notificationIcon.contains(event.target)
					&& !notificationBox.contains(event.target)) {
				notificationBox.style.display = 'none';
			}
		});
	}
</script>
