

/* inventory turnover = Quantity sold in day / current stock */

/*Quantity Sold for each product in day*/
with daily_sold as(
	select o.order_date , od.product_id , sum(od.quantity) as quantity_sold
	from order_details od 
	join orders o on od.order_id = o.id 
	where o.order_date >= DATEADD(day,-30,getdate()) 
	group by o.order_date , od.product_id

),/*current stock for each product in day*/
with_stock as(
	select d.order_date , d.product_id , d.quantity_sold, p.stock_quantity
	from daily_sold d
	join products p on d.product_id = p.id

),/* inventory turnover = Quantity sold in day / current stock */
 avg_turnover as(
	select order_date ,product_id , quantity_sold, stock_quantity,
		   CAST(quantity_sold AS Float ) / stock_quantity as inventory_turnover,
		   AVG(CAST(quantity_sold AS Float ) / stock_quantity) OVER (
		   PARTITION BY product_id 
		   ORDER BY order_date  ) as avg_30_turnover
from with_stock 

)

SELECT 
    *
FROM 
    avg_turnover
ORDER BY 
    product_id, order_date;







/*
select o.order_date , od.product_id , sum(od.quantity) as quantity_sold, p.stock_quantity,
	   CAST(sum(od.quantity) AS Float ) / nullif(p.stock_quantity,0) as inventory_turnover,
	   AVG(CAST(sum(od.quantity) AS Float ) / nullif(p.stock_quantity,0)) OVER (
	   PARTITION BY od.product_id 
	   ORDER BY order_date  ) as avg_30_turnover

from order_details od 
join orders o on od.order_id = o.id 
join products p on od.product_id = p.id
where o.order_date >= DATEADD(day,-30,getdate()) 
group by o.order_date , od.product_id, p.stock_quantity
order by od.product_id;
*/

