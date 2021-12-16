
CREATE DATABASE semin;

DROP DATABASE semin;

CREATE DATABASE 
    STUDY default character set utf8 collate utf8_general_ci ;

use study ;

DROP DATABASE study ;

CREATE TABLE professor (
  _id INT AUTO_INCREMENT, 
  name VARCHAR(32)   NOT NULL, 
  belong VARCHAR(12)   DEFAULT   'FOO', 
  phone VARCHAR(12), 
  status INT,
  PRIMARY KEY(_id)
) ENGINE = INNODB default character set utf8 collate utf8_general_ci;

DROP table professor;

INSERT INTO professor
    (name,belong,phone,status)
VALUES
    ('이일원','VSCODE','01022223333',0),
    ('김민호','VSCODE','01033334444',0),
    ('정다희','VSCODE','01044445555',0),
    ('김재승','VSCODE','01066667777',0),
    ('박경환','VSCODE','01077778888',0),
    ('허연','VSCODE','01088889999',0);

SELECT * FROM 
    professor;

SELECT 
    name,belong,phone
FROM 
    professor
WHERE 
    phone='01022223333';

SELECT
    name
FROM 
    professor
WHERE 
    phone='01033334444';

INSERT INTO professor
    (name,belong,phone,status)
VALUES
    ('유신환','VSCODE','01011112222',0);

use study ;

DELETE FROM 
    professor;

SELECT * FROM 
    professor;

TRUNCATE TABLE professor;

CREATE DATABASE TRAINING default character set utf8 collate utf8_general_ci ;

use TRAINING ;

CREATE TABLE table1 (
  _id INT AUTO_INCREMENT, 
  name VARCHAR(32) NOT NULL, 
  PRIMARY KEY(_id)
) ENGINE = INNODB default character set utf8 collate utf8_general_ci;

INSERT INTO table1
    (_id, name)
VALUES
    (20090101,'루피'),
    (20090102,'조로'),
    (20090103,'상디'),
    (20090104,'버기'),
    (20090105,'프랑키'),
    (20090106,'나미'),
    (20090107,'쵸파'),
    (20090108,'에릭'),
    (20090109,'전진'),
    (20090110,'오공'),
    (20090111,'오천'),
    (20090112,'베지터'),
    (20090113,'부우'),
    (20090114,'크리링'),
    (20090115,'피콜로'),
    (20090116,'셀');

DROP TABLE table1;

use TRAINING1;

CREATE TABLE table2 (
  _id INT AUTO_INCREMENT, 
  name VARCHAR(32) NOT NULL, 
  belong VARCHAR(12) DEFAULT 'FOO', 
  phone VARCHAR(12), 
  status INT,
  PRIMARY KEY(_id)
) ENGINE = INNODB default character set utf8 collate utf8_general_ci;

DROP TABLE table2;

INSERT INTO table2
    (_id,name,belong,phone,status)
VALUES
    (1,'나미','IDE','01113432432',0),
    (2,'크리링','IDE','01123432432',2),
    (3,'루피','IDE','01133432432',0),
    (4,'쵸파','CSE','01143432432',0),
    (5,'에릭','ESE','01153432432',0),
    (6,'전진','IDE','01163432432',0),
    (7,'피콜로','CSE','01123435343',3),
    (8,'셀','ESE','01183432432',0),
    (9,'조로','CSE','01193432432',0),
    (10,'버기','ESE','01110432432',0),
    (11,'오공','CSE','01111432432',0),
    (12,'베지터','ESE','01112432432',0),
    (13,'상디','MSE','01113432432',1),
    (14,'프랑키','IME','01114432432',0),
    (15,'부우','IME','01115432432',1),
    (16,'오천','MSE','01116432432',0);

SELECT
    _id,name,belong,phone,status
FROM 
    table2
WHERE 
    phone= '01111432432';
    -- status > 1;

DELETE        
    _id
FROM 
    table2
WHERE 
    _id < 12;
