-- Q1: What is NaijaShop's total revenue from completed orders?

select * from order_items

select order_id from orders
where status ='completed'

select *  from order_items
where order_id in (select order_id from orders
					where status ='completed')

select sum(quantity*unit_price) total_revenue from order_items
where order_id in (select order_id from orders
					where status ='completed')

--Q2: What is the average order value (average total spend per completed order)?

select round(sum(quantity*unit_price)/(select count(order_id) from orders
									where status ='completed'),2)
avg_amount from order_items
where order_id in (select order_id from orders
					where status ='completed')


--Q3 : How many customers are registered in each state? List them from most to fewest.

select state,count(*) from customers
group by state
order by count desc




-- Q4: How many new customers signed up in the last 170 days?

select count(*) from customers
where current_date-signup_date<=170

-- Q5: What are the most and least expensive products in the catalogue?
--m1:
(select 'least-expensive', * from products
order by price limit 1)
union
(select 'most-expensive',* from products
order by price desc limit 1)

--m2:
select max(price) from products

select min(price) from products

(select 'most-expensive',* from products 
where price =(select max(price) from products))
union
(select 'least-expensive',* from products 
where price =(select min(price) from products))
