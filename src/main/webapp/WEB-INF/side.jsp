<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
/* 모달 배경 */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100% !important;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); 
    justify-content: center;
    align-items: center;
}

/* 모달 내용 박스 */
.modal-content {
    background-color: rgba(255, 255, 255, 0.9);
    padding: 30px;
    border-radius: 8px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    animation: fadeIn 0.3s ease-out; /* 페이드인 애니메이션 효과 */
    width: 100%;
}

.modal p {
	margin-top: 0;
    margin-bottom: 20px;
    font-size: 1.1em;
    color: var(--main-back);
    font-weight: bold;
}

/* 모달 버튼 */
.modal-buttons button {
    padding: 8px 20px;
    margin: 0 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1em;
}

#confirmLogout {
    background-color: var(--main-back);
    color: #fff;
}

#confirmLogout:hover {
    background-color: #7a000e;
}

#cancelLogout {
    background-color: #ccc;
    color: #333;
}

#cancelLogout:hover {
    background-color: #bbb;
}
</style>

<div class="side">
  <h1 class="logo"><a id="logo" href="/"></a></h1>
    
    <sec:authorize access="isAuthenticated()">
    <div class="menu-group">
      <div class="menu-title">프로젝트 관리</div>
      <div class="submenu">
		<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
        <a href="/project/list">모든 프로젝트</a>
		</sec:authorize>
		<%-- (로그인된 관리자 기준) 전체 프로젝트 조회 + 관련 기능
         	 (당일 날짜 기준) 최근 등록된 프로젝트 / 사용자 / 업로드 문저 확인 --%>
		<sec:authorize access="hasRole('RESEARCHER')">
        <a href="/project/my">나의 프로젝트</a>
        <%-- (로그인된 연구원 기준) 참여하고 있는 프로젝트 조회 --%>
        </sec:authorize>
        <sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
        <a href="/chemical/list">시약 사용 관리</a>
        <%-- (로그인된 관리자 기준) + 일정 수량 미만일 경우, 경고창 노출 --%>
        </sec:authorize>
        <sec:authorize access="hasRole('RESEARCHER')"> 
       	<a href="/chemical/list">시약 사용 알림</a>
        <%-- (로그인된 연구원 기준) 최근 사용한 시약 조회 및 수량 알림 --%>
        </sec:authorize>
        <sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
        <a href="/approval">승인 대기 관리</a>
        <%-- (로그인된 관리자 기준) + 리스트 추가, 수정, 승인할 수 있는 기능 추가 --%>
        </sec:authorize>
        <sec:authorize access="hasRole('RESEARCHER')"> 
        <a href="/approval/my">승인 요청 항목</a>
        <%-- (로그인된 연구원 기준) 승인해야 할, 요청한 승인 리스트 출력 --%>
        </sec:authorize>
      </div>
    </div>
    </sec:authorize>
    
    <sec:authorize access="isAuthenticated()">
    <div class="menu-group">
      <div class="menu-title">일정 관리</div>
      <div class="submenu">
      
      	<sec:authorize access="hasRole('RESEARCHER')">
      	<a href="/today/my">오늘의 일정</a>
        <%-- (로그인된 연구원 기준 / 당일 날짜 기준) 진행 중인 스케쥴 조회 --%>
        </sec:authorize>
        <sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
      	<a href="/today/my">전체 일정 조회</a>
        </sec:authorize>
        <a href="/schedule">스케쥴 캘린더</a>
        <%-- FULLCALENDAR.API 를 활용하여 DB와 연동될 수 있게끔 설정 --%>
      </div>
    </div>
    </sec:authorize>
    
    <sec:authentication property="principal.deptId" var="dept"/>
    <sec:authorize access="hasAnyRole('MANAGER','ADMIN') or (#dept != null and #dept == 15)">
    <div class="menu-group">
      <div class="menu-title">고객 관리</div>
      <div class="submenu">
      	<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
       	<a href="/customer">고객 리스트 조회</a>
       	<%-- (로그인된 관리자 기준) 고객 리스트 조건별 조회 기능 --%>
        </sec:authorize>
	        <a href="/customer/log">고객 상담 관리</a>
	        <%-- (로그인된 연구원 기준) 본인에게 배정된 클레임 리스트 확인 --%>
	        <%-- (로그인된 관리자 기준) + 전체 클레임 리스트 조회 및 담당자 배분 가능 --%>
	        <%-- (로그인된 유저가 '고객서비스부' 일 경우) + 편집 및 로그 작성 기능 추가 --%>
	    <sec:authorize access="hasAnyRole('MANAGER','ADMIN')">    
	        <a href="/customer/board">게시판 목록</a>
	        <%-- (게스트) 클레임 작성 가능 --%>
	        <%-- (로그인된 관리자 기준) 공지사항 작성 가능 --%>
        </sec:authorize>
      </div>
    </div>
    </sec:authorize>
	<sec:authorize access="isAuthenticated()">
	<div class="menu-group">
		<div class=" menu-title logout">
			<a href="/logout" id="logoutLink"
				style="display: block; padding: 0; color: inherit; text-decoration: none;">
				<i class="bi bi-door-open" style="margin-right: 8px;"></i> 로그아웃</a>
		</div>
	</div>
		
			<div id="logoutModal" class="modal">
				<div class="modal-content">
					<p>로그아웃 하시겠습니까?</p>
					<div class="modal-buttons logout-modal-buttons">
						<button id="confirmLogout" style="width:60px; height: 37px; padding:0;">확인</button>
						<button id="cancelLogout" style="width:60px; height: 37px; padding:0;">취소</button>
					</div>
				</div>
			</div>
	</sec:authorize>
