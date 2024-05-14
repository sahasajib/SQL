CREATE DATABASE xyz;
USE xyz;
CREATE TABLE student (
rollno INT PRIMARY KEY,
name VARCHAR(50),
marks INT NOT NULL,
grade VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO student
(rollno, name, marks, grade, city)
VALUES
(101, 'anil', 78, 'C', 'Pune'),
(102, 'bhumika', 93, 'A', 'Mumbai'),
(103, 'chetan', 85,'B', 'Mumbai'),
(104, 'purni',96, 'A', 'Delhi'),
(105, 'sajib', 82, 'A', 'Delhi');

SELECT name, marks FROM student;

SELECT * FROM student WHERE marks > 80 AND city="Mumbai";

SELECT * FROM student ORDER BY city ASC;

#AGG
SELECT MAX(marks)
FROM student;

SELECT MIN(marks)
FROM student;

SELECT AVG(marks)
FROM student;

SELECT COUNT(marks)
FROM student;

SELECT city, avg(marks)
FROM student
GROUP BY city
ORDER BY avg(marks);

SELECT grade, count(rollno)
FROM student
GROUP BY grade
ORDER BY grade;

SELECT city, count(rollno)
FROM student
GROUP BY city
HAVING MAX(marks) > 90;

SELECT city
FROM student
WHERE grade = "A"
GROUP BY city
HAVING MAX(marks) >= 93;

SET SQL_SAFE_UPDATES = 0;

UPDATE student
SET grade = "O"
WHERE grade = "A";


UPDATE student
SET marks = marks + 1;

CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
    customer VARCHAR(50),
    mode VARCHAR(50),
    city VARCHAR(50));
    
INSERT INTO customer 
(customer_id, customer, mode, city)
VALUES 
(101, "Olivia Barrentt", "netbanking", "Portland"),
(102, "Ethan Sinclair", "Credit Card", "Miami"),
(103, "Jon Sinclair", "Credit Card", "Seattle"),
(104, "Jonson Bolt", "Credit Card", "Seattle"),
(105, "Oliv Ray", "netbanking", "New Orleans"),
(106, "Rihanna Jack", "Debit Card", "Minneapolis"),
(107, "Eth Alair", "Debit Card", "Phoenix"),
(108, "Ola Bat", "netbanking", "Boston"),
(109, "Jack Sho", "netbanking", "Nashville"),
(110, "Ethan Sinlo", "Credit Card", "Boston");

SELECT * FROM customer;
SELECT mode, COUNT(customer)
FROM customer
GROUP BY mode;

ALTER TABLE customer
ADD COLUMN age INT;

ALTER TABLE customer
DROP COLUMN age;

TRUNCATE TABLE customer;

CREATE TABLE dept(
id INT PRIMARY KEY,
name VARCHAR(50)
);

CREATE TABLE teacher(
id INT PRIMARY KEY,
name VARCHAR(50),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES dept(id)
ON UPDATE CASCADE
ON DELETE CASCADE
);


CREATE TABLE students(
	student_id INT PRIMARY KEY,
    name VARCHAR(50)
);
INSERT INTO students(student_id, name)
VALUES
(101, "adam"),
(102, "bob"),
(103, "casey");
SELECT * FROM course;

CREATE TABLE course(
student_id INT PRIMARY KEY,
course VARCHAR(50)
);

INSERT INTO course(student_id, course)
VALUES
(102, "english"),
(105, "math"),
(103, "science"),
(107, "it");

SELECT * 
FROM students
INNER JOIN course
ON students.student_id = course.student_id;


SELECT *
FROM students
LEFT JOIN course
ON students.student_id = course.student_id
UNION
SELECT *
FROM students
RIGHT JOIN course
ON students.student_id = course.student_id;

SELECT *
FROM students
LEFT JOIN course
ON students.student_id = course.student_id
WHERE course.student_id IS NULL
UNION
SELECT *
FROM students
RIGHT JOIN course
ON students.student_id = course.student_id
WHERE students.student_id IS NULL;

CREATE TABLE employee(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id int);

INSERT INTO employee (id, name, manager_id)
VALUES
(101, "adam", 103),
(102, "bob", 104),
(103, "casey", NULL),
(104, "donald", 103);

SELECT * FROM employee;

SELECT a.name as manager_name, b.name
FROM employee as a
JOIN employee as b
ON a.id = b.manager_id;


CREATE TABLE class(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT );
INSERT INTO class (id, name, marks)
VALUES 
(101, "anil", 78),
(102, "bhumika", 96),
(103, "chetan", 85),
(104, "dhruv", 96),
(105, "emanuel", 92),
(106, "zed", 95),
(107, "farah", 82);

CREATE VIEW view1 AS
SELECT id, marks FROM class;

SELECT * FROM view1
WHERE marks > 90;

DROP VIEW view1;

SELECT * FROM class;
SELECT AVG(marks)
FROM class;

SELECT name , marks
FROM class
WHERE marks > 88.1667;

SELECT name , marks
FROM class
WHERE marks >
(SELECT AVG(marks)
FROM class);

TRUNCATE TABLE class;

SELECT id
FROM class
WHERE id % 2 = 0;

SELECT name , id
FROM class 
WHERE id IN (
	SELECT id
	FROM class
	WHERE id % 2 = 0);

CREATE TABLE student (
rollno INT PRIMARY KEY,
name VARCHAR(50),
marks INT NOT NULL,
grade VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO student
(rollno, name, marks, grade, city)
VALUES
(101, 'anil', 78, 'C', 'Pune'),
(102, 'bhumika', 93, 'A', 'Mumbai'),
(103, 'chetan', 85,'B', 'Mumbai'),
(104, 'purni',96, 'A', 'Delhi'),
(105, 'sajib', 82, 'A', 'Delhi');

SELECT * FROM student;

ALTER TABLE student
CHANGE name full_name VARCHAR(50);

DELETE FROM student
WHERE marks < 80;

ALTER TABLE student
DROP COLUMN grade;

SELECT MAX(marks)
FROM(
	SELECT * 
	FROM student
	WHERE city = "Delhi") AS temp;

SELECT MAX(marks)
FROM student
WHERE city = "Delhi";


CREATE VIEW view1 AS
SELECT rollno, name, marks FROM student;
DROP VIEW view1;
SELECT * FROM view1;