1661. Average Time of Process per Machine

Table: Activity

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
The table shows the user activities for a factory website.
(machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
machine_id is the ID of a machine.
process_id is the ID of a process running on the machine with ID machine_id.
activity_type is an ENUM (category) of type ('start', 'end').
timestamp is a float representing the current time in seconds.
'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
The `start` timestamp will always be less than or equal to the `end` timestamp for every `(machine_id, process_id)` pair.
It is guaranteed that each (machine_id, process_id) pair has a 'start' and 'end' timestamp.
 

There is a factory website that has several machines, each running one or more processes. Write a solution to find the average time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run on that machine.

The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |
+------------+------------+---------------+-----------+
Output: 
+------------+-----------------+
| machine_id | processing_time |
+------------+-----------------+
| 0          | 0.894           |
| 1          | 0.995           |
| 2          | 1.456           |
+------------+-----------------+
Explanation: 
There are 3 machines running 2 processes each.
Machine 0's average time is ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
Machine 1's average time is ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995
Machine 2's average time is ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456



Code:
select a1.machine_id, round(avg(a2.timestamp - a1.timestamp), 3) as processing_time 
from activity a1
join activity a2 
on a1.machine_id=a2.machine_id
and a1.process_id=a2.process_id
and a1.activity_type = 'start'
and a2.activity_type = 'end'
group by a1.machine_id



Explaination:

Line-by-Line Explanation

Step 1: Self Join

FROM Activity a1
JOIN Activity a2

Hum same Activity table ko do baar use kar rahe hain. Isko Self Join kehte hain.

a1 → Start activity ko represent karega.

a2 → End activity ko represent karega.

Isse hum ek process ka start time aur end time ek hi row mein compare kar sakte hain.

Step 2: Match the Same Machine

ON a1.machine_id = a2.machine_id

Dono records same machine ke hone chahiye.

Example: Machine 0 ka start record, machine 0 ke end record ke saath hi match hoga.

Step 3: Match the Same Process

AND a1.process_id = a2.process_id

Ek machine multiple processes chala sakti hai. Isliye sirf machine ID match karna sufficient nahi hai.

Humein same machine ka same process match karna hai.

Example: Machine 0, process 0 ka start time usi process ke end time se match hoga, process 1 ke end time se nahi.

Step 4: Match Start and End Activities

AND a1.activity_type = 'start'
AND a2.activity_type = 'end'

Ye conditions ensure karti hain ki:

a1.timestamp = Start time

a2.timestamp = End time

Agar hum ye conditions nahi lagayenge, toh start-start ya end-end records bhi match ho sakte hain, jisse calculation incorrect ho sakti hai.
