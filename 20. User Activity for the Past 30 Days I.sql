1141. User Activity for the Past 30 Days I
Solved
Easy
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Activity

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
This table may have duplicate rows.
The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.
 

Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.

Return the result table in any order.

The result format is in the following example.

Note: Any activity from ('open_session', 'end_session', 'scroll_down', 'send_message') will be considered valid activity for a user to be considered active on a day.

 

Example 1:

Input: 
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output: 
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 
Explanation: Note that we do not care about days with zero active users.


Code:
select
activity_date as day,
count(distinct user_id) as active_users
from activity
where activity_date between date_sub('2019-07-27', interval 29 day) and '2019-07-27'
group by day


Explanation:
1. where activity_date between date_sub('2019-07-27', interval 29 day) and '2019-07-27'

DATE_SUB('2019-07-27', INTERVAL 29 DAY)
- DATE_SUB() kisi date mein se days subtract karta hai.
- Yahan 2019-07-27 se 29 days minus honge.
- Result: 2019-06-28.
BETWEEN start_date AND end_date

Isliye query 2019-06-28 se 2019-07-27 tak ka data select karegi.

29 days minus kyun kiye, 30 kyun nahi?  (kyuki ques me inclusion likha hai)

Kyunki start date aur end date dono include hain.
- June 28–30 = 3 days
- July 1–27 = 27 days
- Total = 30 days
Yaad rakho: DATE_SUB() date se time subtract karne ke liye use hota hai, aur INTERVAL 29 DAY batata hai ki 29 days subtract karne hain.
