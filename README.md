# CoffeeProject

## About

* Coffee shop is selling a bunch of items for their customers e.g. (Coffees, Sandwitches, Beverages).

* Items have varying prices and some are free or offered at a discount when ordered with another item.

* Customer can see the list of available items, group deals and promotion line items.

* Group items contains selection of multiple items with discount e.g (Group Deal contails Coffee 1, Coffee 2, Sanwitches with discount of $20).

* Promotion Line Items contains one source item and one free item like buy one item and get one free item.

* When a user selects any promotion line item, it's price will be calculated based on the price of source item multiplies by the quantities of that item.

* When a user selects any group deal, it's price will be calculated based on the items included into it multiplies by the quantities of that deal with a specific amount of discount.

* Customer can select individual item, group deal or promotion line item.

* Customer can add line item to cart and place their order after selection.

* After placing the order, he will receive a notification that "You Order Has Been Placed Successfully!".

* After 10 minutes of order placement, customer will receive an email about order completion.

* There is an environment variable SEND_NOTIFICATION_EMAIL, change it's value based on need.

## API End Points

* GET ```/api/v1/orders```
* POST ```/api/v1/orders```
* GET ```/api/v1/orders/1```
* DELETE ```/api/v1/orders/1```

* GET ```/api/v1/items```
* POST ```/api/v1/items```
* GET ```/api/v1/items/1```
* PUT ```/api/v1/items/1```
* DELETE ```/api/v1/items/1```

* GET ```/api/v1/customers```
* POST ```/api/v1/customers```
* GET ```/api/v1/customers/1```
* PUT ```/api/v1/customers/1```
* DELETE ```/api/v1/customers/1```

* GET ```/api/v1/line_items```
* POST ```/api/v1/line_items```
* GET ```/api/v1/line_items/1```
* PUT ```/api/v1/line_items/1```
* DELETE ```/api/v1/line_items/1```

* GET ```/api/v1/group_items```
* POST ```/api/v1/group_items```
* GET ```/api/v1/group_items/1```
* PUT ```/api/v1/group_items/1```
* DELETE ```/api/v1/group_items/1```

* GET ```/api/v1/promotion_line_items```
* POST ```/api/v1/promotion_line_items```
* GET ```/api/v1/promotion_line_items/1```
* PUT ```/api/v1/promotion_line_items/1```
* DELETE ```/api/v1/promotion_line_items/1```

For more information please see postman apis collections (postman_collection/CoffeeShop.postman_collection.json)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Installing

* Ruby version
 3.0.2

 ```
 rvm install 3.0.2
 ```
* Database
postgresql

```
brew install postgres
cd coffee_project
```

* Install Gems
```
bundle install
```

* Database creation
```
  rails db:create
  rails db:migrate
```

* Populate Database with initial data
```
rails db:seed
```

* Install node modules
```
yarn install
```

* Create .env file and set the environemnt variables, see .env.example

### Using API

* Run app on port 3000
```
bin/dev
