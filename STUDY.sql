CREATE TABLE parent (
  _id INT AUTO_INCREMENT, 
  name VARCHAR(32) NOT NULL, 
  age INT, 
  status INT,
  PRIMARY KEY(_id)
) ENGINE = INNODB default character set utf8 collate utf8_general_ci;

CREATE TABLE child (
  _id INT AUTO_INCREMENT, 
  name VARCHAR(32) NOT NULL, 
  parent_id INT, 
  age INT, 
  status INT,
  PRIMARY KEY(_id)
) ENGINE = INNODB default character set utf8 collate utf8_general_ci;

TRUNCATE TABLE child;

-- count()함수의 사용
SELECT 
    COUNT(*)
FROM 
    parent;

SELECT 
    COUNT(_id)
FROM 
    child;


-- IN과 NOT IN의 사용
SELECT 
    *
FROM 
    parent
WHERE 
    _id IN (1,2,3,4);

SELECT 
    *
FROM 
    parent
WHERE 
    _id IN (SELECT _id FROM parent WHERE _id < 5);


SELECT 
    *
FROM 
    parent
WHERE 
    _id NOT IN (1,2,3,4);

SELECT 
    *
FROM 
    parent
WHERE 
    _id NOT IN (SELECT _id FROM parent WHERE _id < 5);

-- LIKE의 사용 
SELECT 
    *
FROM 
    child
WHERE 
    name LIKE "a%";


SELECT 
    *
FROM 
    child
WHERE 
    name LIKE "%a";

SELECT 
    *
FROM 
    child
WHERE 
    name LIKE "%ab%";

SELECT 
    *
FROM 
    child
WHERE 
    name LIKE "_a%";

SELECT 
    *
FROM 
    child
WHERE 
    name LIKE "__a%";

SELECT 
    *
FROM 
    child
WHERE 
    name LIKE "%a___";


-- a가 맨앞, 맨뒤에 있는 값만 가져오기
SELECT 
    *
FROM 
    child
WHERE 
    name LIKE 'a%' AND name LIKE '%a';


-- a가 첫자리에 있거나, 끝자리에 있는 값만 가져오기
SELECT 
    *
FROM 
    child
WHERE 
    name LIKE 'a%' OR name LIKE '%a';


-- _id 가 100부터 200개(300까지)의 값만 가져오기
SELECT 
    *
FROM 
    child
WHERE 
    _id BETWEEN 10 AND 50;


-- 컬럼의 alias
SELECT 
    _id as primarykey,
    name as child_name
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200;


-- 테이블의 alias
SELECT 
    main._id,
    main.name
FROM 
    child as main
WHERE 
    _id BETWEEN 100 AND 200;

-- 오름차순 desc
SELECT 
    *
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200
ORDER BY age DESC;


-- 내림차순 asc
SELECT 
    *
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200
ORDER BY age ASC;


-- 끝을 자릅니다. LIMIT문 끝만 쓸 경우
SELECT 
    *
FROM 
    child
ORDER BY _id ASC
LIMIT 10; 


-- 끝을 자릅니다. LIMIT문 시작과 끝을 쓸 경우
SELECT 
    *
FROM 
    child
ORDER BY _id ASC
LIMIT 10, 20; 


-- 부모님이 없는 자식의 개수를 찾으세요
SELECT 
    COUNT(*)
FROM 
    child
WHERE 
    parent_id NOT IN (SELECT _id FROM parent);

-- 자식이 없는 부모의 개수를 찾으세요
SELECT 
    COUNT(*)
FROM 
    parent
WHERE 
    _id NOT IN (
        SELECT 
            parent_id 
        FROM 
            child
    )
;

-- 사람의 나이가 90세가 끝이라고 생각 했을 때 부모님이 살아계신 자식의 수는 몇개일까요
SELECT 
    COUNT(*)
FROM 
    child
WHERE 
    parent_id IN (
        SELECT 
            _id 
        FROM 
            parent 
    ) 
    AND child.age <= 90       
;


-- 1. 부모가 있는 자식 구하기
-- 2. 자식 나이 90세 이하
-- 3. 부모 나이 90세 이하
SELECT 
    COUNT(*)
FROM 
    child
WHERE 
    parent_id IN (
        SELECT 
            _id 
        FROM 
            parent
        WHERE 
            parent.age <= 90
    )
    AND child.age <= 90       
