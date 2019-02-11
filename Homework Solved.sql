Use Sakila;
show tables;
SELECT * FROM actor;

# 1a.
SELECT first_name, last_name FROM actor;

# 1b. 
SELECT UPPER(CONCAT(first_name," ",last_name))
as Actor_Name FROM actor;

# 2a.
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';
    
# 2b.
SELECT actor_id, first_name, last_name 
FROM actor WHERE INSTR(`last_name`, 'Gen');

# 2c.
SELECT actor_id, first_name, last_name FROM actor WHERE INSTR(`last_name`, 'Li')
ORDER BY last_name, first_name;
    
# 2d.
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
    
# 3a.
ALTER TABLE actor
	ADD COLUMN middle_name VARCHAR(20) AFTER first_name;
	SELECT * FROM actor;
    
# 3b. 
ALTER TABLE actor
	DROP middle_name,
	ADD COLUMN middle_name BLOB AFTER first_name;
	SELECT * FROM actor;
    
# 3c.
ALTER TABLE actor
	DROP middle_name;
	SELECT * FROM actor;
    
# 4a. 
SELECT last_name, 
	COUNT(last_name) as CNT
	FROM actor 
	GROUP BY last_name;

# 4b. 
SELECT last_name, 
	COUNT(last_name) as CNT
	FROM actor
	GROUP BY last_name
	Having COUNT(*) >=2;

# 4c. 
UPDATE actor
	SET first_name = 'HARPO'
	WHERE first_name = 'GROUCHO' AND last_name = 'Williams';
	SELECT * FROM actor
    WHERE last_name = 'Williams';

#4d. 
UPDATE actor SET first_name = CASE 
WHEN first_name = 'GROUCHO' AND last_name = 'Williams' THEN 'MUCHO GROUCHO' 
WHEN first_name = 'HARPO' AND last_name = 'Williams' THEN 'GROUCHO'
ELSE first_name
END
WHERE last_name = 'Williams';

# 5a. 
SHOW CREATE TABLE address;


# 6a.
SELECT first_name, last_name, address FROM staff
	JOIN(address) ON staff.address_id=address.address_id;

# 6b.  
SELECT username, Sum(amount) FROM staff
	JOIN(payment) ON staff.staff_id=payment.staff_id 	
	WHERE payment_date BETWEEN '2005-08-01 00:00:00' and '2005-09-01 00:00:00' 
	GROUP BY username;

# 6c.
SELECT title, COUNT(*) AS Number_of_Actors FROM film
	JOIN film_actor ON film.film_id = film_actor.film_id
	GROUP BY title;
    
# 6d.
SELECT title, COUNT(inventory_id) FROM inventory JOIN(film) ON inventory.film_id=film.film_id
	WHERE title = 'Hunchback Impossible'
	GROUP BY title;
 
# 6e. 
SELECT first_name, last_name, SUM(amount) FROM customer JOIN(payment) ON customer.customer_id=payment.customer_id
	GROUP BY first_name, last_name
    ORDER BY last_name DESC;

# 7a. 
SELECT title, name FROM film JOIN(language) ON film.language_id=language.language_id
	WHERE name = 'English' AND title LIKE 'k%' or title LIKE 'q%';

    

# 7b. 
SELECT title, first_name, last_name FROM actor JOIN(film_actor) ON actor.actor_id = film_actor.actor_id
	JOIN(film) ON film_actor.film_id=film.film_id
    WHERE title ='ALONE TRIP';


# 7c. 
SELECT first_name, last_name, email FROM customer 
	JOIN(address) ON customer.address_id=address.address_id
    JOIN(city) ON address.city_id=city.city_id
    JOIN(country) ON city.country_id=country.country_id
	WHERE country='Canada';
     

# 7d. 
SELECT title, name AS Genre FROM film_category
	JOIN(category) ON category.category_id=film_category.category_id
	JOIN(film) ON film.film_id=film_category.film_id
	WHERE name='family';

# 7e.
SELECT title, COUNT(*) FROM payment
	JOIN rental ON payment.rental_id=rental.rental_id
	JOIN inventory ON rental.inventory_id=inventory.inventory_id
	JOIN film ON inventory.film_id=film.film_id
	GROUP BY title
	ORDER BY COUNT(*) DESC;
		
# 7f. 
SELECT store_id, concat('$',format(SUM(amount),2)) AS USD FROM staff 
	JOIN payment ON staff.staff_id=payment.staff_id
	GROUP BY store_id;

# 7g.
SELECT store_id, city, country FROM staff
	JOIN address ON staff.address_id=address.address_id
	JOIN city ON address.city_id=city.city_id
	JOIN country ON city.country_id=country.country_id;
    
# 7h. 
SELECT name AS Genre, concat('$',format(SUM(amount),2)) AS Gross_Revenue FROM category
	JOIN film_category ON category.category_id=film_category.category_id
	JOIN inventory ON film_category.film_id=inventory.film_id
	JOIN rental ON inventory.inventory_id=rental.inventory_id
	JOIN payment ON rental.rental_id=payment.rental_id
	GROUP BY Genre
	ORDER BY SUM(amount) DESC
    LIMIT 5;
# 8a. 
Create View Top_5_Genres AS(
SELECT name AS Genre, concat('$',format(SUM(amount),2)) AS Gross_Revenue FROM category
	JOIN film_category ON category.category_id=film_category.category_id
	JOIN inventory ON film_category.film_id=inventory.film_id
	JOIN rental ON inventory.inventory_id=rental.inventory_id
	JOIN payment ON rental.rental_id=payment.rental_id
	GROUP BY Genre
	ORDER BY SUM(amount) DESC
    LIMIT 5
    );
    
Select*from Top_5_Genres;

# 8b. 
#'See 7h & 8a'

# 8c. 
Drop VIEW Top_5_Genres