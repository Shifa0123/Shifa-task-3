-- Task 3 SQL Queries

-- 1. Customers from India
SELECT customer_id, name, country
FROM customers
WHERE country = 'India'
ORDER BY name ASC;

-- 2. Total revenue per country
SELECT c.country, SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;

-- 3. Inner Join
SELECT c.name, o.order_id, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- 4. Left Join
SELECT c.name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 5. Right Join (if supported)
SELECT c.name, o.order_id, o.total_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- 6. Subquery: customers spending > avg
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (
        SELECT AVG(total_amount) FROM orders
    )
);

-- 7. Avg order value
SELECT AVG(total_amount) AS avg_order_value
FROM orders;

-- 8. Qty sold by product
SELECT p.name, SUM(oi.quantity) AS total_qty
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name;

-- 9. View
CREATE VIEW customer_spending AS
SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 10. Indexes
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);
