/*Aggregation Questions
Use the SQL environment below to find the solution for each of the following
questions. If you get stuck or want to check your answers, you can find the
answers at the top of the next concept.

Find the total amount of poster_qty paper ordered in the orders table.

Find the total amount of standard_qty paper ordered in the orders table.

Find the total dollar amount of sales using the total_amt_usd in the orders
table.

Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each
order in the orders table. This should give a dollar amount for each order in
the table.

Find the standard_amt_usd per unit of standard_qty paper. Your solution should
use both an aggregation and a mathematical operator. */

SELECT SUM(poster_qty) AS total_poster_sales
FROM orders;


SELECT SUM(standard_qty) AS total_standard_sales
FROM orders;


SELECT SUM(total_amt_usd) AS total_dollar_sales
FROM orders;


SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;


SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

/* Questions: MIN, MAX, & AVERAGE
Use the SQL environment below to assist with answering the following questions.
Whether you get stuck or you just want to double check your solutions, my
answers can be found at the top of the next concept. */


/* Solutions: MIN, MAX, and AVERAGE
When was the earliest order ever placed? */
SELECT MIN(occurred_at)
FROM orders;

/* Try performing the same query as in question 1 without using an aggregation
function. */

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

/* When did the most recent (latest) web_event occur? */
SELECT MAX(occurred_at)
FROM web_events;

/* Try to perform the result of the previous query without using an aggregation
function. */
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

/* Find the mean (AVERAGE) amount spent per order on each paper type, as well as
the mean amount of each paper type purchased per order. Your final answer should
have 6 values - one for each paper type for the average number of sales, as well
as the average amount.*/
SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss,
           AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd,
           AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;

/* Via the video, you might be interested in how to calculate the MEDIAN. Though
this is more advanced than what we have covered so far try finding - what is the
MEDIAN total_usd spent on all orders? Note, this is more advanced than the
topics we have covered thus far to build a general solution, but we can hard
code a solution in the following way.*/
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

/* Since there are 6912 orders - we want the average of the 3457 and 3456 order
amounts when ordered. This is the average of 2483.16 and 2482.55. This gives the
 median of 2482.855. This obviously isn't an ideal way to compute. If we obtain
 new orders, we would have to change the limit. SQL didn't even calculate the
 median for us. The above used a SUBQUERY, but you could use any method to find
 the two necessary values, and then you just need the average of them. */



 /* GROUP BY Note
Now that you have been introduced to JOINs, GROUP BY, and aggregate functions,
the real power of SQL starts to come to life. Try some of the below to put your
skills to the test!

Questions: GROUP BY
Use the SQL environment below to assist with answering the following questions.
Whether you get stuck or you just want to double check your solutions, my answers
can be found at the top of the next concept.

One part that can be difficult to recognize is when it might be easiest to use
an aggregate or one of the other SQL functionalities. Try some of the below to
see if you can differentiate to find the easiest solution.

Solutions: GROUP BY
Which account (by name) placed the earliest order? Your solution should have the
account name and the date of the order. */

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

/*Find the total sales in usd for each account. You should include two columns
- the total sales for each company's orders in usd and the company name. */

SELECT a.name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;

/* Via what channel did the most recent (latest) web_event occur, which account
was associated with this web_event? Your query should return only three values
- the date, channel, and account name. */
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

/* Find the total number of times each type of channel from the web_events was
used. Your final table should have two columns - the channel and the number of
times the channel was used. */
SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel

/*Who was the primary contact associated with the earliest web_event? */
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

/* What was the smallest order placed by each account in terms of total usd.
Provide only two columns - the account name and the total usd. Order from
smallest dollar amounts to largest. */
SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;
/*Sort of strange we have a bunch of orders with no dollars. We might want to
look into those. */

/* Find the number of sales reps in each region. Your final table should have
two columns - the region and the number of sales_reps. Order from fewest reps to
most reps. */
SELECT r.name, COUNT(*) num_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;


/* Questions: GROUP BY Part II
Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

Solutions: GROUP BY Part II

For each account, determine the average amount of each type of paper they
purchased across their orders. Your result should have four columns - one for
the account name and one for the average spent on each of the paper types. */
SELECT a.name, AVG(o.standard_qty) avg_stand, AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

/*For each account, determine the average amount spent per order on each paper
type. Your result should have four columns - one for the account name and one
for the average amount spent on each paper type. */
SELECT a.name, AVG(o.standard_amt_usd) avg_stand, AVG(o.gloss_amt_usd) avg_gloss, AVG(o.poster_amt_usd) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

/* Determine the number of times a particular channel was used in the web_events
table for each sales rep. Your final table should have three columns - the name
of the sales rep, the channel, and the number of occurrences. Order your table
with the highest number of occurrences first. */
SELECT s.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

/*Determine the number of times a particular channel was used in the web_events
table for each region. Your final table should have three columns - the region
name, the channel, and the number of occurrences. Order your table with the
highest number of occurrences first.*/
SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;


/* Questions: DISTINCT
Use the SQL environment below to assist with answering the following questions.
Whether you get stuck or you just want to double check your solutions, my
answers can be found at the top of the next concept.

Solutions: DISTINCT
Use DISTINCT to test if there are any accounts associated with more than one
region.

The below two queries have the same number of resulting rows (351), so we know
that every account is associated with only one region. If each account was
associated with more than one region, the first query should have returned more
rows than the second query. */

SELECT a.id as "account id", r.id as "region id",
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;
/* and */
SELECT DISTINCT id, name
FROM accounts;

