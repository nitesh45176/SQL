1045. Customers Who Bought All Products

Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
 

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.


Code:
select customer_id from customer
group by customer_id
having count(distinct product_key) = (select count(product_key) from product)


Explaination:
1. GROUP BY customer_id
GROUP BY customer_id


Same customer ki saari purchases ko ek group mein divide karta hai.

Example:
customer_id	product_key
1	5
1	6
2	6
3	5
3	6

Ab customer 1, 2 aur 3 ke separate groups ban jayenge.
2. COUNT(DISTINCT product_key)
COUNT(DISTINCT product_key)


Har customer ne kitne unique products purchase kiye hain, woh count karta hai.

DISTINCT important hai kyunki Customer table mein duplicate rows ho sakti hain.

Example:
customer_id	Unique products count
1	2
2	1
3	2

3. Subquery
SELECT COUNT(product_key)
FROM Product


Product table mein total kitne products hain, woh count karta hai.

Example:
product_key
5
6

Output: 2
4. HAVING
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(product_key)
    FROM Product
)


Ab dono counts compare honge:
customer_id	Purchased products	Total products	Selected?
1	2	2	Yes
2	1	2	No
3	2	2	Yes

Sirf wahi customers select honge jinhone saare products purchase kiye hain.

Important concept to remember
Is question ka main logic hai:
- GROUP BY → Customer-wise groups banao.
- COUNT(DISTINCT) → Har customer ke unique products count karo.
- Subquery → Product table se total products count karo.
- HAVING → Dono counts equal hone chahiye.
Interview tip: Jab question mein likha ho "customers who bought all products", toh ek useful approach hai:
\[
\text{Customer's unique product count} = \text{Total product count}
\]

Yahi is problem ka core logic hai.
