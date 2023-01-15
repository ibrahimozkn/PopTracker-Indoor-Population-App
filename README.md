# CNG 491 Pop Tracker Application

## Authors 
- Ibrahim Ozkan 
- Adil B. Kebapçıoğlu

## Project Description
In most indoor areas, mainly gyms and supermarkets, over-crowdedness causes significant
inconvenience. This inherently got more serious since the COVID-19 pandemic, when people
became more reluctant to be in overcrowded areas. Our project aims to ease this problem by
informing people about the population of an indoor area in real time. Users of the application
would also be able to see specific statistics, such as the crowdedness of an area at specific times
of the day. This would give people an option to go at a less crowdy time. We are planning to
integrate the system for multiple businesses. Therefore, it would be helpful to include extra
details for the businesses, such as name, telephone number, website, and location. PopTracker is
an application that uses IoT devices (Arduino UNO) to capture the entrance and departure of
people to and from an indoor area. The IoT device would sense an entrance or departure using
two motion sensors and send the data to the Cloud. The mobile app would display the data
collected from the motion sensor via Cloud. The Cloud will regularly compute the existing data
to create statistics.

## How to setup the backend?
Software requirements:
- Composer
- PHP v8.0.1
- MYSQL

1. First, install composer, php and mysql to your machine. 
2. Clone the API folder to your "public" directory. 
3. Execute "composer install" to install required libraries. 
4. Edit your .env file and change the database credentials according to your needs
5. Execute "php artisan migrate:fresh" to migrate the database
6. Run "php artisan key:generate" to generate your app key
7. Execute "php artisan db:seed" to generate test data (if needed)
8. Execute "php artisan serve" to start the API

## How to Install the Mobile Application?
1. Download the latest version of APK file.
2. Install the APK file
3. Launch the app

## Recommended Cloud Services to Run your backend API
AWS EC2 - https://aws.amazon.com/ec2/
AWS RDS - https://aws.amazon.com/rds/
