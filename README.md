# [제약회사 연구관리 ERP 시스템]  
>**연구 데이터의 무결성과 행정 효율성을 위한 웹 애플리케이션 개발 프로젝트**  
<img width="640" height="360" alt="메인페이지" src="https://github.com/user-attachments/assets/b47aeb10-f80b-4049-902b-1bb4ebf78262" />

---

## 개요
- **프로젝트 성격**: KH정보교육원 국비 팀 프로젝트(3인)
- **주요 역할**: 전산 시스템 개발 (시약 현황 관리 API 구축, 사용 등록 및 승인 워크플로우 구현)
- **작업 기간**: 2025.06 ~ 2025.07(5주)

---

## 기술 스택

### **Backend & Database**
- Framework: Spring Boot 3.5.4, Spring Security, MyBatis 3.0.3
- Language: Java 21
- DB/Tools: MySQL, Maven, GitHub

---

### **Frontend**
- Language: HTML5, CSS3, JavaScript (ES6)
- Library: jQuery, Bootstrap 5, JSTL
- View: JSP

---

## 핵심 구현 및 퍼블리싱 포인트
- **대용량 데이터 매핑 및 가독성 최적화**: 복잡한 시약 데이터 및 연구 관리 테이블 레이아웃을 설계하고, MyBatis를 통해 조회된 데이터를 화면단에 유기적으로 매핑하여 데이터 조회 편의성을 높였습니다.
- **비동기 통신을 통한 워크플로우 구현**: 시약 사용 승인 및 반려 절차 처리 시, 비동기(Ajax) 데이터 통신과 모달(Modal) UI를 결합하여 페이지 리로드 없이 안정적으로 상태 값을 변경하는 워크플로우를 구현했습니다.
- **MyBatis 동적 쿼리를 활용한 복합 검색**: 다중 조건 필터링 기능 구현 시, 서버단에서 파라미터 상태를 검증하고 MyBatis 동적 태그를 활용해 효율적으로 데이터를 필터링하여 시스템 운영 안정성을 확보했습니다.

---

## 트러블 슈팅
- **[현상]** 다중 조건 필터 검색 시, 특정 선택 조건이 비어있을 경우 SQL 구문 오류(Syntax Error) 또는 원치 않는 데이터가 조회되는 문제 발생.
- **[원인]** 사용자의 입력 데이터 유무에 따른 백엔드 예외 처리와 SQL 조건절의 유동적 제어 부족.
- **[해결]** MyBatis의 <where> 및 <if> 동적 쿼리 태그를 적용하여 조건 값이 존재하는 경우에만 SQL 문이 생성되도록 쿼리를 최적화하고 백엔드 파라미터 검증 로직을 추가하여 오류를 해결했습니다.
- **[배운점]** 실무 환경에서 발생할 수 있는 데이터 예외 변수를 예측하고, 이에 대응하는 유연한 데이터베이스 설계 및 쿼리 최적화의 중요성을 깨달았습니다.  

---

## 결과물
- **Live Demo**: [[링크 연결]](https://pharmacy-research-erp.onrender.com/)
- **Source Code**: [[GitHub 링크]](https://github.com/sy-lee00/pharmacy-research-erp.git)