/* Have any sales reps worked on more than one account?

Actually all of the sales reps have worked on more than one account. The fewest
number of accounts any sales rep works on is 3. There are 50 sales reps, and
they all have more than one account. Using DISTINCT in the second query assures
that all of the sales reps are accounted for in the first query. */

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;
/* and */
SELECT DISTINCT id, name
FROM sales_reps;


/* Questions: HAVING
Use the SQL environment below to assist with answering the following questions.
Whether you get stuck or you just want to double check your solutions, my
answers can be found at the top of the next concept.

Solutions: HAVING
How many of the sales reps have more than 5 accounts that they manage? */

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;
/* and technically, we can get this using a SUBQUERY as shown below. This same
logic can be used for the other queries, but this will not be shown. */
SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
     FROM accounts a
     JOIN sales_reps s
     ON s.id = a.sales_rep_id
     GROUP BY s.id, s.name
     HAVING COUNT(*) > 5
     ORDER BY num_accounts) AS Table1;

/*How many accounts have more than 20 orders? */
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

/* Which account has the most orders? */
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

/* How many accounts spent more than 30,000 usd total across all orders?*/
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

/* How many accounts spent less than 1,000 usd total across all orders? */
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;

/* Which account has spent the most with us? */
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;

/* Which account has spent the least with us? */
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;

/* Which accounts used facebook as a channel to contact customers more than 6
times? */
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

/* Which account used facebook most as a channel? */
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;

/* Which channel was most frequently used by most accounts? */
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;
/* All of the top 10 are direct. */


/* Questions: Working With DATEs
Use the SQL environment below to assist with answering the following questions.
Whether you get stuck or you just want to double check your solutions, my
answers can be found at the top of the next concept.

Solutions: Working With DATEs
Find the sales in terms of total dollars for all orders in each year, ordered
from greatest to least. Do you notice any trends in the yearly sales totals? */


 SELECT DATE_PART('year', occurred_at) ord_year,  SUM(total_amt_usd) total_spent
 FROM orders
 GROUP BY 1
 ORDER BY 2 DESC;
 /* When we look at the yearly totals, you might notice that 2013 and 2017 have
 much smaller totals than all other years. If we look further at the monthly
 data, we see that for 2013 and 2017 there is only one month of sales for each
 of these years (12 for 2013 and 1 for 2017). Therefore, neither of these are
 evenly represented. Sales have been increasing year over year, with 2016 being
 the largest sales to date. At this rate, we might expect 2017 to have the
 largest sales. */


/* Which month did Parch & Posey have the greatest sales in terms of total
dollars? Are all months evenly represented by the dataset?

In order for this to be 'fair', we should remove the sales from 2013 and 2017.
For the same reasons as discussed above. */

SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;
/* The greatest sales amounts occur in December (12). */

/*Which year did Parch & Posey have the greatest sales in terms of total number
of orders? Are all years evenly represented by the dataset? */

SELECT DATE_PART('year', occurred_at) ord_year,  COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;
/*Again, 2016 by far has the most amount of orders, but again 2013 and 2017 are
not evenly represented to the other years in the dataset.*/


/*Which month did Parch & Posey have the greatest sales in terms of total number
of orders? Are all months evenly represented by the dataset? */
SELECT DATE_PART('month', occurred_at) ord_month, COUNT(*) total_sales
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;
/* December still has the most sales, but interestingly, November has the second
most sales (but not the most dollar sales. To make a fair comparison from one
month to another 2017 and 2013 data were removed. */

/*In which month of which year did Walmart spend the most on gloss paper in
terms of dollars? */
SELECT DATE_TRUNC('month', o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
/* May 2016 was when Walmart spent the most on gloss paper. */


/* Questions: CASE
Use the SQL environment below to assist with answering the following questions.
Whether you get stuck or you just want to double check your solutions, my
answers can be found at the top of the next concept.

Solutions: CASE
We would like to understand 3 different branches of customers based on the
amount associated with their purchases. The top branch includes anyone with a
Lifetime Value (total sales of all orders) greater than 200,000 usd. The second
branch is between 200,000 and 100,000 usd. The lowest branch is anyone under
100,000 usd. Provide a table that includes the level associated with each
account. You should provide the account name, the total sales of all orders for
the customer, and the level. Order with the top spending customers listed
first. */

SELECT a.name, SUM(total_amt_usd) total_spent,
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY 2 DESC;

/* We would now like to perform a similar calculation to the first, but we want
to obtain the total amount spent by customers only in 2016 and 2017. Keep the
same levels as in the previous question. Order with the top spending customers
listed first. */
SELECT a.name, SUM(total_amt_usd) total_spent,
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31'
GROUP BY 1
ORDER BY 2 DESC;

/*We would like to identify top performing sales reps, which are sales reps
associated with more than 200 orders. Create a table with the sales rep name,
the total number of orders, and a column with top or not depending on if they
have more than 200 orders. Place the top sales people first in your final
table. */
SELECT s.name, COUNT(*) num_ords,
     CASE WHEN COUNT(*) > 200 THEN 'top'
     ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;
/* It is worth mentioning that this assumes each name is unique - which has been
done a few times. We otherwise would want to break by the name and the id of the
table. */

/* The previous didn't account for the middle, nor the dollar amount associated
with the sales. Management decides they want to see these characteristics
represented as well. We would like to identify top performing sales reps, which
are sales reps associated with more than 200 orders or more than 750000 in total
sales. The middle group has any rep with more than 150 orders or 500000 in
sales. Create a table with the sales rep name, the total number of orders, total
sales across all orders, and a column with top, middle, or low depending on this
criteria. Place the top sales people based on dollar amount of sales first in
your final table. */
SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent,
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;

/* You might see a few upset sales people by this criteria!
