<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Board</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
      crossorigin="anonymous"></script>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <link rel="stylesheet" href="../../resource/css/boot.css" />
    <link rel="stylesheet" href="../../resource/css/layout.css" />
    <link rel="stylesheet" href="../../resource/css/erp.css" />
    <style>
      .imgbar {
        width: 80%;
        background-image: url(../../resource/static/board.png);
      }
    </style>
  </head>
  <body>
    <jsp:include page="../header.jsp"></jsp:include>
    <jsp:include page="../side.jsp"></jsp:include>
    
    <div class="customer-log">
      <div class="imgbar">
        <h1><a href="/customer/board" class="a-title">게시판 리스트</a></h1>
        <form action="/customer/board" method="get" class="form-container">
          <select name="select" id="select" class="form-select w-auto">
            <option value="title">제목</option>
            <option value="uploadedBy">작성자</option>
          </select>
          <span class="search-flex-container">
            <input
              id="inputTitle"
              type="text"
              class="form-control"
              name="keyword"
              value="${param.keyword}"
              placeholder="검색어를 입력하세요."
            />
            <i class="bi bi-eraser-fill clear-icon"></i>
          </span>
          <div class="button-group">
            <button type="submit" class="btn btn-danger search-btn">
              검색
            </button>
            <button type="button" id="modal-open" class="btn btn-primary">
              등록
            </button>
        	<sec:authorize access="hasAnyRole('RESEARCHER','MANAGER')">
			<a href="/" class="btn btn-dark"><i class="bi bi-house-door-fill"></i></a>
			</sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
			<a href="/statistics" class="btn btn-dark"><i class="bi bi-house-door-fill"></i></a>
			</sec:authorize>
          </div>
        </form>
      </div>

      <table class="erp-table list-table board-table">
        <thead>
          <tr>
            <th>번호</th>
            <th>유형</th>
            <th>이미지</th>
            <th>제목</th>
            <th>내용</th>
            <th>작성자</th>
            <th>최종수정시간</th>
            <th>삭제</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${list}" var="board">
            <tr>
              <td>${board.boardNo}</td>
              <td>${board.type}</td>
              <td class="image-preview">
                <c:if test="${not empty board.url}">
                  <img
                    src="../../resource/upload/${board.url}"
					alt="게시판 이미지"
				  />
                  <!-- onerror="this.style.display='none'" -->
                </c:if>
              </td>
              <td>
               <a href="javascript:void(0);" 
              			 onclick="window.open('/customer/view?boardNo=${board.boardNo}', 
                                    'boardWindow', 
                                    'width=900,height=475,top=200,left=100,scrollbars=yes,resizable=yes');">
                ${board.title}</a
                >
              </td>
              <td>${board.content}</td>
              <td>${board.uploaderName}(${board.uploaderType})</td>
              <td>
                <fmt:formatDate
                  value="${board.updatedAt}"
                  pattern="yyyy-MM-dd HH:mm:ss"
                />
              </td>
              <td>
                <a
                  class="btn btn-outline-danger"
                  href="/customer/delete?boardNo=${board.boardNo}"
                  ><i class="bi bi-trash"></i
                ></a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <nav>
        <ul class="erp-pagination">
          <li class="page-item ${paging.prev ? '' : 'disabled'}">
            <a
              class="page-link"
              href="/customer/board?page=${paging.startPage - 1}&keyword=${param.keyword}&select=${param.select}"
              >이전</a
            >
          </li>

          <c:forEach
            begin="${paging.startPage}"
            end="${paging.endPage}"
            var="page"
          >
            <li class="page-item ${paging.page == page ? 'active' : ''}">
              <a
                class="page-link"
                href="/customer/board?page=${page}&keyword=${param.keyword}&select=${param.select}"
                >${page}</a
              >
            </li>
          </c:forEach>

          <li class="page-item ${paging.next ? '' : 'disabled'}">
            <a
              class="page-link"
              href="/customer/board?page=${paging.endPage + 1}&keyword=${param.keyword}&select=${param.select}"
              >다음</a
            >
          </li>
        </ul>
      </nav>
    </div>

    <div class="modal-back">
      <div class="write-modal">
        <button id="modal-close"><i class="bi bi-x"></i></button>

        <form action="/write" method="post" enctype="multipart/form-data">
          <div class="modal-body">
            <h3>게시물 작성하기</h3>
            <label class="form-label">유형</label>
            <select class="form-control" name="type" id="typeSelect">
              <option value="claim">클레임</option>
              <option value="notice">공지사항</option>
            </select>

            <label class="form-label">작성자</label>
            <select
              class="form-control"
              name="uploadedBy"
              id="uploadedBySelect"
            >
              <option value="" selected disabled>
                --- 이름을 선택해주세요 ---
              </option>
              <optgroup label="고객명" id="customerOptions">
                <c:forEach items="${customer}" var="cs">
                  <option value="${cs.customerId}">${cs.name}</option>
                </c:forEach>
              </optgroup>
              <optgroup
                label="관리자명"
                id="managerOptions"
                style="display: none"
              >
                <c:forEach items="${manager}" var="manager">
                  <option value="${manager.userId}">${manager.name}</option>
                </c:forEach>
              </optgroup>
            </select>

            <label class="form-label">제목</label>
            <input type="text" class="form-control" name="title" />
            <label class="form-label">내용</label>
            <textarea class="form-control" rows="3" name="content"></textarea>
            <label class="form-label">파일 첨부</label>
            <input
              class="form-control"
              name="file"
              type="file"
              accept="image/*"
            />
          </div>
          <button type="submit" class="btn btn-warning mt-2" style="width: 90px;">등록하기</button>
        </form>
      </div>
    </div>

    <script>
      $("#modal-open").click(() => {
        $(".modal-back").css("display", "flex");
      });

      $("#modal-close").click(() => {
        $(".modal-back").css("display", "none");
      });

      const searchInput = $('input[name="keyword"]');
      const clearIcon = $(".clear-icon");

      if (searchInput.val().length > 0) {
        clearIcon.show();
      }

      searchInput.on("input", function () {
        if ($(this).val().length > 0) {
          clearIcon.show();
        } else {
          clearIcon.hide();
        }
      });

      clearIcon.on("click", function () {
        searchInput.val("");
        $(this).hide();
        searchInput.focus();
      });

      $(document).ready(function () {
        const typeSelect = $("#typeSelect");
        const customerOptions = $("#customerOptions");
        const managerOptions = $("#managerOptions");

        typeSelect.on("change", function () {
          const selectedType = $(this).val();

          if (selectedType === "claim") {
            customerOptions.show();
            managerOptions.hide();
          } else if (selectedType === "notice") {
            customerOptions.hide();
            managerOptions.show();
          }
        });
      });
    </script>
  </body>
</html>
