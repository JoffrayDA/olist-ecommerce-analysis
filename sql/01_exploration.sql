-- Statuts des commandes 
-- Résultat : Plus de 2% des commandes n'ont jamais été livrées 
SELECT order_status, COUNT(order_status) AS nombre_de_commandes
FROM orders 
GROUP BY order_status
ORDER BY nombre_de_commandes DESC;

-- Periode du dataset 
-- Résultat : 2016-09-04 / 2018-10-17 
SELECT MIN(order_purchase_timestamp) AS date_debut, MAX(order_purchase_timestamp) AS date_fin
FROM orders;

-- Revenu total généré par les commandes + panier moyen
-- Résultat : Revenu total : 16008872.12$ / Panier_moyen : 154.1$
SELECT ROUND(SUM(payment_value),2) AS revenu_total, ROUND(AVG(payment_value),1) AS panier_moyen 
FROM order_payments; 




