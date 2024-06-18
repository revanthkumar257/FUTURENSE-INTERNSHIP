select character_length('New york');

select length(       '           india     ');
select length(ltrim(       '           india     '));

select trim(       '           india     ');
select position("fruit" in "orange is a fruit") as name;

select ascii('a');

SELECT CONCAT('Hi', ' ', 'bunny');
SELECT SUBSTRING('Hello, World!', 5, 6);
SELECT LPAD('Hello', 10, '*');

SELECT TRIM(' Hello, World! ');

SELECT DATEDIFF('2023-07-20', '2023-06-15');

SELECT LAST_DAY('2023-05-01');

SELECT ADDDATE(CURRENT_DATE(), INTERVAL 3 MONTH);
SELECT TIME('2023-05-01 12:34:56');


SELECT SQRT(144);
SELECT ROUND(3.14159, 2);

SELECT MIN(price) AS min_price, MAX(price) AS max_price, category 

FROM products 
GROUP BY category;
SELECT POW(2, 5);

SELECT LAST_DAY('2065-07-25') AS fist_day_of_july;

SELECT CURRENT_TIME() AS now;
SELECT ADDDATE('2003-07-25', INTERVAL 7 DAY) AS one_week_later;