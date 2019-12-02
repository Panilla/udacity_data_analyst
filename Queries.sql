/* Query to find my closest city */
SELECT c.country, c.city
FROM city_list c
WHERE c.country = 'United States'
ORDER BY c.city


/* Query to pull temperature data for Detroit */
SELECT c.year, c.country, c.city, c.avg_temp
FROM city_data c
WHERE c.city = 'Detroit'


/* Query to pull global temperature data */
SELECT g.year, g.avg_temp
FROM global_data g
