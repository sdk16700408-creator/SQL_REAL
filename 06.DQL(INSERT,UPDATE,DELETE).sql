/*
 * SELECT => DATA QUERY LANGUAGE(DQL) 질의를 날리는 언어다
  
 * INSERT, UPDATE, DELETE =>Date Mainpulaiton Language (DML) 
 */

-- < INSERT >
--INSERT INTO 테이블명 VALUES(값,값,...);
--새로운 행을 추가하는 구문

-- 새로운 진료과 추가

INSERT INTO DEPT VALUES('D9', '안과', '기타');
SELECT * FROM DEPT;

--병동 추가

INSERT
  INTO 
       WARD
VALUES (
       '6'
     , '재활병동'
     , '일반'
     ,  6
         );
SELECT * FROM WARD;

INSERT INTO DOCTOR (DOCTOR_ID, DOCTOR_NAME, POSITION_ID, HIRE_DATE)
VALUES ('DR13', '홍길동', 'J4', SYSDATE);
SELECT * FROM DOCTOR;
DELETE FROM DOCTOR WHERE DOCTOR_ID = 'DR13';
--DELETE
/*
 * DELET FROM 테이블명 WHERE 조건; 실무에서는 거의 안쓴느 쿼리
 */
/* TRUNCATE -> 전체삭제(롤래(되돌리기)불가, 빠름)
 * DELETE   -> 전체삭제(롤백 가능)
 * 
 */

/*
 * UPDATE
 * 
 * UPDATE
 *        테이블명
 *    SET 
 *        컬럼명 = 바꿀값
 *  WHERE 
 *        조건; 
 * 
 */

SELECT * FROM DEPT;

UPDATE 
       DEPT
   SET
       DEPT_TYPE = '안과'
     , DEPT_NAME = '진짜좋은 안과'
 WHERE 
       DEPT_ID = 'D9';