</div>

<script>
	
const logoutLink = document.getElementById('logoutLink');
const logoutModal = document.getElementById('logoutModal');
const confirmButton = document.getElementById('confirmLogout');
const cancelButton = document.getElementById('cancelLogout');

// 로그아웃 링크 클릭 이벤트
logoutLink.addEventListener('click', (event) => {
    event.preventDefault(); // 기본 링크 이동 동작 막기
    logoutModal.style.display = 'flex'; // 모달 창 보이게 하기
});

// '확인' 버튼 클릭 이벤트
confirmButton.addEventListener('click', () => {
    window.location.href = logoutLink.href; // 실제 로그아웃 페이지로 이동
});

// '취소' 버튼 클릭 이벤트
cancelButton.addEventListener('click', () => {
    logoutModal.style.display = 'none'; // 모달 창 숨기기
});

// 모달 외부 클릭 시 닫기
window.addEventListener('click', (event) => {
    if (event.target === logoutModal) {
        logoutModal.style.display = 'none';
    }
});
  
 /* document.addEventListener("DOMContentLoaded", () => {
    const menuGroups = document.querySelectorAll(".menu-group");
    const currentPath = window.location.pathname; // 현재 페이지의 경로

    // 세션 스토리지에서 열려있던 메뉴 그룹 ID 배열 가져오기
    const openedGroups = JSON.parse(sessionStorage.getItem('openedMenuGroups')) || [];

    menuGroups.forEach((group) => {
      const menuTitle = group.querySelector(".menu-title");
      const submenu = group.querySelector(".submenu");
      const submenuLinks = submenu.querySelectorAll("a");
      const groupId = group.dataset.groupId; // 각 메뉴 그룹에 고유 ID 부여

      // 1. 메뉴 타이틀 클릭 시 드롭다운 토글 및 상태 저장
      menuTitle.addEventListener("click", () => {
        group.classList.toggle("open");

        // 세션 스토리지에 열린 상태 저장 또는 제거
        if (group.classList.contains("open")) {
          if (!openedGroups.includes(groupId)) {
            openedGroups.push(groupId);
          }
        } else {
          const index = openedGroups.indexOf(groupId);
          if (index > -1) {
            openedGroups.splice(index, 1);
          }
        }
        sessionStorage.setItem('openedMenuGroups', JSON.stringify(openedGroups));
      });

      // 2. 현재 페이지에 해당하는 서브메뉴 열기 및 링크 활성화
      let shouldOpenGroup = false;
      submenuLinks.forEach((link) => {
        // 링크의 href 속성을 가져와 현재 경로와 비교
        // 현재 경로가 링크의 href로 시작하는 경우 활성 상태로 간주
        if (
          link.getAttribute("href") &&
          currentPath.startsWith(link.getAttribute("href"))
        ) {
          // 'active' 클래스를 다른 링크에서 제거하고 현재 링크에만 추가 (단일 활성 유지)
          // 먼저 모든 링크에서 'active' 클래스를 제거 (새로운 페이지 로드 시 필요)
          submenuLinks.forEach(l => l.classList.remove('active'));
          link.classList.add("active"); // 활성 링크에 'active' 클래스 추가
          shouldOpenGroup = true; // 이 링크를 포함하는 메뉴 그룹을 열어야 함
        }
      });

      // 3. 페이지 로드 시, 세션 스토리지 정보와 현재 페이지 상태를 기반으로 메뉴 열기
      if (shouldOpenGroup || openedGroups.includes(groupId)) {
        group.classList.add("open"); // 해당 메뉴 그룹 열기
        menuTitle.classList.add("active"); // 해당 메뉴 타이틀 활성화 (선택 사항)
      }
    });
  });  */
  
  document.addEventListener("DOMContentLoaded", () => {
	    const menuGroups = document.querySelectorAll(".menu-group");
	    const currentPath = window.location.pathname; // 현재 페이지의 경로

	    menuGroups.forEach((group) => {
	        const menuTitle = group.querySelector(".menu-title");
	        const submenuLinks = group.querySelectorAll(".submenu a");
	        let groupHasActiveLink = false;

	        submenuLinks.forEach((link) => {
	            const linkPath = link.getAttribute("href");

	            if (currentPath.startsWith('/project/detail')) {
	                if (linkPath === '/project/list' || linkPath === '/project/my') {
	                    link.classList.add("active");
	                    groupHasActiveLink = true;
	                } else {
	                    link.classList.remove("active");
	                }
	            } 
	            else if (linkPath === currentPath) {
	                link.classList.add("active");
	                groupHasActiveLink = true;
	            } else {
	                link.classList.remove("active");
	            }
	        });

	        // 서브메뉴에 활성 링크가 있으면 해당 메뉴 그룹에 'open' 클래스와 'active' 클래스 추가
	        if (groupHasActiveLink) {
	            group.classList.add("open");
	            menuTitle.classList.add("active");
	        } else {
	            group.classList.remove("open");
	            menuTitle.classList.remove("active");
	        }
	    });

	});
  
</script>
