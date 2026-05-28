<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ERP</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.5.0/dist/chart.umd.min.js"></script>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
    />
    <link rel="stylesheet" href="../../resource/css/layout.css" />
    <link rel="shortcut icon" href="../resource/favicon.ico" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap");
      :root {
        --main-color: #fcf6f5;
        --main-back: #a4193d;
        --pd-left: 270px;
        --pd-top: 70px;
      }

      body {
        display: flex;
        margin: 0;
        padding-left: var(--pd-left);
        padding-top: var(--pd-top);
        flex-direction: column;
        background: transparent;
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        background-blend-mode: color;
        background-color: #fcf6f5;
      }

      /* 메인 컨텐츠 영역: 왼쪽/오른쪽 섹션을 가로로 배치 */
      .main-content {
        flex-grow: 1;
        margin: 10px;
        padding-top: 10px;
        box-sizing: border-box;
        display: flex; /* Flexbox 활성화 */
        gap: 20px; /* 섹션 간의 간격 */
        background-color: #fcf6f5;
        overflow-y: auto; /* 내용이 넘칠 경우 스크롤 허용 */
      }

      /* 왼쪽 섹션 */
      .left-section {
        display: flex;
        flex-direction: column;
        gap: 20px;
        flex: 1;
        min-width: 0; /* Flexbox 너비 문제 방지 */
      }

      /* 오른쪽 섹션 */
      .right-section {
        display: flex;
        flex-direction: column;
        gap: 15px;
        flex: 1;
        min-width: 0; /* Flexbox 너비 문제 방지 */
      }

      /* section 내 스타일 */
      .quadrant {
        flex-grow: 1;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 15px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: flex-start;
        font-size: 1em;
        color: #555;
        text-align: left;
        overflow: hidden; /* 내용이 넘칠 경우 숨김 */
        background-color: rgba(252, 246, 245, 0.8);
        background-image: none; /* 배경 이미지 제거 */
      }

      .quadrant-chem {
        background-image: url(../../resource/static/lab3.jpg);
        background-size: cover;
        background-position: center;
        background-blend-mode: color;
        background-color: rgba(0, 0, 0, 0.4);
        justify-content: center;
        align-items: center;
      }
	  #quad-title {
	  	text-shadow: 0 0 5px white;
	  }
		
      .quadrant a {
        text-decoration: none;
        color: var(--main-back);
        font-size: 1.5rem;
        font-family: "Gowun Batang", serif;
        font-weight: 600;
        font-style: normal;
      }
      .quadrant h3 {
        margin: 3px;
        font-size: 19px;
      }
      .quadrant-notice {
        min-height: 350px;
        max-height: 350px;
        background-image: url(../../resource/static/notice.jpg);
        background-size: cover;
        background-position: center;
        background-blend-mode: multiply;
        background-color: rgba(0, 0, 0, 0.6);
      }

      .quadrant-notice h3 {
        font-size: 26px;
      }

      .quadrant-banner {
        padding: 0;
        border: none;
        position: relative;
        overflow: hidden; /* 중요: 내부 요소가 div 밖으로 나갈 때 숨김 */
        height: 25px; /* 배너의 높이 지정 */
        width: 100%;
      }
      .banner-animation {
        display: flex;
        height: 100%;
        width: fit-content; /* 내부 콘텐츠의 총 너비만큼 컨테이너 확장 */
        align-items: center;
        white-space: nowrap;
        animation: moveBanner 12s linear infinite;
      }

      .banner-animation p,
      .banner-animation img {
        margin: 0 5px;
        height: 100%;
        max-height: 90px;
        object-fit: contain;
        flex-shrink: 0;
        font-size: 1rem;
        font-weight: bold;
        color: var(--main-back);
        opacity: 0.85;
      }

      /* @keyframes를 사용하여 애니메이션 정의 */
      @keyframes moveBanner {
        from {
          transform: translateX(0);
        }
        to {
          transform: translateX(-61%);
        }
      }
      .quadrant-graph {
        padding: 5px;
        height: 400px;
      }
      .quadrant-graph h3 {
        margin: 2px;
      }
      /* slide */
      .slider-container {
        position: relative;
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
      }
      .slide {
        display: none;
        width: 95%;
        height: 80%;
      }
      .slide.active {
        display: block;
      }

      .slider-container h3 {
        font-size: 20px;
        text-align: center;
        margin: 5px 0;
      }
      .slider-container h5 {
        font-size: 15px;
        text-align: center;
        margin: 5px;
        color: rgba(0, 0, 0, 0.25);
      }

      /* slide 전환 버튼 */
      .slider-controls {
        display: flex;
        flex-direction: column;
        justify-content: flex-end; /* 버튼을 오른쪽 끝으로 정렬 */
        align-items: center;
        position: absolute; /* 컨테이너 내에서 절대 위치 지정 */
        bottom: 10px;
        right: 10px;
      }
      .slider-controls button {
        border: none;
        padding: 5px 5px;
        font-size: 1em;
        font-weight: bold;
        color: #ccc;
        cursor: pointer;
        border-radius: 4px;
        user-select: none;
        transition: background-color 0.3s;
        transform: rotate(90deg); /* 90도 회전 */
      }
      .slider-controls button:hover {
        color: #999;
      }

      table {
        width: 100%;
        min-height: 220px;
        max-height: 220px;
        background-color: rgba(255, 255, 255, 0.1);
        border-collapse: collapse;
        margin: 20px 0;
        color: #ddd;
        table-layout: auto;
      }

      table th,
      table td {
        padding: 10px;
        border: none;
        font-size: 13px;
        max-width: 250px;
      }

      table td {
        font-size: 13px;
        color: grey;
        vertical-align: top;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
      }

      .quadrant-notice table td {
        color: rgba(240, 240, 240, 0.7);
      }

      table th {
        background-color: rgba(0, 0, 0, 0.2);
        border-bottom: 1px solid #fff;
      }

      tr:nth-child(even) {
        background-color: rgba(0, 0, 0, 0.1);
      }

      tr:nth-child(odd) {
        background-color: rgba(0, 0, 0, 0.2);
      }
      .deptChart {
      	padding-top: 10px;
        display:flex;
      	width: 100%;
      	height: 100%;
      	justify-content: center;
      }
      .deptChart #deptChart{
      	width: 100%;
      	height: 100%;
      }
    </style>
  </head>
  <body>
    <header>
      <jsp:include page="header.jsp"></jsp:include>
    </header>
    <aside>
      <jsp:include page="side.jsp"></jsp:include>
    </aside>
    <main class="main-content">
      <%-- 좌측 섹션 --%>
      <div class="left-section">
        <div class="quadrant">
          <sec:authorize access="hasRole('RESEARCHER')">
          <h3>
            <a id="quad-title" href="/today/my"
              ><sec:authentication property="principal.name"
            /></a>
            님의 일정 목록
          </h3>
          </sec:authorize>
          <sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
          	<h3>
            <a id="quad-title" href="/today/my">최근 일정 목록</a>
          </h3>
          </sec:authorize>
          
          <table id="today">
            <thead>
              <tr>
                <th>No</th>
                <th>일정명</th>
                <th>일정 내용</th>
                <th>시작일 - 종료일</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${today}" var="today" varStatus="status">
                <tr>
                  <td>${status.count}</td>
                  <td>${today.title}</td>
                  <td>${today.scheDescription}</td>
                  <td>
                    <fmt:formatDate
                      value="${today.scheStartDatetime}"
                      pattern="yyyy-MM-dd"
                    />
                    ~
                    <fmt:formatDate
                      value="${today.scheEndDatetime}"
                      pattern="yyyy-MM-dd"
                    />
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <div class="quadrant">
        <sec:authorize access="hasRole('RESEARCHER')">
          <h3>
            <c:forEach items="${log}" var="log">
              <a id="quad-title" href="/project/detail?projectId=${log.projectId}#claim">
              </c:forEach>
              <sec:authentication property="principal.name" /></a>님의 클레임 목록
          </h3>
          <sec:authentication property="principal.userId" var="userId" />
          </sec:authorize>
          <sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
          	<h3><a id="quad-title" href="/customer/log">최근 클레임 목록</a></h3>
          </sec:authorize>
          <sec:authorize access="hasRole('RESEARCHER')">
          <table id="myLog">
            <thead>
              <tr>
                <th>No</th>
                <th>작성자</th>
                <th>프로젝트명 (코드)</th>
                <th>요약</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${log}" var="log" varStatus="status">
                <tr>
                  <td>${status.count}</td>
                  <td>${log.name}</td>
                  <td>${log.projectName} (${log.projectCode})</td>
                  <td>${log.clDescription}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          </sec:authorize>
          <sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
          <table id="allLog">
            <thead>
              <tr>
                <th>No</th>
                <th>작성자</th>
                <th>프로젝트명 (코드)</th>
                <th>요약</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${allLog}" var="allLog" varStatus="status">
                <tr>
                  <td>${status.count}</td>
                  <td>${allLog.name}</td>
                  <td>${allLog.projectName} (${allLog.projectCode})</td>
                  <td>${allLog.clDescription}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          </sec:authorize>
        </div>
        <div class="quadrant quadrant-chem">
          <a id="quad-title" href="/chemical/list">시약 관리 목록</a>
        </div>
      </div>

      <%-- 우측 섹션 --%>
      <div class="right-section">
        <div class="quadrant quadrant-banner">
          <!-- style="display:none;" -->
          <div class="banner-animation">
            <img src="../../resource/static/banner.png" width="12%" alt="메인화면 배너 이미지" />
            <p style="color: grey">인류의 내일을 위한 건강산업의 글로벌 리더</p>
            <p>Häagen-Dazo 와 함께 미래를 만들어갑니다</p>
            <img src="../../resource/static/banner.png" width="12%" alt="메인화면 배너 이미지" />
            <p style="color: grey">인류의 내일을 위한 건강산업의 글로벌 리더</p>
            <p>Häagen-Dazo 와 함께 미래를 만들어갑니다</p>
          </div>
        </div>

        <div class="quadrant quadrant-notice">
          <a id="quad-title" style="color: var(--main-color)"><h3>공지사항</h3></a>
          <table id="notice">
            <thead>
              <tr>
                <th>No</th>
                <th>제목</th>
                <th>내용</th>
                <th>작성일</th>
                <th style="width: 20px">이동</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${list}" var="board" varStatus="status">
                <tr>
                  <td>${status.count}</td>
                  <td>${board.title}</td>
                  <td>${board.content}</td>
                  <td>
                    <fmt:formatDate
                      value="${board.updatedAt}"
                      pattern="yyyy-MM-dd"
                    />
                  </td>
                  <td>
                  <button type="button"
						style="border: none; background: transparent; cursor: pointer; transform: rotate(-90deg);"
						onclick="window.open('/customer/view?boardNo=${board.boardNo}', 
                         'boardWindow', 
                         'width=900,height=475,top=200,left=100,scrollbars=yes,resizable=yes');">
						🔻</button>
					</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <div class="quadrant quadrant-graph">
        
        <%-- Graph contents /
	        사용자 현황: 총 인원, 일/월별 신규 가입자 수, 현재 접속 중인 사용자 수  
			업무 현황: 진행 중인 프로젝트, 완료된 업무, 지연된 결재 건수, 시약 관련
			커뮤니티 활동: 최근 작성된 게시글, 댓글, 파일 업로드 수, 클레임 등
			시스템 상태: 서버 부하, 디스크 사용량, 최근 에러 로그 --%>
          <div class="slider-container">
            <div class="slide active">
            <sec:authorize access="hasRole('RESEARCHER')">
              <h3>나의 프로젝트 현황</h3>
              <h5>
                각 그래프 클릭 시 현재 진행상황에 해당하는 프로젝트가
                조회됩니다.
              </h5>
              <jsp:include page="stat/projectMyCount.jsp" />
            </sec:authorize>
            <sec:authorize access="hasRole('MANAGER')">  
              <h3>프로젝트 현황</h3>
              <h5>
                각 그래프 클릭 시 현재 진행상황에 해당하는 프로젝트가
                조회됩니다.
              </h5>
              <jsp:include page="stat/projectcount.jsp" />
            </sec:authorize>  
            </div>
			<div class="slide" onclick="location.href='/approval/my'";>
	            <sec:authorize access="hasRole('RESEARCHER')">
	              <h3>나의 결재 현황</h3>
	              <h5>
	                그래프 클릭 시 현재 진행상황에 해당하는 결재건이
	                조회됩니다.
	              </h5>
	              <jsp:include page="stat/approvalStatusChart.jsp" />
	            </sec:authorize>
	            <sec:authorize access="hasRole('MANAGER')">  
	              <h3>승인 요청 현황</h3>
	              <h5>
	                그래프 클릭 시 현재 진행상황에 해당하는 결재건이
	                조회됩니다.
	              </h5>
	              <jsp:include page="stat/approvalStatusChart.jsp" />
	            </sec:authorize>  
	            </div>
				<div class="slider-controls">
              <button class="prevSlideBtn">◀</button>
              <button class="nextSlideBtn">▶</button>
            </div>
          </div>
        </div>
      </div>
    </main>

    <script>
      $(document).ready(function () {
        $(".slider-container").each(function () {
          const $quadrant = $(this);
          let currentIndex = 0;
          const $slides = $quadrant.find(".slide");
          const totalSlides = $slides.length;

          $quadrant.find(".prevSlideBtn").click(function () {
            $slides.eq(currentIndex).removeClass("active");
            currentIndex = (currentIndex - 1 + totalSlides) % totalSlides;
            $slides.eq(currentIndex).addClass("active");
          });

          $quadrant.find(".nextSlideBtn").click(function () {
            $slides.eq(currentIndex).removeClass("active");
            currentIndex = (currentIndex + 1) % totalSlides;
            $slides.eq(currentIndex).addClass("active");
          });
        });
      });
    </script>
  </body>
</html>
