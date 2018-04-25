/* Example of a JOIN */
SELECT orders.*,
accounts.*
FROM demo.orders
JOIN demo.accounts
ON orders.account_id = accounts.id

/* For example, if we want to pull only the account name and the dates in which
that account placed an order, but none of the other columns, we can do this with
the following query: */

SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/* This query only pulls two columns, not all the information in these two tables.
Alternatively, the below query pulls all the columns from both the accounts and
orders table. */

SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/* And the first query you ran pull all the information from only the orders
table: */

SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/* Try pulling all the data from the accounts table, and all the data from the
orders table. */
SELECT orders.*, accounts.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/* Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and
the website and the primary_poc from the accounts table. */
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;


/* Entity Relationship Diagrams
From the last lesson, you might remember that an entity relationship diagram
(ERD) is a common way to view data in a database. It is also a key element to
understanding how we can pull data from multiple tables. */

/* Provide a table for all web_events associated with account name of Walmart.
There should be three columns. Be sure to include the primary_poc, time of the
event, and the channel for each event. Additionally, you might choose to add a
fourth column to assure only Walmart events were chosen.

Provide a table that provides the region for each sales_rep along with their
associated accounts. Your final table should include three columns: the region
name, the sales rep name, and the account name. Sort the accounts alphabetically
(A-Z) according to account name.

Provide the name for each region for every order, as well as the account name
and the unit price they paid (total_amt_usd/total) for the order. Your final
table should have 3 columns: region name, account name, and unit price. A few
accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing
by zero. */

SELECT a.name, a.primary_poc, w.occurred_at,
       w.channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = ('Walmart');

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;
