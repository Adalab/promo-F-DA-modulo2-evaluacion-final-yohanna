USE sakila;

-- Ejercicio 1

SELECT DISTINCT title
from film;

-- Ejercicio 2

SELECT title -- , rating
FROM film
WHERE rating = 'PG-13';

-- Ejercicio 3

SELECT title, description
FROM film
WHERE description LIKE '%amazing%';

-- Ejercicio 4

SELECT title -- , length
FROM film
WHERE length > 120;

-- Ejercicio 5

SELECT first_name, last_name
FROM actor;

-- Ejercicio 6

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%Gibson%';

-- Ejercicio 7

SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- Ejercicio 8

SELECT title, rating
FROM film
WHERE rating NOT IN ('R', 'PG-13');

-- Ejercicio 9 

SELECT rating, COUNT(*) AS cantidad
FROM film
GROUP BY rating;

-- Ejercicio 10 

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS cantd_alquileres_cli
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY cantd_alquileres_cli DESC;

-- Ejercicio 11

SELECT c.name AS categoria, COUNT(r.rental_id) AS cantd_alquileres_catg
FROM category c
LEFT JOIN film_category f ON c.category_id = f.category_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY cantd_alquileres_catg DESC;

-- Ejercicio 12

SELECT rating, AVG(length) AS promd_duracion
FROM film
GROUP BY rating;

-- Ejercicio 13

SELECT a.first_name, a.last_name
FROM actor a
INNER JOIN film_actor y ON a.actor_id = y.actor_id
INNER JOIN film f ON f.film_id = y.film_id
WHERE f.title = 'Indian Love';

-- Ejercicio 14 

SELECT title -- , description
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- Ejercicio 15

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id NOT IN (
SELECT DISTINCT actor_id 
FROM film_actor);

-- Ejercicio 16 

SELECT title -- , release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- Ejercicio 17

SELECT f.title -- , c.name
FROM film f
INNER JOIN film_category z ON f.film_id = z.film_id
INNER JOIN category c ON z.category_id = c.category_id
WHERE c.name = 'Family';

-- Ejercicio 18

SELECT a.first_name, a.last_name, COUNT(y.film_id) AS cantd_pelis
FROM actor a
INNER JOIN film_actor y ON a.actor_id = y.actor_id
GROUP BY a.actor_id
HAVING COUNT(y.film_id) > 10;

-- Ejercicio 19

SELECT title -- , rating, length
FROM film
WHERE rating = 'R' AND length > 120;

-- Ejercicio 20

SELECT c.name AS nombre_categoria, AVG(f.length) AS promd_duracion
FROM category c
INNER JOIN film_category z ON c.category_id = z.category_id
INNER JOIN film f ON z.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > 120;

-- Ejercicio 21

SELECT a.first_name, a.last_name, COUNT(y.film_id) AS cantd_pelis
FROM actor a
INNER JOIN film_actor y ON a.actor_id = y.actor_id
GROUP BY a.actor_id
HAVING COUNT(y.film_id) >= 5;

-- Ejercicio 22

SELECT f.title
FROM film f
WHERE f.film_id IN (
    SELECT i.film_id
    FROM rental r
    INNER JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE DATEDIFF(r.return_date, r.rental_date) > 5
);


-- Ejercicio 23 (La segunda parte no la entiendo, y no consigo)

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT y.actor_id
    FROM film_category z
    INNER JOIN film f ON z.film_id = f.film_id
    INNER JOIN film_actor y ON f.film_id = y.film_id
    INNER JOIN category c ON z.category_id = c.category_id
    WHERE c.name = 'Horror'
);

-- Ejercicio 24

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film
    WHERE length > 180)
    AND film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Comedy'
    )
);

-- Ejercicio 25 (?)


SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM customer;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film_category;
SELECT * FROM category;