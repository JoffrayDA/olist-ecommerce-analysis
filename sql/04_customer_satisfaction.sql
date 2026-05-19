-- Note moyenne des commandes 
-- Résultat :  4.09 de moyenne 
SElECT ROUND(AVG(review_score),2) AS note_moyenne
FROM order_reviews;

-- Distribution des notes 
-- Résultat : Grosse majorité de 5, représentant 58%. Globalement, la plateforme est bien notée
SELECT COUNT(review_id) AS nombre_avis, review_score
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

-- Impact du délai de livraison sur la note 
-- Résultat : Relation claire établie entre le délai et la note 
-- Note de 5 : 10.63 jours en moyenne 
-- Note de 1 : 21.25 jours en moyenne, près du double comparé au 5 
-- Plus la livraison est lente, plus la note sera basse 
SELECT ROUND(AVG(DATEDIFF('day', order_purchase_timestamp, order_delivered_customer_date)),2) AS AVG_delai_commande, o_r.review_score
FROM orders
JOIN order_reviews as o_r
USING (order_id)
GROUP BY o_r.review_score
ORDER BY o_r.review_score   



