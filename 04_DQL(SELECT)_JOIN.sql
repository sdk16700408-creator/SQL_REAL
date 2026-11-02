SELECT
       PATIENT_NAME
     , DOCTOR_ID
  FROM 
       PATIENT;

SELECT 
       DEPT_ID
     , DEPT_NAME
  FROM 
       DEPT;
-- JOIN => 두 개 이상의 테이블을 연결하여 하나으 ㅣ결과로 조회하는 것

-- 환자이름, 진료과명 조회 --> 오라클 전용 구문
SELECT
       PATIENT_NAME
     , PATIENT.DEPT_ID
     , DEPT.DEPT_ID
     , DEPT_NAME
  FROM 
       PATIENT 
     , DEPT
 WHERE
       PATIENT.DEPT_ID = DEPT.DEPT_ID;      --7개 커트라인 --10개 넘어가면 오~~ --20개 넘어가면 와우
 -------------------------------------------------------------------------------------
SELECT 
       DEPT_ID
     , DEPT_NAME
  FROM    
       DEPT;
-->> ANSI 표준 구문
SELECT
       PATIENT_NAME
     , DEPT_NAME
  FROM 
       PATIENT
  JOIN
       DEPT ON (PATIENT.DEPT_ID = DEPT.DEPT_ID);

SELECT 
       PATIENT_NAME
     , DEPT_NAME
  FROM 
       PATIENT
  JOIN 
       DEPT USING(DEPT_ID);
--NATURAL JOIN : 이름이 같은 컬럼을 자동으로 찾아서 조인(실무에서는 잘 안함)
SELECT  
       PATIENT_NAME
     , DEPT_NAME
  FROM 
       PATIENT
NATURAL JOIN DEPT;      









-------------------------
--환자명을 조회, 병동명을 조회

SELECT 
       PATIENT_NAME
     , WARD_NAME
  FROM
       PATIENT P
  JOIN
       WARD W ON (P.WARD_ID = W.WARD_ID);
-- 환자 이름, 진료과명, 병동명 조회
--PATIENT_NAME     ->PATIENT 
       --DEPT_NAME -> DEPT
       --WARD_NAME -> WARD
SELECT
       PATIENT_NAME 
     , DEPT_NAME
     , WARD_NAME
  FROM
       PATIENT P
  JOIN 
       DEPT d USING (DEPT_ID)
  JOIN 
       WARD W USING (WARD_ID);
 










-- 환자 이름, 담당의 이름 조회
SELECT
       PATIENT_NAME
     , DOCTOR_NAME
  FROM
       PATIENT p
     , DOCTOR d
 WHERE
       p.DOCTOR_ID = d.DOCTOR_ID;

-- 환자명, 진료과명 조회 -> IF(외과계 환자들만 조회)

SELECT 
       PATIENT_NAME
     , DEPT_NAME
  FROM  
       PATIENT P
     , DEPT D
 WHERE
       P.DEPT_ID = D.DEPT_ID
   AND
       DEPT_TYPE = '외과계' ;
-- 내부조인(INNER JOIN), 동등조인(EQUAL JOIN)
------------------------------------------------------
--외부조인(OUTER JOIN)
/*
 * LEFT OUTER JOIN
 * RIGHT OUTER JOIN
 * FULL OUTER JOIN
 */

-- 환자와 담당의 이름을 출력하고 싶은데 모든 환자를 조회
SELECT
       PATIENT_NAME
     , DOCTOR_NAME
  FROM    
       PATIENT 
  LEFT -- 한줄로 봤을 때 왼쪽에 일치하지 않은것도 싹다 조회
  JOIN
       DOCTOR USING(DOCTOR_ID);      
SELECT 
       PATIENT_NAME
     , DOCTOR_NAME
  FROM 
       PATIENT
 RIGHT
  JOIN
       DOCTOR USING(DOCTOR_ID)
 ORDER  
    BY   
       DOCTOR_ID 

SELECT  
       PATIENT_NAME
     , DOCTOR_NAME
  FROM 
       PATIENT
  FULL JOIN DOCTOR USING (DOCTOR_ID);
    
SELECT 
       NVL(PATIENT_NAME,'환자 미배정')
     , NVL(DOCTOR_NAME,'담당의 미배정')
  FROM      
        PATIENT
  FULL JOIN DOCTOR USING(DOCTOR_ID)
ORDER 
    BY 
        PATIENT_NAME ASC;
--오라클 구문에선 맨아래 동등비교하는 부분에서 (+) 을 붙이는쪽으로 조인이 일어나고 FULL 조인은 안된다
 -- 중복되지 않기위해서 정수르 쓰거나 난수를 써서 식별자를 만듬
-- 의사 이름, 소속진료과명 조회
SELECT
       DOCTOR_NAME
     , DEPT_NAME
  FROM  
       DOCTOR
  LEFT
  JOIN 
       DEPT USING(DEPT_ID);
-- 요구사항 => 진료명에 해당하는환자수 조회
SELECT 
       DEPT_ID
     , COUNT(*)
  FROM 
       PATIENT
  JOIN
       DEPT USING(DEPT_ID)
 GROUP
    BY   
       DEPT_ID;
--의사명을 조회하는데 과장만 조회
SELECT
       DOCTOR_NAME
  FROM   
       DOCTOR;
  JOIN
       POSITION USING(POSITION_ID)
 WHERE 
       POSITION_NAME = '과장'

SELECT COUNT(*
  FROM PATIENT
 CROSS
  JOIN DEPT;
