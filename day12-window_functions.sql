-- windows are nothing but partitions created by partition by clause
-- windows Functions: fn applied to the windows
-- Types of window functions :
    -- 1.aggregate functions                sum(), avg(), max(), min(), count()
    -- 2.rank functions                     rank() , dense_rank(), row number()
    -- 3.value functions                    lead(), lag(), first_value(), last_value(), nth_value()


# Window Functions
/*
1. divide the result set into subsets/partitions and 
2. apply window functions to each partition 
3. written in select clause and derive new columns
*/

# Syntax
/*
	SELECT 
		column1, column2,
		function(aggregation) OVER (PARTITION BY ... ORDER BY...)
	FROM table1
    	WHERE condition;
*/


Use day3;
Select * From myemp;
# Window Functions:

-- 1. ROW_NUMBER() 
-- :Assigns a sequential integer to every row within its partition

Select
     Dep_ID, EMP_ID,
Row_Number() Over (Partition by dep_ID) AS  _Row_Number
From myemp;


-- 2. RANK()
-- :Assigns a rank to every row within its partition
-- :Assigns the same rank to the rows with equal values
-- :There is a gap in the sequence of ranked values for every repeated value in the ordered sequence

Select 
      Dep_ID, EMP_ID, Salary,
Rank() Over(Partition By Dep_ID order by Salary Desc) as _Rank
From myemp;


-- 3. DENSE_RANK()
-- :Assigns a rank to every row within its partition
-- :Assigns the same rank to the rows with equal values
-- :There is no gap in the sequence of ranked values 
Select 
      Dep_ID, EMP_ID, Salary,
Row_Number() Over (Partition by dep_ID) AS  _Row_Number,
Rank() Over(Partition By Dep_ID order by Salary Desc) as _Rank,
Dense_Rank() Over(Partition By Dep_ID order by Salary Desc) as _DRank
From myemp;


-- 4. LEAD()
-- :Returns the value of the Nth row after the current row in a partition. 
-- :It returns NULL if no subsequent row exists.
Use classicmodels;
Select * from orders;

Select
    CustomerNumber, orderNumber, orderDate,
    lead(orderDate,1) over(partition by CustomerNumber order by orderdate asc) as  next_order_date
from orders;


-- 5. LAG()
-- :Returns the value of the Nth row before the current row in a partition. 
-- :It returns NULL if no preceding row exists.

Select
    CustomerNumber, orderNumber, orderDate,
    lag(orderDate,1) over(partition by CustomerNumber order by orderdate asc) as  prev_order_date
from orders;

Select
    CustomerNumber, orderNumber, orderDate,
    lead(orderDate,1) over(partition by CustomerNumber order by orderdate asc) as  next_order_date,
    lag(orderDate,1) over(partition by CustomerNumber) as  prev_order_date
from orders;

-- 6. FIRST_VALUE()
-- :Returns the value of the specified expression with respect to the first row in the window frame.

Select * from orders;

Select 
     CustomerNumber, orderNumber, orderDate,
First_value(orderDate) over(partition by CustomerNumber Order by orderDate) _first_order_date
from orders;



-- 7. LAST_VALUE()
-- :Returns the value of the specified expression with respect to the last row in the window frame.

Select 
     CustomerNumber, orderNumber, orderDate,
last_value(orderDate) over(partition by CustomerNumber) _last_order_date
from orders;


Select 
     CustomerNumber, orderNumber, orderDate,
First_value(orderDate) over(partition by CustomerNumber) _first_order_date,
last_value(orderDate) over(partition by CustomerNumber) _last_order_date
from orders;