;


-- -- 2. 자식 나이 90세 이하
-- SELECT 
--     age
-- FROM 
--     child
-- WHERE 
--     age <= 90;

-- -- 3. 부모 나이 90세 이하
-- SELECT 
--     age
-- FROM 
--     parent
-- WHERE 
--     age <= 90;

-- 부모가 있는 자식 중에 나이가 어린 순으로 100명을 구하시오
SELECT 
    *
FROM 
    STUDY.child
WHERE 
    parent_id IN (
        SELECT 
            _id 
        FROM 
            parent 
    ) 
ORDER BY 
    child.age ASC 
LIMIT 100
;


-- 자식이 있는 부모 중에 나이가 많은 순으로 10명을 구하시오
SELECT 
    *
FROM 
    STUDY.parent
WHERE 
    _id IN (
        SELECT 
            parent_id 
        FROM 
            STUDY.child 
    ) 
ORDER BY  
    parent.age DESC 
LIMIT 10
;


--자식 이름이 a로 시작하는 부모 10명을 나이가 많은 순으로 구하시오
SELECT 
    *
FROM 
    STUDY.parent
WHERE 
    _id IN (
        SELECT 
            parent_id 
        FROM 
            STUDY.child
        WHERE
            child.name LIKE 'a%'
    ) 
ORDER BY  
    parent.age DESC 
LIMIT 10
;

-- 1대 N의 관계 : 부모1 -> 자식N 관계

-- 1대 1의 관계 : 남편1 <-> 부인1 관계 
-- 양쪽 모두 parent_id / child_id를 NOT NULL로 만듬??

-- N대 N의 관계 : 학원N <-> 원생N 관계
-- 

-- AVG() 함수 평균 값을 구한다
SELECT 
    AVG(age)
FROM
    STUDY.child
WHERE 
    _id BETWEEN 100 AND 200
;

-- max(n) 최대 값을 가져옵니다. 
SELECT 
    MAX(age)
FROM
    STUDY.child
WHERE 
    _id BETWEEN 100 AND 200
;

-- min(n) 최대 값을 가져옵니다. 
SELECT 
    MIN(age)
FROM
    STUDY.child
WHERE 
    _id BETWEEN 100 AND 200
;

-- SUM() 모든 값의 합을 가져옵니다. 
SELECT 
    SUM(age)
FROM
    STUDY.child
WHERE 
    _id BETWEEN 100 AND 200
;

--ucase() 대문자로 변환합니다. 
SELECT 
    UCASE(name)
FROM
    STUDY.child
WHERE 
    _id BETWEEN 100 AND 200
;

--lcase() 소문자로 변환합니다. 
SELECT 
    LCASE(name)
FROM
    STUDY.child
WHERE 
    _id BETWEEN 100 AND 200
;

-- left(col,n) 왼쪽부터 몇쨰까지의 텍스트를 반환합니다. 
SELECT 
    LEFT(name,2)
FROM
    STUDY.child
WHERE 
    _id BETWEEN 100 AND 200
;

-- mid(col,3,2) 왼쪽부터 몇쨰까지의 텍스트를 반환합니다. 
SELECT 
    MID(name,3,2)
FROM
    STUDY.child
WHERE 
    _id BETWEEN 100 AND 200
;

-- LENGTH(col) 왼쪽부터 몇쨰까지의 텍스트를 반환합니다. 
SELECT 
    LENGTH(name)
FROM
    STUDY.child
WHERE 
    _id BETWEEN 100 AND 200
;

-- NOW() 현재의 시간을 반환합니다. 
SELECT 
    NOW()
;

UPDATE 
    child
SET 
    nowdate = NOW()
;


--from 의 테이블 대신!
-- from의 테이블로 쓰일 경우, alias는 필수입니다. 

SELECT
    base.*
FROM    
    (select
        _id,
        name,
        age
    FROM 
        child
    WHERE 
        _id > 100 ) as base
WHERE 
    base.age > 50;

-- 컬럼의 역할도
-- 컬럼 대신으로 사용합니다. 내부 비교연산을 위해 alias는 필수

SELECT 
    child.age,
    (SELECT 
        child.age 
    FROM 
        parent 
    WHERE 
        _id = child._id = child.parent_id 
    LIMIT 1
    )
FROM 
    child as child
