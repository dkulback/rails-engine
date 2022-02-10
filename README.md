# README
* Description

Rails Engine is a rails API created for consumption by a front-end client. It
has a total of 10 end points to retrieve data on an e-commerce database.

* Schema Design

Ruby/Rails Versions

 Ruby - 2.7.4

 Rails - 5.2.6


* Local deployment
```
$ git clone git@github.com:dkulback/rails-engine.git
$ bundle install
$ rake db:{drop,create,migrate,seed}
$ rails db:schema:dump
```
* Running The Test Suite
Request Suite
```
$ bundle exec rspec spec/requests
```
Model Suite
```
$ bundle exec rspec spec/models
```
* Endpoints
- While running rails server from the command line open a browser to
  http:/localhost:3000
```
GET /api/v1/merchants/find
GET /api/v1/merchants/:merchant_id/items
GET /api/v1/merchants
GET /api/v1/merchants/:id
GET /api/v1/items/find_all
GET /api/v1/items/:item_id/merchant
GET /api/v1/items
POST /api/v1/items
GET /api/v1/items/:id
PATCH /api/v1/items/:id
PUT /api/v1/items/:id
DELETE /api/v1/items/:id
```
