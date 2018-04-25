/* Question 1: Which countries have the most Invoices?
Use the Invoice table to determine the countries that have the most invoices.
Provide a table of BillingCountry and Invoices ordered by the number of invoices
for each country. The country with the most invoices should appear first. */
SELECT BillingCountry, COUNT(*) Invoices
FROM Invoice
GROUP BY BillingCountry
ORDER BY Invoices DESC;

/* Question 2: Which city has the best customers?
We would like to throw a promotional Music Festival in the city we made the most
money. Write a query that returns the 1 city that has the highest sum of invoice
totals. Return both the city name and the sum of all invoice totals. */
SELECT BillingCity, SUM(total) InvoiceCityTotal
FROM Invoice
GROUP BY BillingCity
ORDER BY InvoiceCityTotal DESC;

/* The customer who has spent the most money will be declared the best customer.
Build a query that returns the person who has spent the most money. I found the
solution by linking the following three: Invoice, InvoiceLine, and Customer
tables to retrieve this information, but you can probably do it with fewer! */
SELECT Customer.CustomerId, SUM(Invoice.Total) Total_Sum
FROM Invoice
JOIN Customer
ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId
ORDER BY Total_Sum DESC;

/* QUIZ 2 */

/* Use your query to return the email, first name, last name, and Genre of all
Rock Music listeners. Return your list ordered alphabetically by email address
starting with A. Can you find a way to deal with duplicate email addresses so no
one receives multiple emails? */
SELECT DISTINCT G.Name, C.Email, C.FirstName, C.LastName
FROM Customer C
JOIN Invoice I
ON C.CustomerID = I.CustomerID
JOIN InvoiceLine IL
ON I.InvoiceID = IL.InvoiceLineID
JOIN Track T
ON IL.TrackID = T.TrackID
JOIN Genre G
ON T.GenreID = G.GenreID
Where G.Name IN ('Rock')

/* Let's invite the artists who have written the most rock music in our dataset.
Write a query that returns the Artist name and total track count of the top 10
rock bands.
You will need to use the Genre, Track , Album, and Artist tables. */
SELECT A.ArtistID, A.Name, COUNT(T.TrackID) Songs
FROM Artist A
JOIN Album AL
ON A.ArtistID = AL.ArtistID
JOIN Track T
ON AL.AlbumID = T.AlbumID
JOIN Genre G
ON T.GenreID = G.GenreID
Where G.Name IN ('Rock')
GROUP BY A.Name
ORDER BY Songs DESC
LIMIT 10;

/* First, find which artist has earned the most according to the InvoiceLines?

Now use this artist to find which customer spent the most on this artist.

For this query, you will need to use the Invoice, InvoiceLine, Track, Customer,
Album, and Artist tables.

Notice, this one is tricky because the Total spent in the Invoice table might
not be on a single product, so you need to use the InvoiceLine table to find out
how many of each product was purchased, and then multiply this by the price for
each artist. */

SELECT A.Name, SUM(T.UnitPrice * IL.Quantity) Earnings
FROM Artist A
JOIN Album AL
ON A.ArtistID = AL.ArtistID
JOIN Track T
ON AL.AlbumID = T.AlbumID
JOIN InvoiceLine IL
ON T.TrackID = IL.TrackID
GROUP BY A.Name
Order BY Earnings DESC

/* Solution Continued with top Purchaser
Then, the top purchasers are shown in the table below. The customer with the
highest total invoice amount is customer 55, Mark Taylor. */
SELECT A.Name, C.CustomerID, C.FirstName, C.LastName, SUM(T.UnitPrice * IL.Quantity) Earnings
FROM Artist A
JOIN Album AL
ON A.ArtistID = AL.ArtistID
JOIN Track T
ON AL.AlbumID = T.AlbumID
JOIN InvoiceLine IL
ON T.TrackID = IL.TrackID
JOIN Invoice I
ON IL.InvoiceID = I.InvoiceID
JOIN Customer C
ON I.CustomerID = C.CustomerID
Where A.Name = 'Iron Maiden'
GROUP BY C.CustomerID
Order BY Earnings DESC
