/*Q1. Write a query to display customer_id, customer full name with their title (Mr/Ms), 
 both first name and last name are in upper case, customer_email,  customer_creation_year 
 and display customer’s category after applying below categorization rules:
 i. if CUSTOMER_CREATION_DATE year <2005 then category A
 ii. if CUSTOMER_CREATION_DATE year >=2005 and <2011 then category B 
 iii. if CUSTOMER_CREATION_DATE year>= 2011 then category C
 Expected 52 rows in final output.
 [Note: TABLE to be used - ONLINE_CUSTOMER TABLE] 
Hint:Use CASE statement. create customer_creation_year column with the help of customer_creation_date,
 no permanent change in the table is required. (Here don’t UPDATE or DELETE the columns in the table nor CREATE new tables
 for your representation. A new column name can be used as an alias for your manipulation in case if you are going to use a CASE statement.) 
*/

## Answer 1.
/*select * from online_customer;
select customer_id, customer_email,YEAR(CUSTOMER_CREATION_DATE) AS customer_creation_year,
        concat( CASE WHEN customer_gender ='F' THEN 'Mrs.' ELSE 'Mr.' end ,
        upper(customer_fname),' ', upper(customer_lname)) as customer_fullname ,
        case
        when YEAR(CUSTOMER_CREATION_DATE)<2005 then 'category A'
	    when YEAR(CUSTOMER_CREATION_DATE)>=2005 AND   YEAR(CUSTOMER_CREATION_DATE) <2011 then 'category B'
		WHEN  YEAR(CUSTOMER_CREATION_DATE)>= 2011 then 'category C'
        END AS category
        FROM online_customer;*/


/* Q2. Write a query to display the following information for the products which
 have not been sold: product_id, product_desc, product_quantity_avail, product_price,
 inventory values (product_quantity_avail * product_price), New_Price after applying discount
 as per below criteria. Sort the output with respect to decreasing value of Inventory_Value. 
i) If Product Price > 20,000 then apply 20% discount 
ii) If Product Price > 10,000 then apply 15% discount 
iii) if Product Price =< 10,000 then apply 10% discount 
Expected 13 rows in final output.
[NOTE: TABLES to be used - PRODUCT, ORDER_ITEMS TABLE]
Hint: Use CASE statement, no permanent change in table required. 
(Here don’t UPDATE or DELETE the columns in the table nor CREATE new tables for your representation.
 A new column name can be used as an alias for your manipulation in case if you are going to use a CASE statement.)
*/
## Answer 2.

/*select product_id ,product_desc,product_quantity_avail,product_price, (product_quantity_avail * product_price) as inventory_values ,
case
when Product_Price>20000 then 0.8*Product_Price
when Product_Price>10000 then 0.85*Product_Price
when Product_Price<=10000 then 0.9* Product_Price
end as new_price
from product
WHERE  product_id  NOT IN
(SELECT product_id from order_items)
order by  inventory_values desc;*/



/*Q3. Write a query to display Product_class_code, Product_class_desc, Count of Product type in each product class, 
Inventory Value (p.product_quantity_avail*p.product_price). Information should be displayed for only those
 product_class_code which have more than 1,00,000 Inventory Value. Sort the output with respect to decreasing value of Inventory_Value. 
Expected 9 rows in final output.
[NOTE: TABLES to be used - PRODUCT, PRODUCT_CLASS]
Hint: 'count of product type in each product class' is the count of product_id based on product_class_code.
*/

## Answer 3.

/*SELECT p.PRODUCT_CLASS_CODE, pc.Product_class_desc , count(p.product_id) as product_type ,
sum(p.product_quantity_avail*p.product_price) as Inventory_Value
FROM PRODUCT  as p
INNER JOIN PRODUCT_CLASS  as pc
ON p.PRODUCT_CLASS_CODE = pc.PRODUCT_CLASS_CODE 
group by p.product_class_code
HAVING Inventory_Value > 100000
ORDER BY inventory_value DESC;*/

/* Q4. Write a query to display customer_id, full name, customer_email, customer_phone and
 country of customers who have cancelled all the orders placed by them.
Expected 1 row in the final output
[NOTE: TABLES to be used - ONLINE_CUSTOMER, ADDRESSS, OREDER_HEADER]
Hint: USE SUBQUERY
*/
 
## Answer 4.
/*select c.customer_id,concat(c.CUSTOMER_FNAME,' ',c.CUSTOMER_LNAME) as customer_fullname, c.customer_email,c.customer_phone,a.country 
from online_customer as c
join address as a
on c.address_id=a.address_id
where c.customer_id in (
        select o.customer_id
        from ORDER_HEADER o
        where order_status = 'Cancelled'
        group by o.customer_id
        having count(order_id) = (
                select count(order_id)
                from ORDER_HEADER p
                where o.customer_id = p.customer_id
            )
    );*/



