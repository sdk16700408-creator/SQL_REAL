/*
   < SUBQUERY >
*/
-- 전체 환자의 평균 키보다 키가 더 큰 환자들의 이름을 조회
SELECT AVG(HEIGHT_CM) FROM PATIENT; -- 159.3888888.....

SELECT 
       PATIENT_NAME
     , HEIGHT_CM  
  FROM
       PATIENT
 WHERE 
       HEIGHT_CM > (SELECT AVG(HEIGHT_CM) FROM PATIENT);
       
-- 배준혁 환자오 ㅏ같은 병동에 있는 환자들의 이름, 병동명
SELECT WARD_NAME FROM WARD 
  JOIN PATIENT USING(WARD_ID) WHERE PATIENT_NAME = '배준혁'

SELECT
       PATIENT_NAME
     , WARD_NAME
  FROM   
       PATIENT
  JOIN
       WARD USING(WARD_ID)
 WHERE
       WARD_NAME = (SELECT WARD_NAME FROM WARD)
  JOIN PATIENT USING(WARD_ID) WHERE PATIENT_NAME = '배준혁');


-- 허준이 담당하는 환자명 조회
SELECT DOCTOR_ID FROM DOCTOR WHERE DOCTRO_NAME = '허준';

SELECT  
       PATIENT_NAME
  FROM
       PATIENT
 WHERE   
       DOCTOR_ID = (SELECT 
                           DOCTOR_ID
                      FROM DOCTOR 
                     WHERE DOCTOR_NAME = '허준');

SELECT PATIENT_NAME
  FROM PATIENT
  JOIN DOCTOR USING(DOCTOR_ID) WHERE DOCTOR_NAME = '허준';

-- 단일행 서브쿼리
SELECT 
       PATIENT_NAME
  FROM
       PATIENT
 WHERE 
       DEPT_ID = (SELECT DEPT_ID 
                    FROM DEPT
                   WHERE DEPT_TYPE='외과계');
        

-- 다중행 서브쿼리
SELECT
       PATIENT_NAME
  FROM 
       PATIENT  
 WHERE 0
       DEPT_ID IN (SELECT DEPT_ID FROM DEPT WHERE DEPT_TYPE='외과계');  -- 포함이 되어있는가 IN
 
       
-- > ANY : 서브쿼리 결과 중 하나라도 크면(최소값보다 크면)
-- > ALL : 서브쿼리 결과 중 모두보다 크면(최대값보다 크면)

-- 다중열 서브쿼리
-- 진료과별로 가장 키가 큰 환자의 이름, 키 조회
SELECT MAX(HEIGHT_CM) FROM PATIENT GROUP BY DEPT_ID;

SELECT 
       PATIENT_NAME, HEIGHT_CM
  FROM  
       PATIENT
 WHERE 
       (DEPT_ID, HEIGHT_CM) IN(SELECT DEPT_ID, MAX(HEIGHT_CM) FROM PATIENT GROUP BY DEPT_ID);
     
------------------------------------------------------------
--서브 쿼리 먼저 시험해보고 메인 쿼리 써보자

-- 오라클 11버전 이하라면
-- 몸무게 TOP 5 환자조회

SELECT
       PATIENT_NAME
     , WEIGHT_KG
     , ROWNUM
  FROM 
       PATIENT
 WHERE
       ROWNUM <= 5
 ORDER
    BY
       WEIGHT_KG DESC;
--인라인뷰
SELECT    
       PATIENT_NAME
     , WEIGHT_KG
  FROM    
       (SELECT
               PATIENT_NAME
             , WEIGHT_KG
          FROM
               PATIENT
         ORDER
            BY
               WEIGHT_KG DESC)
  WHERE
        ROWNUM <= 5;
               
-- 12C 이상

SELECT  
       PATIENT_NAME
     , WEIGHT_KG
  FROM 
       PATIENT
 ORDER
    BY 
       WEIGHT_KG DESC 
 FETCH FIRST 5 ROWS ONLY;
SELECT     
       PATIENT_NAME
     , WEIGHT_KG
  FROM
       PATIENT
 ORDER
    BY
       WEIGHT_KG DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

---------------------------------------
--스칼라 서브쿼리 대전제는 값이 무조건 1하나의 컬럼만 실무에서는 자주쓴다 왜 귀찮아서/한쓸수 있으면 좋음 성능 나빠져서 근데 절대로 그렇지 않고 오히려 퍼포먼스 더 잘나올때도 있음
SELECT 
       PATIENT_NAME
     , (SELECT DOCTOR_NAME FROM DOCTOR WHERE DOCTOR_ID = P.DOCTOR_ID)
     , (SELECT WARD_NAME FROM WARD WHERE WARD_ID = P.WARD_ID)
     , (SELECT DEPT_NAME FROM DEPT WHERE DEPT_ID = P.DEPT_ID )
  FROM 
       PATIENT P;
