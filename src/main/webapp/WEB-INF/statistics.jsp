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
        height: calc(100vh - 70px);
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

      /* 헤더 영역 (Flexbox) */
      header {
        position: fixed; /* 헤더 고정 */
        top: 0;
        left: 0;
        width: 100%;
        height: 70px; /* 헤더 높이 고정 */
        z-index: 100;
      }

      /* 사이드바 영역 (Flexbox) */
      aside {
        position: fixed; /* 사이드바 고정 */
        top: 70px; /* 헤더 아래에 위치 */
        left: 0;
        width: 200px; /* 사이드바 너비 고정 */
        height: calc(100vh - 70px); /* 헤더를 제외한 높이 */
        z-index: 99;
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

      .quadrant-banner {
        padding: 0;
        border: none;
        position: relative;
        overflow: hidden; /* 중요: 내부 요소가 div 밖으로 나갈 때 숨김 */
        max-height: 25px; 
        min-height: 25px; /* 배너의 높이 지정 */
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
      .deptChart {
        display:flex;
      	width: 100%;
      	height: 100%;
      	justify-content: center;
      }
      .deptChart #deptChart{
      	width: 100%;
      	height: 100%;
      }
/* =============== admin main page ============== */      
.slider-project {
	flex: 1;
}
.slider-chemical {
	flex: 1.3;
}
.slider-user {
	flex: 1.2;
}
.slider-approval {
	flex: 1;
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
      <div class="left-section">
      
      <div class="quadrant quadrant-graph slider-project">
          <div class="slider-container">
            <div class="slide active">
              <h3>프로젝트 현황</h3>
              <h5>
                각 그래프 클릭 시 현재 진행상황에 해당하는 프로젝트가
                조회됩니다.
              </h5>
              <jsp:include page="stat/projectcount.jsp" />
            </div>
            </div>
          </div>
          
      <div class="quadrant quadrant-graph slider-chemical">
        <div class="slider-container">
          <div class="slide active">
              <h3>시약 사용 현황</h3>
              <h5>각 그래프 클릭 시 현재 사용 중인 시약이 조회됩니다.</h5>
			  <jsp:include page="stat/chemicalChart.jsp" />
            </div>
        </div>
      </div>
      
      </div>
      <div class="right-section">
      <%-- Graph contents /
	        사용자 현황: 총 인원, 일/월별 신규 가입자 수, 현재 접속 중인 사용자 수  
			업무 현황: 진행 중인 프로젝트, 완료된 업무, 지연된 결재 건수, 시약 관련
			커뮤니티 활동: 최근 작성된 게시글, 댓글, 파일 업로드 수, 클레임 등
			시스템 상태: 서버 부하, 디스크 사용량, 최근 에러 로그 --%>
      
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
        
        <div class="quadrant quadrant-graph slider-user">
        <div class="slider-container">
         	<div class="slide active">
					<h3>조직 인사 현황</h3>
					<h5>부서별 인원 분포 현황을 확인할 수 있습니다.</h5>
					<jsp:include page="stat/deptChart.jsp" />
			</div> 
        </div>
        </div>
        
        <div class="quadrant quadrant-graph slider-approval">
      		<div class="slider-container">
      		<div class="slide active" onclick="location.href='/approval/my';">
              <h3>결재 진행 현황</h3>
              <h5>각 그래프 클릭 시 진행 중인 승인 내역이 조회됩니다.</h5>
			  <jsp:include page="stat/approvalStatusChart.jsp" />
      		</div>
	    	</div>
     	</div>
        </div>
    </main>

    <script>
    </script>
  </body>
</html>