/*Q5. Write a query to display Shipper name, City to which it is catering, num of customer catered by the shipper in the city ,
 number of consignment delivered to that city for Shipper DHL 
Expected 9 rows in the final output
[NOTE: TABLES to be used - SHIPPER, ONLINE_CUSTOMER, ADDRESSS, ORDER_HEADER]
Hint: The answer should only be based on Shipper_Name -- DHL. The main intent is to find the number
 of customers and the consignments catered by DHL in each city.
 */

## Answer 5.  
/*select s.SHIPPER_NAME,a.CITY,
    count(distinct O.customer_id) as "num of customer",
    count(h.order_id) as " num of consignment"
from address as a
    join ONLINE_CUSTOMER as o
    on o.ADDRESS_ID = a.ADDRESS_ID
    join ORDER_HEADER as h
    on o.customer_id = h.customer_id
    join shipper s on s.SHIPPER_ID = h.SHIPPER_ID
where s.SHIPPER_NAME = 'DHL'
group by a.city;*/


/*Q6. Write a query to display product_id, product_desc, product_quantity_avail, quantity sold and 
show inventory Status of products as per below condition: 

a. For Electronics and Computer categories, 
if sales till date is Zero then show  'No Sales in past, give discount to reduce inventory', 
if inventory quantity is less than 10% of quantity sold, show 'Low inventory, need to add inventory', 
if inventory quantity is less than 50% of quantity sold, show 'Medium inventory, need to add some inventory',
if inventory quantity is more or equal to 50% of quantity sold, show 'Sufficient inventory' 

b. For Mobiles and Watches categories, 
if sales till date is Zero then show 'No Sales in past, give discount to reduce inventory', 
if inventory quantity is less than 20% of quantity sold, show 'Low inventory, need to add inventory', 
if inventory quantity is less than 60% of quantity sold, show 'Medium inventory, need to add some inventory', 
if inventory quantity is more or equal to 60% of quantity sold, show 'Sufficient inventory' 

c. Rest of the categories, 
if sales till date is Zero then show 'No Sales in past, give discount to reduce inventory', 
if inventory quantity is less than 30% of quantity sold, show 'Low inventory, need to add inventory', 
if inventory quantity is less than 70% of quantity sold, show 'Medium inventory, need to add some inventory',
if inventory quantity is more or equal to 70% of quantity sold, show 'Sufficient inventory'
Expected 60 rows in final output
[NOTE: (USE CASE statement) ; TABLES to be used - PRODUCT, PRODUCT_CLASS, ORDER_ITEMS]
Hint:  quantity sold here is product_quantity in order_items table. 
You may use multiple case statements to show inventory status (Low stock, In stock, and Enough stock)
 that meets both the conditions i.e. on products as well as on quantity.
The meaning of the rest of the categories, means products apart from electronics, computers, mobiles, and watches.
*/

## Answer 6.
/*SELECT P.PRODUCT_ID, P.PRODUCT_DESC, P.PRODUCT_QUANTITY_AVAIL,SUM(o.PRODUCT_QUANTITY) AS Quantity_Sold,
CASE WHEN PC.PRODUCT_CLASS_DESC IN ('Electronics', 'Computer') THEN
CASE WHEN SUM(o.PRODUCT_QUANTITY) is null THEN 'No Sales in past, give discount to reduce inventory'
	WHEN P.PRODUCT_QUANTITY_AVAIL < 0.1 * SUM(o.PRODUCT_QUANTITY) THEN 'Low inventory, need to add inventory'
	WHEN P.PRODUCT_QUANTITY_AVAIL < 0.5 * SUM(o.PRODUCT_QUANTITY) THEN 'Medium inventory, need to add some inventory'
	ELSE 'Sufficient inventory'
	END
	WHEN PC.PRODUCT_CLASS_DESC IN ('Mobiles', 'Watches') THEN
CASE
	WHEN SUM(o.PRODUCT_QUANTITY) is null THEN 'No Sales in past, give discount to reduce inventory'
    WHEN P.PRODUCT_QUANTITY_AVAIL < 0.2 * SUM(o.PRODUCT_QUANTITY) THEN 'Low inventory, need to add inventory'
    WHEN P.PRODUCT_QUANTITY_AVAIL < 0.6 * SUM(o.PRODUCT_QUANTITY) THEN 'Medium inventory, need to add some inventory'
    ELSE 'Sufficient inventory'
    END
ELSE
CASE
     WHEN SUM(o.PRODUCT_QUANTITY) is null THEN 'No Sales in past, give discount to reduce inventory'
     WHEN P.PRODUCT_QUANTITY_AVAIL < 0.3 * SUM(o.PRODUCT_QUANTITY) THEN 'Low inventory, need to add inventory'
     WHEN P.PRODUCT_QUANTITY_AVAIL < 0.7 * SUM(o.PRODUCT_QUANTITY) THEN 'Medium inventory, need to add some inventory'
     ELSE 'Sufficient inventory'
     END
    END AS Inventory_Status
FROM PRODUCT as P
JOIN PRODUCT_CLASS as PC ON P.PRODUCT_CLASS_CODE = PC.PRODUCT_CLASS_CODE
LEFT JOIN ORDER_ITEMS as o ON P.PRODUCT_ID = o.PRODUCT_ID
GROUP BY P.PRODUCT_ID, P.PRODUCT_DESC, P.PRODUCT_QUANTITY_AVAIL, PC.PRODUCT_CLASS_DESC;*/
  
          

