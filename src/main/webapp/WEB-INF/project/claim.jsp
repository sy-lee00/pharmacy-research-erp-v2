<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags"%>

<div class="tab-title">
  <h2>클레임 리스트</h2>
</div>
<table class="erp-table">
  <thead>
    <tr>
      <th>No</th>
      <th>작성자</th>
      <th>클레임 내용</th>
      <th>담당 멤버</th>
      <sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
        <th>지시사항</th>
        <th>전달</th>
      </sec:authorize>
    </tr>
  </thead>
  <tbody>
    <sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
      <c:forEach items="${log}" var="log" varStatus="status">
        <tr>
          <td>${status.count}</td>
          <td>${log.name}</td>
          <td>${log.clDescription}</td>
          <td>
            <select class="erp-form-select member-select" name="memberId">
              <c:forEach
                items="${projectUserList}"
                var="list"
                varStatus="status"
              >
                <option value="${list.userUserId}">${list.name}</option>
              </c:forEach>
            </select>
          </td>
          <td><textarea name="content">${log.content}</textarea></td>
          <td>
            <button
              class="erp-btn sendBtn"
              data-log-id="${log.logId}"
              data-project-id="${log.projectId}"
            >
              발송
            </button>
          </td>
        </tr>
      </c:forEach>
    </sec:authorize>
    <sec:authorize access="hasRole('RESEARCHER')">
      <c:forEach items="${myLog}" var="log" varStatus="status">
        <tr>
          <td>${status.count}</td>
          <td>${log.name}</td>
          <td>${log.clDescription}</td>
          <td>${log.userName}</td>
        </tr>
      </c:forEach>
    </sec:authorize>
  </tbody>
</table>

<script>
  $(".sendBtn").click(function (e) {
    e.preventDefault();
    const tr = $(this).closest("tr");
    const projectId = $(this).data("project-id");
    const logId = $(this).data("log-id");
    const memberId = tr.find('select[name="memberId"]').val();
    const content = tr.find('textarea[name="content"]').val();

    $.ajax({
      type: "post",
      url: "/project/claimMessage",
      data: {
        projectId: projectId,
        logId: logId,
        memberId: memberId,
        content: content,
      },
      success: function (response) {
        alert("성공적으로 전달되었습니다.");
        location.reload();
      },
      error: function (xhr, status, error) {
        alert("전송 중 오류가 발생했습니다.");
      },
    });
  });
</script>
