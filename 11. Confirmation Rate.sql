1934. Confirmation Rate

Table: Signups

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the column of unique values for this table.
Each row contains information about the signup time for the user with ID user_id.
 

Table: Confirmations

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
 

The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write a solution to find the confirmation rate of each user.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Signups table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |
+---------+---------------------+
Confirmations table:
+---------+---------------------+-----------+
| user_id | time_stamp          | action    |
+---------+---------------------+-----------+
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |
+---------+---------------------+-----------+
Output: 
+---------+-------------------+
| user_id | confirmation_rate |
+---------+-------------------+
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |
+---------+-------------------+
Explanation: 
User 6 did not request any confirmation messages. The confirmation rate is 0.
User 3 made 2 requests and both timed out. The confirmation rate is 0.
User 7 made 3 requests and all were confirmed. The confirmation rate is 1.
User 2 made 2 requests where one was confirmed and the other timed out. The confirmation rate is 1 / 2 = 0.5.


Code:
select s.user_id ,round(avg(if( c.action ='confirmed' , 1,0)), 2) as confirmation_rate 
from signups s
left join confirmations c
on s.user_id=c.user_id
group by user_id


Explanation of LeetCode 1934 — Confirmation Rate
Your query is correct for this problem. Let's understand it step by step.
1. Your code
SELECT s.user_id,
       ROUND(AVG(IF(c.action = 'confirmed', 1, 0)), 2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY user_id;


2. How it works
Step 1: FROM Signups s

We start with the Signups table because we need to return the confirmation rate for every user, including those who never requested confirmation.

Step 2: LEFT JOIN Confirmations c
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id


Matches each user with their confirmation requests.

For example, user 3 has two requests, while user 6 has none. A LEFT JOIN still keeps user 6 in the result, with NULL values for the confirmation columns.

Step 3: IF(c.action = 'confirmed', 1, 0)

This converts each request into a numeric value:
action	IF() result
confirmed	1
timeout	0
NULL	0

Step 4: AVG()
AVG(IF(c.action = 'confirmed', 1, 0))


Calculates the average of those values, which equals:
\[
\text{Confirmation Rate} =
\frac{\text{Confirmed requests}}{\text{Total requests}}
\]

For example, user 2 has one confirmed request and one timeout:
\[
\frac{1+0}{2}=0.5
\]

Step 5: ROUND(..., 2)

Rounds the result to two decimal places, such as 0.50 or 1.00.

Step 6: GROUP BY user_id

Groups all requests belonging to the same user so that AVG() calculates one confirmation rate per user.
3. Dry run
User	Actions	Values	Average
3	timeout, timeout	0, 0	0.00
7	confirmed, confirmed, confirmed	1, 1, 1	1.00
2	confirmed, timeout	1, 0	0.50
6	No requests	0	0.00

4. Important SQL concepts
- LEFT JOIN — preserves every user from Signups.
- IF() — converts a condition into 1 or 0.
- AVG() — calculates the proportion of confirmed requests.
- ROUND() — rounds the rate to two decimal places.
- GROUP BY — calculates one result per user.
Why does your query return 0 for user 6? Because IF(NULL = 'confirmed', 1, 0) returns 0 in MySQL. Therefore, AVG() calculates AVG(0) = 0. You don't need IFNULL() for this particular solution.
