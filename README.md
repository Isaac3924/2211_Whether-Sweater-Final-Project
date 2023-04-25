# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* outlines the learning goals

* how someone can clone and set up your application and where they can get their own API keys

* happy path endpoint use

# Learning Goals

* Expose an API that aggregates data from multiple external APIs

* Expose an API that requires an authentication token

* Expose an API for CRUD functionality

* Determine completion criteria based on the needs of other developers

* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

## EXPOSE EXTERNAL APIS

* Ensure specific data is received

* Use data from one API to retrieve data from another

* Test for unwanted data, ensure only necessary data

## REGISTER USER

* Recieve incoming data

* Return incoming data in specific format/pieces

* POST endpoint should NOT call your endpoint like /api/v0/users?email=person@woohoo.com&password=abc123&password_confirmation=abc123

* Return a JSON payload in the body of the request, specifically

* Create an object within the database based off of incoming data

* Generate a unique API key

* Utilize status codes

* Provide description for expected errors

* Setting up Auth

## LOGIN USER

* Recieve incoming data

* Return incoming data in specific format/pieces

* POST endpoint should NOT call your endpoint like /api/v0/sessions?email=person@woohoo.com&password=abc123

* Return a JSON payload in the body of the request, specifically

* Returns from database of existing object

* Provide description for expected errors (tell a user which field (email/password) is incorrect, as this alerts malicious users how to attack your site)

## FEATURE (ROAD TRIP)

* Recieve incoming data

* Return incoming data in specific format/pieces

* POST endpoint should NOT call your endpoint like /api/v0/road_trip?origin=Cincinatti,OH&destination=Chicago,IL&api_key=t1h2i3s4_i5s6_l7e8g9i10t11

* Return a JSON payload in the body of the request, specifically

* Require an API key (AUTH)

* If no API key, 401 status (AUTH)

* Utilize external API

# Setup

1. Clone this repository to your local machine 
 ```sh
   git clone git@github.com:Isaac3924/2211_Whether-Sweater-Final-Project.git
   ```

2. Install dependencies
   ```sh
   bundle install
   ```
3. Configure the database by running rails db:setup:
   ```js
   rails db:setup
   ```

4. Get the API key for map quest from this link: https://developer.mapquest.com/documentation/ and clicking 'Grab the Key'. Paste it into the config/application.yml as a string value to the MAPQUEST_DATABASE_KEY variable.

5. Get the API key for map quest from this link: https://www.weatherapi.com/ and clicking 'Sign Up'. Fill in the forms with your email and password of choice, complete captcha, agreeing to terms, and clicking 'Sign Up'. You will be ridrected to a page saying to ait for a verification email in your provided email. THERE IS NO VERFICATION. Go ahead and log in. Copy the provided API key and paste it into the config/application.yml as a string value to the WEATHER_DATABASE_KEY variable.

6. Start the server by running rails server:
   ```js
   rails server
   ```
7. Visit http://localhost:5000 in your web browser to confirm that the app is running. Notice the port of 5000 on the backend. It is assumed that the front end service will need to be running concurrently on localhost:3000