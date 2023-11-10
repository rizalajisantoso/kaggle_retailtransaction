#Use master_table
#Exploratory Data Analysis
#Seeing different kind of payment method, city, store_type, customer, season, and promotion used
select distinct(payment_method) from master_table;
select distinct(city) from master_table;
select distinct(store_type) from master_table;
select distinct(customer_category) from master_table;
select distinct(season) from master_table;
select distinct(promotion) from master_table;
select distinct(Product) from master_table;


#The total sales and number of transaction made from each city
select 
city,
count(transaction_id) as number_of_transaction, 
round(sum(total_cost),0) as total_sales,
round(avg(total_cost),2) as avg_sales_per_transaction

from master_table
group by city
order by sum(total_cost) desc;

#Who spend the most money in our store?
select customer_category,
count(transaction_id) as number_of_transaction,
round(avg(total_cost),2) as average_sales,
round(sum(total_cost),0) as total_sales

from master_table
group by Customer_Category
order by sum(total_cost) desc;

#Which store and city make the most money?
select 
city,
store_type,
count(transaction_id) as number_of_transaction,
round(sum(total_cost),0) as total_sales

from master_table
group by
city,
store_type

order by
sum(total_cost) desc;

# How much transaction use / not use promotion and the total sales?
select
promotion,
count(transaction_id) as number_of_transaction,
round(sum(total_cost),0) as total_sales,
round(avg(total_cost),2) as average_sales

from master_table
group by promotion
order by count(transaction_id) desc;

# Which store underperform based on average sales in 2023?
with 2023_sales as   	#Using CTE to create the total sales from each store type and city in 2023
(
select 
city,
store_type, 
sum(total_cost) as total_sales

from master_table
where year(date) = 2023
group by city, store_type
)

select 
city,
store_type,
sum(total_cost) as total_sales

from master_table

where
year(date) = 2023

group by 
city,store_type

having
total_sales 
<
(select avg(totaL_sales) from 2023_sales)

order by total_sales desc;