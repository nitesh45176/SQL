1070. Product Sales Analysis III

Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
Each row records a sale of a product in a given year.
A product may have multiple sales entries in the same year.
Note that the per-unit price.

Write a solution to find all sales that occurred in the first year each product was sold.

For each product_id, identify the earliest year it appears in the Sales table.

Return all sales entries for that product in that year.

Return a table with the following columns: product_id, first_year, quantity, and price.
Return the result in any order.

 

Example 1:

Input: 
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+

Output: 
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+


CODE:
select  product_id, year as first_year,
quantity, price from sales
where ((product_id, year) in (select product_id, min(year) from sales group by product_id))


Explaination:
1. Why your first query is wrong
Your query:
SELECT DISTINCT
    product_id,
    MIN(year) AS first_year,
    quantity,
    price
FROM Sales
GROUP BY product_id;

Problem 1: GROUP BY product_id
Suppose your table contains:
sale_id	product_id	year	quantity	price
1	100	2008	10	5000
2	100	2008	20	5000
3	100	2009	12	5000
4	200	2011	15	9000


When you write:
GROUP BY product_id

MySQL groups all rows belonging to the same product into one group.

For product 100, the group contains all three rows.

Then:
MIN(year)

correctly returns 2008.

But what happens to quantity and price?

You haven't specified which row's quantity and price you want.
- The first sale has quantity 10.
- The second sale has quantity 20.
- Both occurred in the first year.
You need to return both sales, not just one row per product.

Also, MySQL's ONLY_FULL_GROUP_BY mode will generally reject your query because quantity and price are neither aggregated nor included in the GROUP BY.
The key mistake
You assumed that finding the minimum year would automatically retrieve the corresponding rows.

It doesn't. MIN(year) returns the minimum value, not the complete rows associated with that value.
2. Why do we use a subquery?
Your second query:
SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM Sales
WHERE (product_id, year) IN (
    SELECT product_id, MIN(year)
    FROM Sales
    GROUP BY product_id
);

Let's break it down.
Step 1: Execute the subquery
SELECT product_id, MIN(year)
FROM Sales
GROUP BY product_id;

This identifies the first year for every product.

Output:
product_id	MIN(year)
100	2008
200	2011


Think of this as creating a temporary result containing each product's first year.
Step 2: Match the original rows
WHERE (product_id, year) IN (...)

This checks whether the combination of product_id and year matches a combination returned by the subquery.

For example:
- (100, 2008) → Match ✅
- (100, 2009) → No match ❌
- (200, 2011) → Match ✅
Both sales for product 100 in 2008 are retained.
Step 3: Return the required columns
The final output is:
product_id	first_year	quantity	price
100	2008	10	5000
100	2008	20	5000
200	2011	15	9000


Note: The second row for product 100 is included to illustrate why returning all sales in the first year matters. The actual example in the question contains only one sale for that product in 2008.
3. When should you think of using a subquery?
Here's a practical way to recognize the pattern.

Ask yourself:

"Do I need to calculate something first, and then use that result to filter or retrieve rows from the original table?"

If yes, consider a subquery.
Problem requirement	Typical approach
Find the earliest year for each product	GROUP BY + MIN()
Return all rows from that earliest year	Subquery + WHERE
Find employees earning more than the average salary	Subquery + WHERE
Find the highest salary in each department and return matching employees	Subquery or window function
Find customers who have placed at least five orders	GROUP BY + HAVING


A useful distinction
GROUP BY answers: "What is the minimum year for each product?"

A subquery combined with WHERE answers: "Now that I know each product's minimum year, which original rows match it?"

You can also solve this problem using a join or a window function. A subquery is not mandatory; it is simply a natural approach here.
Remember this pattern
Whenever a question says:
- Find the first or earliest record.
- Find the maximum or minimum value.
- Return the complete row associated with that value.
Consider this two-step strategy:
1. Calculate the required value using an aggregate function.
2. Match that value back to the original table to retrieve the required rows.
That is the main lesson from LeetCode 1070. Your intuition to use MIN(year) was correct; you just needed a second step to retrieve every sale that occurred in that year.
