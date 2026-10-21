197. Rising Temperature

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).


Code:

1.
select today.id 
from weather yesterday 
join weather today
on datediff(today.recordDate , yesterday.recordDate) = 1
and today.temperature > yesterday.temperature


2.
select today.id 
from weather yesterday , weather today
where datediff(today.recordDate , yesterday.recordDate) = 1
and today.temperature > yesterday.temperature


  Explaination:

  1. Logic samjho
Humein un days ki id find karni hai jinki temperature previous day se zyada hai.

Iske liye hum Weather table ko khud ke saath join karte hain. Isko Self Join kehte hain.
  
2. Important points
- weather yesterday → Previous day ka data.
- weather today → Current day ka data.
- DATEDIFF(today.recordDate, yesterday.recordDate) = 1 → Dono dates ke beech exactly 1 day ka difference hona chahiye.
- today.temperature > yesterday.temperature → Aaj ka temperature kal se zyada hona chahiye.
- SELECT today.id → Sirf current day ki ID return karni hai.
  
3. Dono approaches ka difference
Approach 1: Explicit JOIN
FROM weather yesterday
JOIN weather today
ON DATEDIFF(today.recordDate, yesterday.recordDate) = 1
AND today.temperature > yesterday.temperature


JOIN ... ON se clearly specify karte hain ki tables ko kis condition par match karna hai.

Approach 2: Implicit JOIN
FROM weather yesterday, weather today
WHERE DATEDIFF(today.recordDate, yesterday.recordDate) = 1
AND today.temperature > yesterday.temperature


Comma se dono tables lete hain aur matching conditions WHERE mein likhte hain.

Dono queries is problem ke liye same result deti hain. Modern SQL mein Approach 1 prefer karo, kyunki join conditions aur filtering conditions ko alag rakhna easier hota hai.
  
4. Dry run
Yesterday	Today	Temperature change	Result
Jan 1: 10°	Jan 2: 25°	Increased	ID 2
Jan 2: 25°	Jan 3: 20°	Decreased	Exclude
Jan 3: 20°	Jan 4: 30°	Increased	ID 4
  
Yaad rakhna: Self Join tab useful hota hai jab same table ki rows ko aapas mein compare karna ho, jaise yesterday vs today.