LIMIT
    100;

-- 부모님이 없는 자식의 이름을 대문자로 찾으세요.
SELECT 
    UCASE(child.name)
FROM 
    STUDY.child
WHERE 
    child.name NOT IN (
        SELECT 
            parent.name
        FROM 
            STUDY.parent
    )
;

-- 사람의 나이가 90세가 끝이라고 생각했을 때 
-- 자식이 살아있고 본인도 살아있는 부모의 최대나이는 몇살인가요?
    
SELECT 
    MAX(parent.age)
FROM 
    STUDY.parent
WHERE 
    parent._id IN (
        SELECT 
            child.parent_id
        FROM 
            STUDY.child
        WHERE 
            child.age <= 90
    )
    AND parent.age <= 90
;


-- 자식이 있는 부모 중에 이름이 2~3번째에 ab가 들어가는 
-- 나이가 많은 순으로 10명을 구하시오
SELECT 
    parent.name
FROM 
    STUDY.parent
WHERE 
    parent._id IN (
        SELECT 
            child.parent_id
        FROM 
            STUDY.child
    )
    AND parent.name LIKE '_ab%'
ORDER BY  
    parent.age DESC 
LIMIT 10
;

-- 자식보다 어린 부모의 개수를 구하시오.
-- 그리고 증명하는 쿼리를 작성하세요.

-- 1. 자식이 있는 부모 
-- 2. 자식 나이를 SELECT (서브쿼리) 
-- 3. 1~2를 테이블로(서브쿼리)
-- 4. 나이 비교 
SELECT 
    age_table.*
FROM
(
    SELECT 
        parent._id,
        parent.name,
        parent.age,
        (select MAX(age) from child where parent_id = parent._id ) as child_age 
    FROM 
        parent as parent
    WHERE 
        parent._id IN (
            SELECT 
                child.parent_id
            FROM 
                child
        )
    ) as age_table
WHERE 
    age_table.age < age_table.child_age;

SELECT 
    parent._id
FROM 
    parent
WHERE 
    parent._id IN (
        SELECT 
            child.parent_id
        FROM 
            child
    )
;

TRUNCATE TABLE parent;
TRUNCATE TABLE child;


-- DATABASE 3~4일차 퀴즈 복습 --

SELECT 
    COUNT(*)
FROM 
    child
WHERE 
    child.parent_id NOT IN (
        SELECT  
            parent._id
        FROM 
            parent 
    )
;

SELECT 
    COUNT(*)
FROM 
    parent
WHERE 
    parent._id NOT IN (
        SELECT  
            child.parent_id
        FROM 
            child 
    )
;

SELECT 
    count(*)
FROM 
    child
WHERE 
    child.parent_id IN (
        SELECT 
            parent._id
        FROM 
            parent
        WHERE 
            parent.age <= 90
    )
    AND child.age <= 90
;

SELECT 
    COUNT(*)
FROM 
    parent
WHERE 
    parent._id IN (
        SELECT 
            child._id
        FROM 
            child
        WHERE 
            child.age <= 90
    )
    AND parent.age <= 90
;

SELECT 
    *
FROM 
    child
WHERE 
    child.parent_id IN (
        SELECT 
            parent._id
        FROM 
            parent            
    )
ORDER BY age ASC 
LIMIT 100
;

SELECT 
    *
FROM 
    parent
WHERE 
    parent._id IN (
        SELECT 
            child.parent_id
        FROM 
            child
    )
ORDER BY parent.age DESC 
LIMIT 10
;

SELECT
    *
FROM 
    child
WHERE 
    child.parent_id IN (
        SELECT 
            parent._id
        FROM 
            parent
        WHERE 
            parent.name LIKE '%a%'
    )
ORDER BY child.age DESC 
LIMIT 10
;

SELECT 
    *
FROM 
    parent
WHERE 
    parent._id IN (
        SELECT 
            child.parent_id
        FROM 
            child
        WHERE 
            child.name LIKE '%a%'
    )
ORDER BY parent.age DESC
LIMIT 10
;

SELECT 
    AVG(age)
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200;

SELECT 
    MAX(age)
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200;

SELECT 
    MIN(age)
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200;

SELECT 
    SUM(age)
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200
;

SELECT 
    UCASE(name)
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200
;

SELECT 
    LCASE(name)
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200
;