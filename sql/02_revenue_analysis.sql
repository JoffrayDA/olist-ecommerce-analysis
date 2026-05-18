-- Revenu mensuel sur l'ensemble de la période 
SELECT STRFTIME('%Y-%m', order_delivered_customer_date) AS date, SUM(op.payment_value) AS revenu_mensuel
FROM orders AS o
JOIN order_payments as op 
ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
AND order_delivered_customer_date IS NOT null 
GROUP BY date
ORDER BY date;

-- Nombre de commandes par mois 
SELECT STRFTIME('%Y-%m', order_delivered_customer_date) AS date, COUNT(order_id) AS nombre_de_commandes
FROM orders
WHERE order_status= 'delivered'
AND order_delivered_customer_date IS NOT NULL
GROUP BY date
ORDER BY date;