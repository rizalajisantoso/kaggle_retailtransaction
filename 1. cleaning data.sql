# Data Cleaning
	# Removing The Quotes (' ') and squared bracked ( [ ] );
    
WITH no_symbol AS 
(
select 
Transaction_ID,
Date,
customer_name,

replace
	(replace(
		replace(Product,'[',''),']',''),"'",'')
        as Product,
        
total_items,
total_cost,
Payment_Method,
city,
store_type,
discount_applied,
Customer_Category,
season,
promotion

FROM raw_data
),

#Identify duplicated data
/*select 
	transaction_id,
    count(transaction_id) as id_count
from no_symbol
group by transaction_id
having  count(transaction_id) > 1;*/

#Removing duplicated data
no_dupli as
(
select 
distinct *  
from no_symbol
)

select * from no_dupli
#Export the CSV File. New table calle master_table