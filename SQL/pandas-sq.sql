CREATE DATABASE panda;
USE panda; 
CREATE TABLE student(
	id 	INT PRIMARY KEY,
    name VARCHAR(50),
    age INT NOT NULL
);

INSERT INTO student VALUES(1, "SAJIB", 27);
INSERT 