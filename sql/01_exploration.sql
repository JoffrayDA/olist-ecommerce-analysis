-- Statuts des commandes 
SELECT order_status, COUNT(order_status) AS nombre_de_commandes
FROM orders 
GROUP BY order_status
ORDER BY nombre_de_commandes DESC;

-- Periode du dataset 
SELECT MIN(order_purchase_timestamp) AS date_debut, MAX(order_purchase_timestamp) AS date_fin
FROM orders;

-- Revenu total généré par les commandes + panier moyen
SELECT ROUND(SUM(payment_value),2) AS revenu_total, ROUND(AVG(payment_value),1) AS panier_moyen 
FROM order_payments; 

-- Colonnes critiques table orders 
SELECT COUNT(*), COUNT(order_delivered_carrier_date), COUNT(order_delivered_customer_date), COUNT(order_estimated_delivery_date)
FROM orders;



