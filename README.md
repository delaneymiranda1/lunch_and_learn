# Welcome to Lunch and Learn

Users may use this app to explore recipes by country, add recipes to their "favorites" and indulge themselves in learning resources for desired countries.

## Learning Goals

* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Implement Basic Authentication
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

## How to set up the application

```Git clone git@github.com:delaneymiranda1/lunch_and_learn.git```

```bundle install```

### Sources for API keys needed

* https://developer.edamam.com/edamam-recipe-api
* https://developers.google.com/youtube/v3/getting-started
* https://www.pexels.com/api/

## Happy path endpoint use

* Get Recipes For A Particular Country (GET /api/v1/recipes?country=thailand)
* Get Learning Resources for a Particular Country (GET /api/v1/learning_resources?country=italy)
* User Registration (POST /api/v1/users)
* Log In User (POST /api/v1/sessions)
* Add Favorites (POST /api/v1/favorites)
* Get a User's Favorites (GET /api/v1/favorites?api_key=<USER API KEY>)
