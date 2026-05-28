<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h3 class="erp-insert-title">프로젝트 추가</h3>

<div class="erp-insert-container">
<form action="/project/insert" method="post" class="erp-form">
    <p><span>코드 :</span> <input type="text" name="projectCode" id="projectCode" class="erp-input"></p>
    <p class="erp-check" id="checkCode"></p>

        <p><span>프로젝트명 :</span> <input type="text" name="projectName" id="projectName" class="erp-input"></p>
    <p class="erp-check" id="checkName"></p>


    <p><span>타입 :</span> <input type="text" name="projectType" id="projectType" class="erp-input"></p>

    <p><span>진행상태 :</span>
       <select name="status" id="status" class="erp-select">
            <option value="계획중">계획중</option>
            <option value="진행중">진행중</option>
            <option value="완료">완료</option>
        </select>
    </p>

    <p><span>시작일 :</span> <input type="date" name="startDate" id="startDate" class="erp-date"></p>
    <p><span>종료일 :</span> <input type="date" name="endDate" id="endDate" class="erp-date"></p>
    <p class="erp-check" id="checkDate"></p>

    <p><span>내용 :</span> <textarea name="description" id="description" placeholder="선택 입력 사항입니다." class="erp-textarea"></textarea></p>

      <div class="erp-btn-group">
        <button type="submit" id="projectInsert" class="erp-btn" disabled>추가</button>
        <button type="reset" id="reset-btn" class="erp-btn secret-btn" style="padding:0;">초기화</button>
        <button type="button" id="listPage" class="erp-btn close-modal">닫기</button>
       </div>
</form>
</div>

<script>
let checkCode = true;
let checkName = true;
let checkDate = true;

function checkAll() {
    $("#projectInsert").prop("disabled", checkCode || checkName || checkDate);
}


$("#projectCode").keyup(function() {
    const projectCode = $(this).val().trim();
    if(!projectCode){
        $("#checkCode").text("필수 입력 값입니다.").css("color","black");
        checkCode = true;
        checkAll();
        return;
    }
    $.ajax({
        url: "/project/checkCode",
        type: "get",
        data: { projectCode },
        success: function(result) {
            if(result === "fail"){
                $("#checkCode").text("중복된 코드입니다.").css("color","red");
                checkCode = true;
            } else {
                $("#checkCode").text("사용 가능한 코드입니다.").css("color","green");
                checkCode = false;
            }
            checkAll();
        }
    });
});

$("#projectName").keyup(function() {
    const projectName = $(this).val().trim();
    if(!projectName){
        $("#checkName").text("필수 입력 값입니다.").css("color","black");
        checkName = true;
    } else {
        $("#checkName").text("");
        checkName = false;
    }
    checkAll();
});

$(document).ready(function() {
    const todayStr = new Date().toISOString().split('T')[0];
    $("#startDate, #endDate").attr("min", todayStr);

    $("#startDate, #endDate").change(function() {
        const start = $("#startDate").val();
        const end = $("#endDate").val();

        if(!start){
            checkDate = true; $("#checkDate").text("");
        } else if(start < todayStr){
            $("#checkDate").text("금일 기준 이후로 입력해주세요.").css("color", "red");
            checkDate = true;
        } else if(!end){
            checkDate = true; $("#checkDate").text("");
        } else if(start >= end){
            $("#checkDate").text("종료일은 시작일 이후로 지정해주세요.").css("color","red");
            checkDate = true;
        } else {
            $("#checkDate").text("");
            checkDate = false;
        }
        checkAll();
    });
});

$("#reset-btn").click(()=>{
	$(".erp-check").text("");
})
</script>
