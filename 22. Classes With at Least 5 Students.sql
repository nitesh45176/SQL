
596. Classes With at Least 5 Students

Table: Courses

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
 

Write a solution to find all the classes that have at least five students.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Courses table:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
Output: 
+---------+
| class   |
+---------+
| Math    |
+---------+
Explanation: 
- Math has 6 students, so we include it.
- English has 1 student, so we do not include it.
- Biology has 1 student, so we do not include it.
- Computer has 1 student, so we do not include it.


Code:
select class from courses
group by class
having count(student)>=5



Explanation:
1. FROM Courses

Courses table se data fetch karte hain.

2. GROUP BY class

Same class ke students ko ek group mein divide karta hai.

Example:
student	class
A	Math
C	Math
E	Math
B	English
D	Biology


Yahan Math ke saare students ek group mein aa jayenge, English ke alag aur Biology ke alag.

3. COUNT(student)

Har class mein kitne students hain, unki counting karta hai.

Example:
class	COUNT(student)
Math	6
English	1
Biology	1
Computer	1


4. HAVING COUNT(student) >= 5

Sirf un classes ko select karta hai jahan students ki count 5 ya usse zyada hai.

HAVING ka use grouped data par condition lagane ke liye hota hai.
Important Concept: WHERE vs HAVING
- WHERE → Grouping se pehle individual rows ko filter karta hai.
- HAVING → Grouping ke baad groups ko filter karta hai.
Yahan humein har class mein students ki total count check karni hai, isliye HAVING use kiya hai.

Remember: GROUP BY groups banata hai, COUNT() counting karta hai, aur HAVING required groups filter karta hai.
