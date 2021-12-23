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


-- a가 맨앞 맨뒤에 있는 값만 가져오기
SELECT 
    *
FROM 
    child
WHERE 
    name LIKE 'a%' OR name LIKE '%a';


-- _id 가 100에서 200사이인 값만 가져오기
SELECT 
    *
FROM 
    child
WHERE 
    _id BETWEEN 100 AND 200;


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
    child
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

-- 오름차순 asc
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
-- WHERE 
--     _id BETWEEN 100 AND 200
ORDER BY age ASC
LIMIT 100; 


-- 끝을 자릅니다. LIMIT문 시작과 끝을 쓸 경우
SELECT 
    *
FROM 
    child
-- WHERE 
--     _id BETWEEN 100 AND 200
ORDER BY age ASC
LIMIT 100,200; 


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
-- 90세 이하의 parent가 
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