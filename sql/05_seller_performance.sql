-- TOP 10 vendeurs par revenu total
-- Le meilleur vendeur génère 507 166$ soit presque le double du 2ème (308 222$)
-- Fort écart entre les top vendeurs, marché concentré sur quelques acteurs
SELECT seller_id, ROUND(SUM(payment_value),2) AS revenu_total
FROM order_items AS o_i
JOIN order_payments AS o_p ON o_p.order_id = o_i.order_id
GROUP BY seller_id
ORDER BY SUM(payment_value) DESC
LIMIT 10;

-- Note moyenne par vendeur 
-- TOP 10 Meilleurs vendeurs (min. 50 avis pour être représentatif)
-- Meilleure moyenne : 4.82/5. Aucun vendeur n'atteint la perfection avec un volume significatif
SELECT seller_id, ROUND(AVG(review_score),2) AS moyenne_note
FROM order_items AS o_i
JOIN order_reviews AS o_r USING (order_id)
GROUP BY seller_id
HAVING COUNT(o_r.review_score) >= 50
ORDER BY moyenne_note DESC
LIMIT 10;

-- TOP 10 pires vendeurs (min. 10 avis)
-- Plus mauvaise moyenne : 1.26/5. Ces vendeurs nuisent à l'image de la plateforme
SELECT seller_id, ROUND(AVG(review_score),2) AS moyenne_note
FROM order_items AS o_i
JOIN order_reviews AS o_r USING (order_id)
GROUP BY seller_id
HAVING COUNT(o_r.review_score) >= 10
ORDER BY moyenne_note ASC 
LIMIT 10 


