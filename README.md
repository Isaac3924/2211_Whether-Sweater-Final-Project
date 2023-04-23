# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* outlines the learning goals

* how someone can clone and set up your application and where they can get their own API keys

* happy path endpoint use

# Learning Goals

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
