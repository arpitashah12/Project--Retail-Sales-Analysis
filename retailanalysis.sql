------------------------------------------------------Project--Retail Sales Analysis------------------------------------------------

create database intern;

use insert;

---------Create Table--------------

create table custom(
     customer_id int primary key,
     customer_name varchar(100),
     region varchar(50),
     join_date date);

create table produ(
     products_id int primary key,
     products_name varchar(100),
     category varchar(50),
     price decimal(10,2));

create table ord(
     order_id int primary key,
     order_date date,
     customer_id int,
     products_id int,
     quantity int,
     revenue decimal(10,2),
     FOREIGN KEY (customer_id) REFERENCES custom(customer_id),
     FOREIGN KEY (products_id) REFERENCES produ(products_id));

------------------------------------Insert into-----------------------

INSERT INTO custom VALUES
     (1,'Rahul Shah','North','2025-01-11'),
     (2,'Priya sahu','South','2025-02-15'),
     (3,'Amita jain','West','2025-03-21');

INSERT INTO custom VALUES
     (4,'Shruti Jain','West','2025-01-23'),
     (5,'Darashi Jain','North','2025-02-14'),
     (6,'Aryan Shah','South','2025-03-26');

insert into custom values
     (7,'Tithi Sahu','East',NULL);

INSERT INTO produ VALUES
     (101,'Laptop','Electronics',55000),
     (102,'Mobile','Electronics',25000),
     (103,'Chair','Furniture',5000);

INSERT INTO produ VALUES
     (104,'TV','Furniture',50000),
     (105,'Table','Electronics',3000),
     (106,'Study Table','Furniture',2000);

insert into produ values
     (107,NULL,'Furniture',NULL);

INSERT INTO ord VALUES
     (1001,'2025-04-02',1,101,1,55000),
     (1002,'2025-04-04',2,102,2,50000),
     (1003,'2025-04-08',3,103,4,20000),
     (1004,'2025-04-10',4,104,4,5000),
     (1005,'2025-04-12',5,105,3,15000),
     (1006,'2025-04-19',6,106,2,10000);

insert into ord values
     (1007,'2025-04-23',7,107,5,NULL);


------------------------Select--------------------------

select * from custom;
select * from produ;
select * from ord;


----------Total Revenue by Region-------------

select 
c.region,
SUM(o.revenue) AS total_revenue
from ord o  
INNER JOIN custom c 
ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_revenue DESC; 


-------------5 Products by Revenue---------------------------

select
p.products_name,
SUM(o.revenue) AS total_revenue
from ord o
inner join produ p
ON o.products_id = p.products_id
group by p.products_name
order by total_revenue DESC
LIMIT 5;

--------------------------- Category wise Performance----------------------
select
p.category,
SUM(o.revenue) AS category_revenue
from ord o
INNER JOIN produ p
ON o.products_id = p.products_id
GROUP BY p.category;


--------------------------------- Inactive Customers----------------------------

INSERT INTO custom
VALUES (8,'Rohan Verma','North','2025-05-01');


select
c.customer_name
from custom c
LEFT JOIN ord o
ON c.customer_id = o.customer_id
where o.order_id is NULL;

---------------------------------- Average Order Value----------------------

select
AVG(revenue) AS avg_order_value
from ord;

-----------------------------------Monthly Sales Trend----------------------

select 
MONTH(order_date) AS month,
SUM(revenue) AS monthly_revenue
from ord
GROUP BY MONTH(order_date)
ORDER BY month;

-----------------------------------Best Customers per Region------------------

select
c.region,
c.customer_name,
SUM(o.revenue) AS total_revenue
from ord o 
INNER JOIN custom c
ON o.customer_id = c.customer_id
GROUP BY c.region,c.customer_name
ORDER BY c.region,total_revenue DESC;