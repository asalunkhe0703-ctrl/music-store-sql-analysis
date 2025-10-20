-- 1:who is the senior most employee based on job title?

select * from employee
ORDER BY levels
limit 1



-- 2.Which countries has the most invoices?

select COUNT(*) as A,billing_country
from invoice
group by billing_country
order by A desc



-- 3:what are the 3 values of total invoice?

SELECT total FROM invoice
order by total desc
lomit 3



-- 4:which city has the best customer?we would like to throw a promotional Music festival in the city we made the most money.
-- Write a query that returns one city that has the highest sum of invoice totals.Return both the city name
-- & sum of all invoice totals.

select SUM(total) as invoice_total,billing_city
from invoice
group by billing_city
order by invoice_total desc



-- 5: Who is the best customer? The customer who has spent the most money will be declared the best customer.
-- Write a query that returns the person who has spent the most money.

select customer.customer_id, cutomer.first_name, customer.last_name, SUM(invoice.total) as total
from customer
JOIN invoice ON customer.customer_id= invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
limit 1



-- 6.write a query to return the email,first name,last name and Genre of all Rock Music listners.
	-- Return your list ordered alphabetically by email starting with A.

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id= invoice.customer_id
JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id=genre.genre_id
	WHERE genre.name LIKE 'Rock'
	)
ORDER BY email;
	


-- 7:Let's invite the artists who have written the mock rock music in our dataset.Write a query that returns the artist name and total track count of the top 10 rock bonds

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) as number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC 
LIMIT 10;




-- 8:Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track.Oredr by the song length with the longest songs listed first.

SELECT name, milliseconds
FROM track 
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track)
ORDER BY milliseconds DESC;
