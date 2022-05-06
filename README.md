# README

This is the technical assessment for the Backend Engineering Position at Smarter Sorting. 

## Setup 

- Get the dependencies. This program was built on Ruby version 2.7.4. Either change the gemfile and .ruby-version to accomodate your local version OR install this version of Ruby via RBENV or RVM. Then bundle to install gems

```
bundle install

```
- Now setup the database 
```
rails db:{create,migrate,seed}
```

- Run tests to ensure everything is working as it should. 
```
bundle exec rspec  # runs all spec tests at once
bundle exec rspec spec/requests # runs all feature tests 
bundle exec rspec spec/models # runs all model tests
``` 

## Live demo 

- First start the server (on port 3000)
``` 
rails server -p 3000
```
### Viewing all products in database
The database was seeded with data generated from the Faker gem, so the data may seem kind of odd. 

In your browser, visit
```
localhost:3000/api/v1/products
```

### View products that contain a certain ingredient/element
To see all the products that contain aluminum, navigate to: 
```
localhost:3000/api/v1/with_ingredient?ingredients=Aluminum
```
Other possibilities include Terbium, Ferbium, and Radon