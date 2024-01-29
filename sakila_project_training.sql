USE sakila;

-- Iniciando com o número de filmes alugados por categoria, mais a receita total
SELECT 
	category.name AS categoria, 
	COUNT(inventory.film_id) AS totalFilms,
    SUM(payment.amount) AS receita
FROM
	film 
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN inventory ON film.film_id = inventory.film_id
    JOIN category ON film_category.category_id = category.category_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY
	categoria
ORDER BY
	receita DESC;
    
-- Quais foram os clientes que mais gastaram com nossa loja?
SELECT 
	customer.customer_id AS cliente,
    customer.first_name AS nome,
    customer.last_name AS sobrenome,
    payment.rental_id AS rent_id,
    payment.amount AS totalPago
FROM
    customer
	JOIN payment ON customer.customer_id = payment.customer_id
ORDER BY
	totalPago DESC;

-- Quais os atores/atrizes cujo o nome iniciam com A?
SELECT * 
FROM actor
WHERE first_name LIKE 'a%';

-- Número de filmes por ator
SELECT 
	film_actor.actor_id,
	COUNT(film_actor.actor_id) as totalFilmes
FROM film_actor 
	JOIN film ON film_actor.film_id = film.film_id
GROUP BY
	film_actor.actor_id
ORDER BY 
	totalFilmes DESC;

-- Número de filmes por ator com filtro
SELECT 
	film_actor.actor_id,
    actor.first_name as nome,
    actor.last_name as sobrenome,
	COUNT(film_actor.actor_id) as totalFilmes
FROM film_actor 
	JOIN film ON film_actor.film_id = film.film_id
    JOIN actor ON actor.actor_id = film_actor.actor_id
GROUP BY
	film_actor.actor_id
HAVING
	totalFilmes >= 35
ORDER BY 
	totalFilmes DESC;

-- Quantidade de filmes por estoque
SELECT 
	inventory.inventory_id, 
    COUNT(inventory.film_id) AS Estoque,
    film.title AS Filme
FROM
	inventory
JOIN 
	film ON film.film_id = inventory.film_id
GROUP BY
    inventory.inventory_id;

-- Top clientes por categoria específica
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(*) AS total_alugueis
FROM
    customer c
    
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id

WHERE
    cat.name = 'Action'
GROUP BY
    c.customer_id, c.first_name, c.last_name
ORDER BY
    total_alugueis DESC;



