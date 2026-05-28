<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="../../resource/css/boot.css">
<link rel="stylesheet" href="../../resource/css/layout.css">
<script src="../resource/js/index.global.js"></script>

<style>
body {
	margin: 40px 10px;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
}

#calendar {
	max-width: 85%;
	max-height: 82vh;
	margin: 0 auto;
}

.fc-toolbar-chunk button {
	background : #A4193D !important;
	border: none !important;
}
.fc-toolbar {
	height: 100px;
	background: white;
	border-radius: 10px;
	padding : 0 20px 0 20px;
}
.fc-scrollgrid {
	border-radius: 10px !important;
	 overflow: hidden;
}
.fc-scrollgrid-sync-inner {
	background: #A4193D;
}

.fc-col-header-cell-cushion {
	color: white;
}

a {
	border-bottom: none !important;
	text-decoration: none;
}

.fc-daygrid-day-frame {
	background: white;
}

.fc-daygrid-day-top {
	color: #800000;
	background: white;
}

.fc-daygrid-day-top a {
	color: #800000;
}

.fc-daygrid-day-bottom a {
	color: #800000;
}

.fc-toolbar-title {
	font-weight: bolder;
	color: #A4193D;
}
</style>

<title>Schedule Calendar</title>
</head>
<body>

	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../side.jsp"></jsp:include>

	<div id='calendar'></div>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
			var calendarEl = document.getElementById('calendar');

			var calendar = new FullCalendar.Calendar(calendarEl, {
				headerToolbar : {
					left : 'prev,next today',
					center : 'title',
					right : 'dayGridMonth,timeGridWeek,timeGridDay'
				},
				initialView : 'dayGridMonth',
				locale : "ko",
				navLinks : true,
				selectable : true,
				selectMirror : true,
				editable : true,
				dayMaxEvents : true,

				events : function(fetchInfo, successCallback, failureCallback) {
					$.ajax({
						url : '/schedule/event',
						type : 'GET',
						dataType : 'json',
						success : function(data) {
							var events = data.map(function(item) {
								return {
									title : item.title,
									start : item.start,
									end : item.end,
									backgroundColor : item.backgroundColor,
									textColor : item.textColor,
									extendedProps : {
										type : item.type,
										projectId : item.projectId || null
									}
								};
							});
							successCallback(events);
						},
						error : function() {
							alert("캘린더 데이터 불러오기 실패!");
							failureCallback();
						}
					});
				},

				eventDidMount : function(info) {
					info.el.title = info.event.title;
					info.el.style.border = "none"; 
					info.el.style.borderRadius = "0"; 
				},

				eventClick : function(info) {
					var projectId = info.event.extendedProps.projectId;
					if (projectId) {
						window.location.href = '/project/detail?projectId='
								+ projectId;
					} else {
						alert("이 이벤트는 프로젝트와 연결되어 있지 않습니다.");
					}
				}
			});

			calendar.render();
		});
		
		document.body.appendChild(logoutModal); 
		logoutModal.style.zIndex = '99999'; 
	</script>

</body>
</html>
