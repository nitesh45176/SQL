1280. Students and Examinations

Table: Students

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.
 

Table: Subjects

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.
 

Table: Examinations

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
 

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by student_id and subject_name.

The result format is in the following example.

 

Example 1:

Input: 
Students table:
+------------+--------------+
| student_id | student_name |
+------------+--------------+
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |
+------------+--------------+
Subjects table:
+--------------+
| subject_name |
+--------------+
| Math         |
| Physics      |
| Programming  |
+--------------+
Examinations table:
+------------+--------------+
| student_id | subject_name |
+------------+--------------+
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |
+------------+--------------+
Output: 
+------------+--------------+--------------+----------------+
| student_id | student_name | subject_name | attended_exams |
+------------+--------------+--------------+----------------+
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |
+------------+--------------+--------------+----------------+
Explanation: 
The result table should contain all students and all subjects.
Alice attended the Math exam 3 times, the Physics exam 2 times, and the Programming exam 1 time.
Bob attended the Math exam 1 time, the Programming exam 1 time, and did not attend the Physics exam.
Alex did not attend any exams.
John attended the Math exam 1 time, the Physics exam 1 time, and the Programming exam 1 time.



Code:
select s.student_id , s.student_name , sub.subject_name, count(e.student_id) as attended_exams
from students s
cross join subjects sub
left join examinations e
on s.student_id=e.student_id
and e.subject_name=sub.subject_name
group by s.student_id , s.student_name , sub.subject_name
order by s.student_id , s.student_name


EXPLAINATION:
1. Why cross join?
kyuki ques me given hai :- Each student from the Students table takes every course from the Subjects table.
Jb hume do tables ke saare comibnations of row and column chahiye hote h to we use cross join(mtlb dono tables ka sara data)

2. Why left join ?
cross join krne ke baad jo data ayega vo to hume pura chahiye hi fir usko hum left join krenge examinations table se taki examinations table ke matching records
display hojaye aur saath saath vo record bhi jo match nhi kr rhe h taki vo use ho skte count ko 0 krne me

3. group by?
koi bhi aggregation function (for eg:count,min, max) use krte hai to group by krte hai 
PR GROUP BY KRTE KISSE HAI?? aggregation function se pehle jo bhi aa rha h usse
for eg: 
select s.student_id , s.student_name , sub.subject_name, count(e.student_id) as attended_exams

isme count se pehle
  s.student_id , s.student_name , sub.subject_name  
ye aa rha h to isse group by kr denge

4. order by?
kyuki ques me given tha


