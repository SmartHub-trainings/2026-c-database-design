
-- Q11: Which customers spent more than the overall average customer spend?


select round(avg(sum),2) from (select customer_id, sum(unit_price*quantity) from orders o
						natural join order_items oi
						group by customer_id)



with total_table as (select customer_id, sum(unit_price*quantity) from orders o
						natural join order_items oi
						group by customer_id)
select customer_id from total_table where sum >(select avg(sum) from total_table)

--m1: Subqueries
select * from customers 
where customer_id in (with total_table as (select customer_id, sum(unit_price*quantity) from orders o
						natural join order_items oi
						group by customer_id)
						select customer_id from total_table where sum >(select avg(sum) from total_table))

-- m2: Join 
with total_table as (select customer_id, sum(unit_price*quantity) from orders o
						natural join order_items oi
						group by customer_id)
select c.* from total_table tt
natural join customers c
where sum >(select avg(sum) from total_table)


-- Q12: Which products are priced above the average price of their own category?

--m1:
with cat_avg as (select category_id, avg(price) from products
				group by category_id)
select * from products p 
where price > (select avg from  cat_avg where p.category_id=cat_avg.category_id )

--m2:
select * from products p
where price > (select avg(price) from products p1 where p1.category_id=p.category_id )
-- Q13: For each state, what is the single highest-value order?
with state_orders as (select state,order_id, sum(quantity*unit_price) from orders o 
natural join order_items oi 
natural join customers c 
group by o.order_id,state
order by state)

select state,max(sum) from state_orders
group by state
-- Q14: Which customers have ordered from every product category NaijaShop offers?
select * from categories

with cust_count as (select o.customer_id,count(distinct p.category_id) from orders o
natural join products p
group by o.customer_id)

select c.* from cust_count natural join customers c  where count = ( select count(*) from categories)

