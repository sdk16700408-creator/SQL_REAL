/*
< DDL (Data Definition Language) > 슬랙에 있는거

데이터 정의 언어
객체(테이블, 뷰, 시퀀스, 프로시져, 트리거, 함수...)를
생성(CREATE), 변경(ALTER), 삭제(DROP)하는 구문
*/

-- CREATE TABLE

/*CREATE TABLE 테이블명 (
 *  컬럼명 자료형,
 *  컬럼명 자료형,
 *  ...
 * );
 * 
 * CHAR(1~2000) : 고정길이문자
 * NVARCHAR2(1~4000) : 1글자부터 4000글자까지 글자로 이해함? 아래 바차투는 바이트로? 거의 안씀 이게 더 구닥다리래용 옛날에 다국어를 따로넣기위해 만든 ㄷ이터타입이래용
 * TIMESTAMP
 * 
 * VARCHAR2(크기) : 문자 -> 가변길이문자 적게 들어오면 그만큼 적게만 쓱 여튼 -> 최대 4000BYTE
 * NUMBER        : 숫자(정수/실수) 오라클에선 넘버로 끝
 * DATE          : 날짜 -> 년월일시분초
 * CLOB          : 바차2로 감당이 안되는 대용량 문자 
 */
-- 진료기록 테이블 만들기 -> 환자가 진료를 받을 때마다 한행씩 쌓이는 테이블
/*
 * 제약 조건
 * 
 * - NOT NULL : NULL값을 허용하지 않음
 * - UNIQUE : 중복값을 허용하지 않음
 * - PRIMARY KEY : NOT NULL + UNIQUE 테이블은 무조건 한개의 PK만 가질 수 있음 PK
 * - CHECK : 지정한 조건에 맞는 값만 허용
 * - FOREIGN KEY : 다른 테이블의 컬럼값만 허용(참조 무결성) -> FK 왜래키
 * 
 * 제역조건은 x => 기본값 설정
 * [제약조건 명시 방법]
 * 컬럼명 자료형 제약조건 -> 컬럼 레벨
 */
CREATE TABLE TREATMENT(
   RECORD_ID NUMBER, 
   PATIENT_ID CHAR(3) NOT NULL, --제약 조건
   DOCTOR_ID CHAR(4) NOT NULL REFERENCES DOCTOR (DOCTOR_ID),
   TREAT_DATE DATE DEFAULT SYSDATE,
   PRESCRIPTION VARCHAR2(200),
   COST NUMBER,
   PRIMARY KEY (RECORD_ID),
   FOREIGN KEY (PATIENT_ID) REFERENCES PATIENT (PATIENT_ID),  -- 참조 REFERENCES
   CONSTRAINT TREAT_COST_CK CHECK (COST >= 50000)
);

COMMENT ON COLUMN TREATMENT.RECORD_ID IS '기록번호';
SELECT * FROM TREATMENT;
DROP TABLE TREATMENT;
SELECT *
  FROM USER_TAB_COLUMNS
 WHERE TABLE_NAME = 'TREATMENT';

INSERT INTO TREATMENT
VALUES(3, 'P01', 'DR10', SYSDATE, '위소매절제술', 50000);

SELECT CONSTSRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME = 'TREATMENT';

/*
DELETE 탈퇴 요청 처리

FK => 삭제 옵션
-옵션없음(기본) : 자식이 있으면 부모 삭제 불가
- ON DELETE CASCADE : 부모 삭제 시 자식도 함께 삭제
- ON DELETE SET NULL : 부모 삭제 시 자식의 FK를 NULL로
*/
/*
 *========= 
 *ALTER
 * 
 * 
 * -컬럼을 추가
 */
ALTER TABLE TREATMENT ADD (NEXT_VISIT DATE);
-- 컬럼 수정
ALTER TABLE TREATMENT MODIFY (PRESCRIPTION VARCHAR2(1000));
--안되는 경우
ALTER TABLE TREATMENT MODIFY (PRESCRIPTION NUMBER);

--컬럼명 변경
ALTER TABLE TREATMENT RENAME COLUMN NEXT_VISIT TO VISIT_DATE;

--제약 조건 추가
ALTER TABLE TREATMENT ADD CONSTRAINT VISIT_UQ UNIQUE(VISIT_DATE);

--NOT NULL
ALTER TABLE TREATMENT MODIFY (VISIT_DATE NOT NULL);

--제약 조건 삭제
ALTER TABLE TREATMENT DROP CONSTRAINT VISIT_UQ;
SELECT * FROM TREATMENT;

-----------------------------------------------------
--DROP TABLE
/*
 * DROP TABLE 테이블명;
 * DROP TABLE 테이블명 CASCADE CONSTRAINTS; -> 이테이블을 참조하는 FK까지 같이 제거
 * DROP TABLE 테이블명 PURGE; 휴지통에 안넣고 바로 지움
 * 
 * FLASHBACK TABLE TREATMENT TO BEFORE DROP; 휴지통에서 되살리기
 * PURGE RECYCLEBIN; 휴지통 지우기
 * 
 * 
 * 
*/










