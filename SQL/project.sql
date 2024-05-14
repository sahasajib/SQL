CREATE DATABASE project;
USE project;

CREATE TABLE customer (
	id INT PRIMARY KEY,
    name VARCHAR(50),
    phone BIGINT NOT NULL
    );
INSERT INTO customer
(id, name, phone)
VALUES 
(1, "Donald", 7326784567),
(2, "Bill", 6573489999),
(3, "Modi", 4567895646);
INSERT INTO customer VALUES(1, "anil", 7548667411);
SELECT * FROM customer;
DROP TABLE customer;

CREATE TABLE orders(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    amount INT NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) references customer(id)
);
INSERT INTO orders VALUES(2, "anila", 950, 1);
INSERT INTO orders VALUES(3, "bibek", 120, 3);
SELECT * FROM orders;

