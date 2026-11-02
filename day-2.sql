--Q6: Produce an order report showing each completed order with the customer's name,
-- city and order date.
select * from orders
where status='completed'

select * from customers

select name,city,order_date from customers c 
join orders o
on c.customer_id=o.customer_id
where status ='completed'

select name,city,order_date from customers c 
natural  join orders o
where status ='completed'


--Q7:Which products have never been ordered?
--m1:subquery
select * from products


select distinct product_id from order_items
order by product_id

select * from products 
where product_id not in (select distinct product_id from order_items
					order by product_id)

-- m2: joins 
select p.* from products p
natural left join order_items oi
where oi.item_id is null



-- Q8:Who are the top 5 customers by total amount spent? Show their name, state and total.
select *  from customers
select *  from order_items
select *  from orders

select c.name,c.state,sum(unit_price*quantity) total from customers c 
natural join orders o
natural join order_items
group by c.name,c.state
order by total desc
limit 5

-- Q9: Which orders contain more than three different products?
-- Q10: What is the total revenue generated per product category?
