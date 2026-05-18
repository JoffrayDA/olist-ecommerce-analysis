-- Delai moyen d'une livraison en jours 
-- Résultat : Moyenne de 12.5 jours. 
SELECT ROUND(AVG(DATEDIFF('day', order_purchase_timestamp, order_delivered_customer_date)),2) AS AVG_delai_commande 
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date  IS NOT NULL ;

-- Pourcentage de commandes en retard
-- Résultat : 8.11% de commandes sont en retard
SELECT ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders WHERE order_status = 'delivered'), 2) AS pct_late_delivery
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date
AND order_status = 'delivered';

-- Delai moyen de livraison par état bresilien
-- Résultat : On voit très clairement que les résultats sont très disparates. L'écart entre l'Etat le plus rapide
-- et le plus long est de presque 3 semaines. 

SELECT  customer_state AS Brezilian_state, ROUND(AVG(DATEDIFF('day', order_purchase_timestamp, order_delivered_customer_date)),2) AS AVG_delai_commande
FROM customers
JOIN orders as o USING (customer_id)
WHERE order_status = 'delivered'
GROUP BY customer_state
ORDER BY AVG_delai_commande;