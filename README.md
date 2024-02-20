# Whether Sweater
Whether Sweater is an application that aggregates data from multiple external APIs and exposes them through a JSON API with CRUD functionality. This README provides instructions for setting up the application, and outlines the learning goals.

## Learning Goals
* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc)

## Features
### Road Trip
* Receives incoming data
* Returns incoming data in specific format/pieces
* Requires an API key for authentication
* Utilizes external APIs
* Returns a JSON payload in the body of the request
## Setup
1. Clone this repository to your local machine: **'git clone git@github.com:Isaac3924/2211_Whether-Sweater-Final-Project.git'**
2. Install dependencies: **'bundle install'**
3 .Configure the database by running **'rails db:setup'**
4. Get the API key for MapQuest from this link: **https://developer.mapquest.com/documentation/** and paste it into the **'config/application.yml'** file as a string value to the **'MAPQUEST_DATABASE_KEY'** variable.
5. Get the API key for Weather API from this link: **https://www.weatherapi.com/** and paste it into the **'config/application.yml'** file as a string value to the **'WEATHER_DATABASE_KEY'** variable.
6. Start the server by running **'rails server'**
7. Visit **'http://localhost:5000'** in your web browser to confirm that the app is running.
8. Test the API endpoints by visiting **'http://localhost:5000/api/v1/users'**, **'http://localhost:5000/api/v1/sessions'**, and **'http://localhost:5000/api/v1/road_trip'**.
If you have a front-end that can call on the endpoints listed in step 8, you should receive a JSON response with the requested data. Or utilize Postman or similar API testing software.

## Authentication
To register a user, send a POST request to **'/api/v1/users'** with the following parameters in the request body:

* **'email'**
* **'password'**
* **'password_confirmation'**

To log in a user, send a POST request to **'/api/v1/sessions'** with the following parameters in the request body:

* **'email'**
* **'password'**

Both the register and login endpoints will return a JSON payload in the response body, including a generated API key for authentication.

## Testing
To run the tests, use the **'rspec'** command. The application uses VCR to mock external API calls, so the first run may take some time to generate the necessary VCR cassettes. If needed, delete the **'spec/fixtures'** folder, especially if spec tests aren't passing.

## Conclusion
You're now ready to use Whether Sweater. If you encounter any issues, please submit an issue on GitHub or contact the project creator.