/* Q7. Write a query to display order_id and volume of the biggest order (in terms of volume) that can fit in carton id 10 .
Expected 1 row in final output
[NOTE: TABLES to be used - CARTON, ORDER_ITEMS, PRODUCT]
Hint: First find the volume of carton id 10 and then find the order id with products having total volume less than the volume of carton id 10
 */

## Answer 7.
/*select sum(p.len*p.width*p.height) as volume ,o.order_id
from product as p
join order_items as o  ON o.PRODUCT_ID = p.PRODUCT_ID
GROUP BY o.ORDER_ID
having sum(len * width * height) < (
        select (len * width * height)
        from CARTON where CARTON_ID = 10)
order by volume 
limit 1;*/

/*Q8. Write a query to display customer id, customer full name, total quantity and total value (quantity*price) 
shipped where mode of payment is Cash and customer last name starts with 'G'
Expected 2 rows in final output
[NOTE: TABLES to be used - ONLINE_CUSTOMER, ORDER_ITEMS, PRODUCT, ORDER_HEADER]
*/

## Answer 8.
/*select c.customer_id,concat( CASE WHEN customer_gender ='F' THEN 'Mrs.' ELSE 'Mr.' end ,
        upper(customer_fname),' ', upper(customer_lname)) as customer_fullname ,
 sum(PRODUCT_QUANTITY) as "total quantity",sum(PRODUCT_QUANTITY * PRODUCT_PRICE) as "total value"
 from ONLINE_CUSTOMER as c
join ORDER_HEADER p on p.CUSTOMER_ID = c.CUSTOMER_ID
    join ORDER_ITEMS as O on p.order_id = O.order_id
    join PRODUCT q on q.product_id = o.product_id
where CUSTOMER_LNAME like 'G%'and PAYMENT_MODE = 'Cash'
group by c.customer_id;*/


/*Q9. Write a query to display product_id, product_desc and total quantity of products which are sold together 
with product id 201 and are not shipped to city Bangalore and New Delhi. 
[NOTE: TABLES to be used - ORDER_ITEMS, PRODUCT, ORDER_HEADER, ONLINE_CUSTOMER, ADDRESS]
Hint: Display the output in descending order with respect to the sum of product_quantity. 
(USE SUB-QUERY) In final output show only those products , 
 product_id’s which are sold with 201 product_id (201 should not be there in output) and are shipped except Bangalore and New Delhi
 */

## Answer 9.
/*select p.product_id ,p.product_desc,sum(o.PRODUCT_QUANTITY) as "total_quantity" from  product as P
JOIN ORDER_ITEMS as o ON o.PRODUCT_ID = p.PRODUCT_ID
JOIN ORDER_HEADER as h ON o.ORDER_ID = h.ORDER_ID
JOIN ONLINE_CUSTOMER as c ON h.CUSTOMER_ID = c.CUSTOMER_ID
JOIN ADDRESS as a ON c.ADDRESS_ID = a.ADDRESS_ID
where O.order_id in (
        select order_id
        from ORDER_ITEMS
        where product_id = 201
    )
    and P.product_id != 201
    and CITY NOT IN ("Bangalore", "New Delhi")
group by P.product_id
ORDER BY total_quantity DESC;*/

/* Q10. Write a query to display the order_id, customer_id and customer fullname, 
total quantity of products shipped for order ids which are even and shipped to address where pincode is not starting with "5" 
Expected 15 rows in final output
[NOTE: TABLES to be used - ONLINE_CUSTOMER, ORDER_HEADER, ORDER_ITEMS, ADDRESS]	
 */

## Answer 10.
/*SELECT ORDER_ID, CUSTOMER_ID,  concat( CASE WHEN customer_gender ='F' THEN 'Mrs.' ELSE 'Mr.' end ,
        upper(customer_fname),' ', upper(customer_lname)) as customer_fullname, SUM(PRODUCT_QUANTITY) AS total_quantity_shipped
FROM ORDER_ITEMS , ONLINE_CUSTOMER, ADDRESS
WHERE ORDER_ID % 2 = 0
AND PINCODE NOT LIKE '5%'
GROUP BY ORDER_ID, CUSTOMER_ID, customer_fullname
ORDER BY ORDER_ID
LIMIT 15;*/
