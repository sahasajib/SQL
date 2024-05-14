CREATE DATABASE pandas;
uSE pandas;

CREATE TABLE customer(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	phone_num INT
);

INSERT INTO customer
(id, name, phone_num)
VALUES 
(1, "Donald", 7326784567),
(2, "Bill", 6573489999),
(3, "Modi", 4567895646);
INSERT INTO customers VALUES (1, "Donald", 7326784567);
SELECT * FROM customer;

DROP DATABASE pandas;
