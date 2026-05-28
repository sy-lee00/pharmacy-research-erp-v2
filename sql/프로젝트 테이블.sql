
-- 사용자
CREATE TABLE user(
	user_id INT AUTO_INCREMENT PRIMARY KEY, -- 사용자 ID
	email VARCHAR(100) NOT NULL UNIQUE, -- 이메일 (로그인 ID)
	password VARCHAR(255) NOT NULL, -- 비밀번호 (암호화 저장)
	name VARCHAR(50) NOT NULL, -- 이름
	dept_id INT, -- department.dept_id
	grade_id INT, -- grade.grade_id
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 등록일
    manager_id INT    
);

CREATE TABLE grade(
	grade_id INT PRIMARY KEY AUTO_INCREMENT,
	grade_name VARCHAR(50) NOT NULL, -- 직급명
	role VARCHAR(20) NOT NULL DEFAULT 'ROLE_RESEARCHER' -- 사용자 역할 (MANAGER/RESEARCHER) >> DTO로 USERDETAILS
);

CREATE TABLE department(
	dept_id INT PRIMARY KEY AUTO_INCREMENT, -- 부서 고유 ID
	dept_name VARCHAR(100) NOT NULL UNIQUE -- 부서 이름
);

-- 프로젝트 : 프로젝트 목록 / 상세, 프로젝트 참여자 조회, 내 프로젝트 보기, 프로젝트 등록 시 참여자 추가, 프로젝트 상세 내 참여자 역할 구분, 책임자 필터 (캘린더에 추가)
CREATE TABLE project (
    project_id INT AUTO_INCREMENT PRIMARY KEY,       -- 프로젝트 고유 ID
    project_code VARCHAR(50) NOT NULL UNIQUE,        -- 프로젝트 코드 (예: PJT-2025-001)
    project_name VARCHAR(100) NOT NULL,              -- 프로젝트명
    project_type VARCHAR(50),                        -- 프로젝트 유형
    user_id INT,                                     -- 책임자 (user.user_id 참조 예정)
    start_date DATE NOT NULL,                        -- 시작일
    end_date DATE NOT NULL,                          -- 종료일
    status VARCHAR(20) DEFAULT '계획중',             -- 상태 (계획중, 진행중, 완료 등)
    description TEXT,							       -- 설명
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,   -- 생성일시
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP    -- 최종 수정일시
);
CREATE TABLE project_member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,        -- 프로젝트 참여 고유 ID
    project_id INT NOT NULL,                         -- 프로젝트 ID
    user_id INT NOT NULL,                            -- 참여자 ID
    role VARCHAR(50),                                -- 프로젝트 내 역할 (예: 연구책임자, 실험 담당 등)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP     -- 참여일
);

-- 실험 일정 (차라리 task를 없앰) 그냥 연구원별로 각 업무에 대한 것 관리 
CREATE TABLE schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,      -- 일정 ID
    title VARCHAR(100) NOT NULL,                     -- 일정 제목
    description TEXT,                                -- 상세 내용
    user_id INT NOT NULL,                            -- 작성자 ID (모든 직원 개인 관리)
    project_id INT,									 -- 프로젝트 ID (필수 x)
    start_datetime DATETIME NOT NULL,                -- 시작 일시
    end_datetime DATETIME NOT NULL,                  -- 종료 일시
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP    -- 등록일
);

-- 전체 시약 목록
CREATE TABLE chemical (
    chemical_id INT AUTO_INCREMENT PRIMARY KEY,      -- 시약 ID
    chemical_name VARCHAR(100) NOT NULL,                      -- 시약명
    cas_no VARCHAR(50),                              -- CAS 번호
    storage_unit VARCHAR(50),                        -- 보관 단위 (예: g, mL)
    storage_id INT NOT NULL,                         -- 보관소 ID
    stock_qty INT DEFAULT 0,                         -- 현재 재고 수량
    threshold_qty INT DEFAULT 5,                     -- 경고 기준 재고 수량
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP    -- 등록일
);
CREATE TABLE storage (
    storage_id INT AUTO_INCREMENT PRIMARY KEY,       -- 보관소 ID
    name VARCHAR(100) NOT NULL,                      -- 보관소 이름 (예: 실험실 냉장고1)
    location VARCHAR(200),                           -- (연구소)위치 -> lab 테이블 제거 간단하게 가는 게 나을거 같아서요! 스토리지 보관 위치까지만
    type VARCHAR(100),                               -- 보관 방식
    description TEXT                                 -- 기타 설명
);
CREATE TABLE project_chemical (
    project_chemical_id INT AUTO_INCREMENT PRIMARY KEY, -- 고유 ID
    project_id INT NOT NULL,                         -- 프로젝트 ID
    chemical_id INT NOT NULL,                        -- 시약 ID
    user_id INT, -- NOT NULL,                            -- 사용한 연구원 ID (USER)
    used_qty INT NOT NULL,                           -- 사용 수량
    used_at DATETIME DEFAULT CURRENT_TIMESTAMP       -- 사용 일시 (수량 변경 시점 기록)
);

-- 문서
CREATE TABLE project_document (
    document_id INT AUTO_INCREMENT PRIMARY KEY,      -- 문서 ID
    project_id INT NOT NULL,                         -- 관련 프로젝트 ID
    user_id INT NOT NULL,                         -- 업로드한 사용자 ID
    title VARCHAR(100) NOT NULL,
    description TEXT,
    file_name VARCHAR(255) NOT NULL,                 -- 파일명
    file_path VARCHAR(255) NOT NULL,                 -- 저장 경로
    version INT DEFAULT 1,                           -- 문서 버전
    uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP   -- 업로드 일시 (고정값)
);

-- 고객
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,      -- 고객 ID
    name VARCHAR(100) NOT NULL,                      -- 기관명 (혹은 담당자명)
    department VARCHAR(100),                         -- 부서명
    user_id VARCHAR(50),                             -- 담당자 (user_id)
    phone VARCHAR(50),                               -- 연락처
    email VARCHAR(100),                              -- 이메일
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP    -- 등록일
);
CREATE TABLE customer_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,           -- 이력 ID
    customer_id INT NOT NULL,                        -- 고객 ID
    project_id INT,                                  -- 관련 프로젝트 ID
    log_date DATETIME DEFAULT CURRENT_TIMESTAMP,     -- 이력 일시
    content TEXT                                     -- 연락 내용
);

-- 승인 요청 기록
CREATE TABLE approval (
    approval_id INT AUTO_INCREMENT PRIMARY KEY,      -- 승인 요청 ID
    project_id INT NOT NULL,                         -- 관련 프로젝트 ID
    requested_by INT NOT NULL,                       -- 요청자 ID (연구원 ID -> user_id)
    approval_type VARCHAR(50),                       -- 요청 유형 (문서, 예산, 시약 등)
    approval_content VARCHAR(50),                    -- 요청 내용 (추가, 삭제, 결제 등)
    target_id INT,                                   -- 대상 항목 ID (문서 ID 등)
    status VARCHAR(20) DEFAULT '대기',               -- 상태 (대기, 승인, 반려)
    comment TEXT,                                    -- 관리자 코멘트
    approved_by INT,                                 -- 승인자 ID (관리자 ID -> user_id)
    approved_at DATETIME                             -- 승인 일시
);
