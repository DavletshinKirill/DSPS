SELECT c.first_name, c.last_name, COALESCE(SUM(o.total_amount), 0) AS total_order_amount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_order_amount DESC ;


SELECT c.first_name, c.last_name, COALESCE(SUM(o.total_amount), 0) AS total_order_amount, ROUND(AVG(o.total_amount), 2) AS average_order_amount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_order_amount DESC ;

SELECT c.first_name, c.last_name, COALESCE(SUM(o.total_amount), 0) AS total_order_amount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_order_amount DESC
LIMIT 5;


SELECT
    c.first_name, c.last_name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IN (
        SELECT customer_id
        FROM
            (
                SELECT customer_id, SUM(total_amount) AS total_order_amount
                FROM orders
                GROUP BY customer_id
                ORDER BY total_order_amount DESC
                LIMIT 5
            ) AS top_customers
    )
ORDER BY c.first_name, c.last_name, o.total_amount, total_amount;



SELECT c.first_name, c.last_name, COALESCE(SUM(o.total_amount), 0) AS total_order_amount, ROUND(AVG(o.total_amount), 2) AS average_order_amount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
group by c.last_name, c.first_name
HAVING COALESCE(SUM(o.total_amount), 0) > ROUND(AVG(o.total_amount), 2)
ORDER BY total_order_amount DESC;


------------------------------------------------------------------------------------------
Индивидуальное задание
__________________________________________________________________________________________

SELECT c.full_name, COALESCE(SUM(p.summa_transfer), 0) AS total_order_amount
FROM Clients AS c
         LEFT JOIN Payments AS p
                   ON c.id = p.client_id
GROUP BY c.full_name
ORDER BY total_order_amount DESC;

SELECT c.full_name, COALESCE(SUM(p.summa_transfer), 0) AS total_order_amount, AVG(p.summa_transfer) AS average_order_amount
FROM Clients AS c
         LEFT JOIN Payments AS p
                   ON c.id = p.client_id
GROUP BY c.full_name
ORDER BY total_order_amount DESC;

SELECT c.full_name, COALESCE(SUM(p.summa_transfer), 0) AS total_order_amount
FROM Clients AS c
         LEFT JOIN Payments AS p
                   ON c.id = p.client_id
GROUP BY c.full_name
ORDER BY total_order_amount DESC
LIMIT 5;



SELECT
    c.full_name, p.id AS order_id, p.summa_transfer AS total_amount
FROM Clients c
LEFT JOIN Payments p ON c.id = p.client_id
WHERE c.id IN (
        SELECT client_id
        FROM
            (
                SELECT client_id, SUM(summa_transfer) AS total_order_amount
                FROM Payments
                GROUP BY client_id
                ORDER BY total_order_amount DESC
                LIMIT 5
            ) AS top_customers
    )
ORDER BY c.full_name, p.summa_transfer;


FROM Clients c
         LEFT JOIN Payments p ON c.id = p.client_id
GROUP BY c.full_name
HAVING COALESCE(SUM(p.summa_transfer), 0) > AVG(p.summa_transfer)
ORDER BY total_order_amount DESC;
