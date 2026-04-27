WITH order_payments AS (
    SELECT 
        order_id, 
        SUM(payment_value) AS order_revenue
    FROM olist_order_payments_dataset
    GROUP BY order_id
)

SELECT 
    c.customer_unique_id, 
    COUNT(DISTINCT o.order_id) AS total_orders, 
    SUM(op.order_revenue) AS total_revenue,
    AVG(op.order_revenue) AS avg_check
FROM order_payments op
JOIN olist_orders_dataset o USING(order_id)
JOIN olist_customers_dataset c USING(customer_id)

WHERE o.order_status = 'delivered'

GROUP BY c.customer_unique_id
ORDER BY total_revenue DESC, total_orders DESC;
