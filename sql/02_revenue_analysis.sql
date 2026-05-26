-- Revenu mensuel sur l'ensemble de la période 
-- Résultat : Sommet en août 2018 avec 1 347 216$ sur 1 mois > Sûrement lié à Noel
-- Evolution exponentielle entre 2016-12 et 2017-02 : La plateforme explose
-- Manque de données après Aout, résultat, les chiffres baissent, On passe de 1 347 216$ à 347.95$ en 2 mois.
SELECT STRFTIME('%Y-%m', order_delivered_customer_date) AS date, SUM(op.payment_value) AS revenu_mensuel
FROM orders AS o
JOIN order_payments as op 
ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
AND order_delivered_customer_date IS NOT null 
GROUP BY date
ORDER BY date;

-- Nombre de commandes par mois 
-- Le nombre de commandes mensuelles augmente globalement jusqu'à fin 2017 et se stabilisent en 2018.
-- Les commandes vont chuter après 2018 reflétant le manque de données évoqué dans la dernière requête
SELECT STRFTIME('%Y-%m', order_delivered_customer_date) AS date, COUNT(order_id) AS nombre_de_commandes
FROM orders
WHERE order_status= 'delivered'
AND order_delivered_customer_date IS NOT NULL
GROUP BY date
ORDER BY date;

-- Revenu mensuel + comparaison mois précédent
-- Sur deux ans, on voit que les revenus mensuels ont beaucoup évolués.
-- Le pic de la plus grosse variation arrive entre novembre et décembre 2017 (+347 369$)
SELECT
    date,
    revenu_mensuel,
    LAG(revenu_mensuel) OVER (ORDER BY date) AS revenu_mois_precedent,
    ROUND(revenu_mensuel - LAG(revenu_mensuel) OVER (ORDER BY date), 2) AS variation
FROM (
    SELECT 
        STRFTIME('%Y-%m', order_delivered_customer_date) AS date,
        ROUND(SUM(op.payment_value), 2) AS revenu_mensuel
    FROM orders AS o
    JOIN order_payments AS op ON o.order_id = op.order_id
    WHERE o.order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
    GROUP BY date
    ORDER BY date
)
