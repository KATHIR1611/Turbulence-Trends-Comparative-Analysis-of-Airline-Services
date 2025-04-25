# Turbulence & Trends: Comparative Analysis of Airline Services

## Overview

This project aims to analyze and compare **IndiGo Airlines** and **United Airlines**, both operating under the **Star Alliance** umbrella. By leveraging customer reviews, fleet data, financial information, and advanced sentiment analysis techniques, this project provides insights into airline performance and customer experience. The project was developed in the Deepnote environment, which offers real-time collaboration and seamless integration with data science tools for efficient analysis and visualization.

## Objectives

- Scrape over 500 customer reviews for both IndiGo and United Airlines from [AirlineQuality.com](https://www.airlinequality.com).
- Perform sentiment analysis using **VADER** and **Hugging Face Transformers** to understand customer sentiment.
- Analyze airline fleet data, operational metrics, and financial records.
- Create interactive and insightful dashboards using **Power BI**.
- Provide SQL-driven insights on peak flight times, rating trends by country, and more.

## Tools & Technologies

- **Python** (for web scraping and sentiment analysis)
  - BeautifulSoup
  - Requests
  - Pandas
  - VADER
  - Hugging Face Transformers
- **MySQL** (for structuring and storing data)
- **Power BI** (for data visualization)
- **Jupyter/Deepnote** (for project development)

## Data Sources

- **Airline reviews**: [AirlineQuality.com](https://www.airlinequality.com)
- **Fleet data**: Collected from publicly available airline data sources
- **Financial records**: Sourced from public airline financial reports

## Features

1. **Web Scraping**:
   - Scraped 500+ customer reviews for IndiGo and United Airlines.
   - Cleaned and transformed review data for analysis.
  
2. **Sentiment Analysis**:
   - Applied VADER and Hugging Face models to analyze sentiment (positive, negative, neutral).
   - Analyzed the relationship between sentiment and factors like fleet age and flight frequency.

3. **Database Structure**:
   - Structured data in MySQL for easy querying and analysis.
   - Key tables include `Reviews`, `Airlines`, `Fleet`, and `Financials`.

4. **Power BI Dashboards**:
   - Developed visualizations showcasing sentiment trends, fleet comparisons, financial performance, and customer review analysis.
   - Key dashboards include:
     - **Sentiment Breakdown** by airline and country.
     - **Fleet Analysis** by aircraft age, fleet size, and more.
     - **Rating Trends** and **Country-wise Distribution** of Reviews.

5. **SQL Insights**:
   - Extracted SQL-driven insights like peak flight times, rating trends, and country-based review distribution.
   - Country-wise analysis of negative reviews.

## Project Visuals

![](https://github.com/KATHIR1611/Turbulence-Trends-Comparative-Analysis-of-Airline-Services/blob/main/IndiGo%20Airlines/Screenshot%202025-04-25%20182434.png)

![](https://github.com/KATHIR1611/Turbulence-Trends-Comparative-Analysis-of-Airline-Services/blob/main/IndiGo%20Airlines/Screenshot%202025-04-25%20183447.png)

![](https://github.com/KATHIR1611/Turbulence-Trends-Comparative-Analysis-of-Airline-Services/blob/main/IndiGo%20Airlines/Screenshot%202025-04-25%20183545.png)


## Key Insights

- **Sentiment Breakdown**: 
  - Comparison of sentiment trends between IndiGo and United Airlines.
  - Analysis of customer feedback by country and rating.

- **Fleet Comparison**:
  - Analysis of fleet size, aircraft age, and their correlation with customer reviews.

- **SQL Insights**:
  - Peak flight times and trends in ratings over time.
  - Distribution of negative reviews based on countries.

## Future Improvements

- Expand the dataset by scraping more reviews and including other airlines.
- Incorporate additional factors like on-time performance and service quality for a more comprehensive analysis.
- Implement predictive models for customer satisfaction based on fleet and financial metrics.


