-- #01 Film sales tertinggi
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- ^ Klo ga pake yg diatas, error code 1140 & 1050
SELECT inventory.film_id, film.title, SUM(ROUND(payment.amount)) as total_sales
FROM film
JOIN inventory
ON inventory.film_id = film.film_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
JOIN payment
ON payment.rental_id = rental.rental_id
GROUP BY film.title
ORDER BY total_sales DESC
LIMIT 1;

-- #02 Kategori film sales tertinggi
SELECT category.category_id, category.name, SUM(ROUND(payment.amount)) as total_sales
FROM category
JOIN film_category
ON film_category.category_id = category.category_id
JOIN film
ON film.film_id = film_category.film_id
JOIN inventory
ON inventory.film_id = film.film_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
JOIN payment
ON payment.rental_id = rental.rental_id
GROUP BY category.name
ORDER BY total_sales DESC
Limit 1;

-- #03 Total sales per toko
SELECT store.store_id, country.country, city.city ,address.district, address.address, address.location, SUM(ROUND(payment.amount)) as total_sales
FROM country
JOIN city
ON city.country_id = country.country_id
JOIN address
ON city.city_id = address.city_id
JOIN store
ON store.address_id = address.address_id
JOIN inventory
ON inventory.store_id = store.store_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
JOIN payment
ON payment.rental_id = rental.rental_id
GROUP BY store.store_id
ORDER BY total_sales DESC;

-- #04 Group concat
SELECT length AS film_diatas_2jam, GROUP_CONCAT(DISTINCT title), COUNT(DISTINCT title) AS total_film
FROM film
WHERE length > 120
GROUP BY length;