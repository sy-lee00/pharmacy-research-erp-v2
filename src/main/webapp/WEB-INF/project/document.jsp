<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div>
	<div class="tab-title">
	<h2>관련 문서</h2>
</div>
	
	<button class="erp-btn erp-btn-proj project-show-doc-add-modal">문서 추가</button>
	<table class="erp-table">
		<thead>
			<tr>
				<th>문서명</th>
				<th>작성자</th>
				<th>파일명</th>
				<th>내용</th>
				<th>버전</th>
				<th>업로드 일자</th>
				<th>다운로드</th>
				<th>승인여부</th>
			</tr>
		</thead>
		<tbody>
<c:forEach items="${docuView}" var="doc">
     <tr class="${doc.approvalStatus eq '대기' ? 'erp-doc-wait' : (doc.approvalStatus eq '반려' ? 'erp-doc-reject' : 'erp-doc-done')}">
        <td>${doc.docuTitle}</td>
        <td>${doc.name}</td>
        <td>${fn:split(doc.fileName, '_')[1]}</td>
        <td>${doc.docuDesc}</td>
        <td>${doc.version}</td>
        <td><fmt:formatDate value="${doc.uploadedAt}" pattern="yyyy년 MM월 dd일 HH:mm:ss" /></td>
        <td>
            <button class="btn btn-danger erp-btn-proj"
                    onclick="downloadDocument('${doc.fileName}')"
                    ${doc.approvalStatus eq '대기' or doc.approvalStatus eq '반려' ? 'disabled' : ''}>
                다운로드
            </button>
        </td>
        <td class="approval-status">${doc.approvalStatus}</td>
    </tr>
</c:forEach>
</tbody>
	</table>
</div>

<div class="erp-open-modal project-doc-add-modal">
	<div class="erp-modal-body">
		<form action="/document/insert" method="post" class="erp-form"
			enctype="multipart/form-data">
			<h2>문서 등록</h2>
			<input type="hidden" name="documentProjectId"
				value="${param.projectId}" />
			<p>
				작성자 <select name="documentUserId" required class="erp-select">
					<c:forEach items="${projectUserList}" var="user">
						<option value="${user.userUserId}">${user.name}</option>
					</c:forEach>
				</select>
			</p>
			<p>
				문서명 <input type="text" name="docuTitle" required class="erp-input"/>
			</p>
			<p>
				설명
				<textarea name="docuDesc" placeholder="설명을 입력해주세요" class="erp-textarea"></textarea>
			</p>
			<p>
				파일 <input type="file" name="file"
					accept=".doc,.docx,.xls,.xlsx,.ppt,.pptx,.pdf,.txt,.hwp" required class="erp-input doc-file"/>
			</p>
			<p>
				버전 <input type="number" name="version" value="1" class="erp-input"/>
			</p>
			<p id="docu-check"></p>
			<button type="submit" id="docu-insert-btn" class="erp-btn">등록</button>
			<button type="button" class="erp-btn project-close-modal">닫기</button>
		</form>
	</div>
</div>
<script>
$(".project-show-doc-add-modal").click(() => 
$(".project-doc-add-modal").css("display", "flex")
);

$(".project-close-modal").click(() => 
$(".project-doc-add-modal").hide()
);

function downloadDocument(fileName) {
    const link = document.createElement('a');
    link.href = '/document/download?fileName=' + encodeURIComponent(fileName);
    link.download = fileName.split('_')[1];
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}
</script>