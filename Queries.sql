use airline_data;

show tables from airline_data;

alter table indigo_reviews rename column Vade_Senti to Vader_Senti;

alter table indigo_reviews add column datess date;
update indigo_reviews
set datess=STR_TO_DATE(date,"%d-%m-%Y");
alter table indigo_reviews drop column Date;
alter table indigo_reviews rename column datess to Date;
alter table indigo_reviews modify column Date date after Review;

select count(*) from united_reviews where Stars=10;

alter table united_reviews add column datess date;
update united_reviews
set datess=STR_TO_DATE(date,"%d-%m-%Y");
alter table united_reviews drop column Date;
alter table united_reviews rename column datess to Date;
alter table united_reviews modify column Date date after Review; 

select * from ia_expense;
select * from ua_expense;
select * from ia_revenue;
select * from ua_revenue;
select * from flight_oper;
select * from ia_fleet;
select * from indigo_reviews;
select * from revenue_data;
select * from ua_fleet;
select * from united_reviews;


# 1.What is the average star rating for United Airlines reviews by year and country?
SELECT 
    YEAR(Date) AS Year,
    Country,
    ROUND(AVG(Stars), 1) AS Avg_Rating
FROM
    united_reviews
GROUP BY Year , Country;

# 2.Which countries have the lowest average ratings for United Airlines?
SELECT 
    Country, ROUND(AVG(Stars), 1) AS Avg_Rating
FROM
    united_reviews
GROUP BY Country
ORDER BY Avg_Rating ASC
LIMIT 5;

# 3.What percentage of reviews mention positive vs negative experiences for indigo airlines ?
SELECT 
    Hug_Senti,
    CONCAT(ROUND(COUNT(Hug_senti) * 100 / (SELECT 
                            COUNT(*)
                        FROM
                            indigo_reviews),
                    2),
            '%') AS Percentage
FROM
    indigo_reviews
GROUP BY Hug_Senti;
 
 # 4.What are the peak hours for Indigo flights?
 SELECT 
    Airline, Time, SUM(Tot_Flights) AS Total_Flights
FROM
    flight_oper
WHERE
    Airline = 'Indigo'
GROUP BY Time
ORDER BY Total_Flights DESC
LIMIT 5;

 # 5.What are the peak hours for United flights?
 SELECT 
    Airline, Time, SUM(Tot_Flights) AS Total_Flights
FROM
    flight_oper
WHERE
    Airline = 'United Airlines'
GROUP BY Time
ORDER BY Total_Flights DESC
LIMIT 5;
 
 # 6.Which country has the highest number of reviews?
 SELECT 
    COUNT(review) AS No_Of_Reviews, Country
FROM
    indigo_reviews
GROUP BY Country
ORDER BY No_Of_Reviews DESC
LIMIT 3;

# 7.On which year did Indigo receive the most negative reviews based on HuggingFace labels?
SELECT 
    YEAR(Date) AS Review_Year,
    COUNT(*) AS No_of_Negative_Reviews
FROM
    indigo_reviews
WHERE
    Hug_Senti = 'Negative'
GROUP BY YEAR(Date)
ORDER BY No_of_Negative_Reviews DESC
LIMIT 3;

# 8.What is the distribution of star ratings (i.e., how many 1-star, 2-star, etc.)?alter
SELECT 
    Stars, COUNT(*) AS No_Of_Stars
FROM
    united_reviews
GROUP BY Stars
ORDER BY Stars;

# 9.How many aircrafts are there for each haul_type?
SELECT 
    Haul_Type, SUM(Count) AS No_Of_Aircrafts
FROM
    ia_fleet
GROUP BY Haul_Type
ORDER BY No_Of_Aircrafts DESC;

# 10.What is the average age of aircrafts for each haul_type?
SELECT 
    Haul_Type, ROUND(AVG(Avg_Age), 1) AS Avg_Age
FROM
    ia_fleet
GROUP BY Haul_Type
ORDER BY Avg_Age;

# 11.List all aircrafts that are older than 10 years ?
SELECT 
    Model_Name, Avg_Age
FROM
    ua_fleet
WHERE
    Avg_Age > 10;

# 12.For each haul type, identify the model with the highest count of aircraft?
Select Haul_Type,Model_Name,Count from 
(select Haul_Type,Model_Name,Count,row_number() 
over (partition by Haul_Type order by Count desc) as rn from ia_fleet )
 as subquery where rn=1;

# 13.How many flights were operated by each aircraft type?
SELECT 
    Airline, Flight_Type, SUM(Tot_Flights) AS Total_Flights
FROM
    flight_oper
GROUP BY Airline , Flight_Type
ORDER BY Airline , Total_Flights;

# 14.What is the average number of domestic and international flights operated by each airline per hour?
SELECT 
    Airline,
    ROUND(AVG(CASE
                WHEN Flight_Type = 'Domestic' THEN Tot_Flights
                ELSE 0
            END),
            1) AS Avg_Domestic_Flights,
    ROUND(AVG(CASE
                WHEN Flight_Type = 'International' THEN Tot_Flights
                ELSE 0
            END),
            1) AS Avg_International_Flights
FROM
    flight_oper
GROUP BY Airline; 

# 15.Which airline has the highest total number of international flights, and what is the total count?
SELECT 
    Airline,
    SUM(CASE
        WHEN Flight_Type = 'International' THEN Tot_Flights
        ELSE 0
    END) AS Total_Flights
FROM
    flight_oper
GROUP BY Airline
ORDER BY Total_Flights DESC
LIMIT 1;

# 16.Calculate the average star rating for each country, but only include countries with more than 10 reviews.
SELECT 
    Country, ROUND(AVG(Stars), 0) AS Avg_Stars
FROM
    _reviews
GROUP BY Country
HAVING COUNT(Country) > 10
ORDER BY Avg_Stars DESC;

# 17.Find the most common day of the week for reviews and the average star rating on that day.
SELECT 
    DAYNAME(Date) AS Day_Of_Week,
    ROUND(AVG(Stars), 0) AS Avg_Stars
FROM
    united_reviews
GROUP BY Day_Of_Week
ORDER BY Avg_Stars DESC
LIMIT 1;

# 18.For each country, identify the percentage of reviews that are classified as both "Negative" by VADER_Polarity and have a star rating of 3 or less.
SELECT 
    Country,
    CONCAT(ROUND((SUM(CASE
                        WHEN Vader_Senti = 'Negative' AND Stars <= 3 THEN 1
                        ELSE 0
                    END) / COUNT(*)) * 100,
                    2),
            '%') AS Negative_Percentage
FROM
    indigo_reviews
GROUP BY Country;

# 19.Rank each review within its country based on the star rating. Return the review text, date, star rating, and the calculated rank.
Select Country,Review,Date,Stars,Rank_No from 
(select Country,Review,Date,Stars,row_number() 
over (partition by Country order by Stars desc ) as Rank_No 
from indigo_reviews) as sub_query order by Country,Rank_No ;

#. 20.Count the number of Positive, Negative, and Neutral reviews per country based on the Reviews.
SELECT 
    Country,
    SUM(CASE
        WHEN
            Vader_Senti = 'Positive'
                OR Hug_Senti = 'Positive'
        THEN
            1
        ELSE 0
    END) AS Positive_Review,
    SUM(CASE
        WHEN
            Vader_Senti = 'Negative'
                OR Hug_Senti = 'Negative'
        THEN
            1
        ELSE 0
    END) AS Negative_Review,
    SUM(CASE
        WHEN Vader_Senti = 'Neutral' THEN 1
        ELSE 0
    END) AS Neutral_Review
FROM
    united_reviews
GROUP BY Country;
