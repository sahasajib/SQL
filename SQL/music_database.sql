CREATE DATABASE music_database;
USE music_database;

SELECT * FROM album;

--  senior most employee based on job title 
SELECT * FROM employee;

-- which countries have most invoices
SELECT COUNT(*) as c, billing_country
FROM invoice
group by billing_country
ORDER BY c desc;

-- top 3 values of total invoice
SELECT total FROM invoice
ORDER BY total desc
LIMIT 3;

-- best customer for billing city sell music
SELECT SUM(total) as invoice_total, billing_city
FROM invoice
GROUP BY billing_city 
ORDER BY invoice_total desc;

-- best customer 
SELECT * FROM customer;
SELECT cus.customer_id, cus.first_name, cus.last_name, SUM(invo.total) as total
FROM customer cus
JOIN invoice invo
ON cus.customer_id = invo.customer_id
GROUP BY cus.customer_id
ORDER BY total DESC
LIMIT 1; 


-- rock music listener email, first name,last name,genre and return the list with email starting with a
SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoiceline ON invoice.invoice_id = invoiceline.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
    JOIN genre ON track.genre_id = genre.genre_id
    WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

-- total rock count
SELECT * FROM track;
SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) -- as number_of_songs
FROM track
JOIN album ON album.album_id  = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;
-- lenth for track 
SELECT name, milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
    FROM track
)
ORDER BY milliseconds DESC;

SELECT name, milliseconds
FROM track

-- 
-- SELECT cus.customer_id, cus.first_name, cus.last_name, invo.total
-- SUM(invo.total) OVER 
-- (Partition by cus.customer_id Order by 
-- cus.customer_id) as total
-- FROM customer cus
-- JOIN invoice invo
-- ON cus.customer_id = invo.customer_id
-- GROUP BY cus.customer_id
-- ORDER BY total desc