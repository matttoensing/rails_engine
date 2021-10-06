

[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/github_username/repo_name">
    <img src="https://user-images.githubusercontent.com/80132364/132785374-6483e60c-7a65-4101-b611-3546ef1a2f84.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Rails Engine</h3>

<!-- TABLE OF CONTENTS -->
  <details open="open"><summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#endpoints">Endpoints</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<img width="1096" alt="Screen Shot 2021-09-03 at 2 01 23 PM" src="https://user-images.githubusercontent.com/80132364/132785754-258e2580-71ec-4de4-8aeb-005fc6c89b3b.png">

This is a API application built in Ruby on Rails. The intended client for this application is a front end development team. Data is exposed through various endpoints using RESTful architecture. In addition to custom JSON responses, some resources include CRUD endpoints. 


### Built With

* Rails 5.2.6
* Ruby 2.7.2
* PostgreSQL

#### Gems Used for Development

* <a href="https://github.com/rspec/rspec-rails">RSpec</a>
* <a href="https://github.com/teamcapybara/capybara">Capybara</a>
* <a href="https://github.com/mislav/will_paginate">will paginate</a>
* <a href="https://github.com/thoughtbot/factory_bot_rails">factory bot rails</a>
* <a href="https://github.com/faker-ruby/faker">faker</a>
* <a href="https://github.com/pry/pry">pry</a>
* <a href="https://github.com/Netflix/fast_jsonapi">fast json api</a>


<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

* Ruby 2.7.2
* Ruby on Rails 5.2.6
* <a href="https://www.postgresql.org/download/">Postgresql</a>

### Installation
Clone down this repo

```
git clone git@github.com:matttoensing/rails_engine.git
```

Move into Rails Engine directory
```
cd rails_engine
```

Install any missing gems

```
bundle install
```

Setup your local database with Postgresql
```
rails db:create
rails db:migrate
```

Seed the DB using the pg dump file located in the db directory
```
rails db:seed
```
## Usage
stuff

## Endpoints

HTTP Verb | Endpoint              | Description                              | Link
----------|-----------------------|------------------------------------------|---------------------------
GET       | `/api/v1/merchants` | Get all Merchants | [Link](#get-merchants)
GET       | `/api/v1/merchants/:id`       | Get a single Merchant | [Link](#get-a-single-merchant)
GET       | `/api/v1/items` | Get all Items | [Link](#get-all-items)
GET       | `/api/v1/items/:id` | Get a single Item | [Link](#get-a-single-item)
POST      | `/api/v1/items` | Create a new Item | [Link](#create-a-new-item)
PATCH     | `/api/v1/items/:id` | Update an existing Item | [Link](#update-an-item)
DELETE    | `/api/v1/items/:id` | Deletes an existing Item | [Link](#delete-an-item)

---

### Get Merchants
Returns a response of all Merchants. 

```
GET /api/v1/merchants
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`page`  | Integer | Path | Optional | See notes below
`per_page`     | Integer | Path | Optional | See notes below

Notes: 
The response will default to the first page if `page` is not included in the parameters. Per page will default to 20 merchants in the response, and if `per_page` is included, will return the included value of `per_page` number of merchants. 

### Example Response

```
Status: 200 OK
```

```
{
    "data": [
        {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        },
        {
            "id": "2",
            "type": "merchant",
            "attributes": {
                "name": "Klein, Rempel and Jones"
            }
        },
        {
            "id": "3",
            "type": "merchant",
            "attributes": {
                "name": "Willms and Sons"
            }
        },
        { ... }
    ]
}      
```

---


### Get a Single Merchant
Returns a response of all Merchants. 

```
GET /api/v1/merchants/:id
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`id`  | Integer | Path | Required | Merchant ID

### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "Schroeder-Jerde"
        }
    }
}     
```

---

### Get all Items
Returns a response of all items. 
```
GET /api/v1/items
```


### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`page`  | Integer | Path | Optional | See notes below
`per_page`     | Integer | Path | Optional | See notes below

Notes: 
The response will default to the first page if `page` is not included in the parameters. Per page will default to 20 merchants in the response, and if `per_page` is included, will return the included value of `per_page` number of merchants. 

### Example Response

```
Status: 200 OK
```

```
{
    "data": [
        {
            "id": "4",
            "type": "item",
            "attributes": {
                "name": "Item Nemo Facere",
                "description": "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.",
                "unit_price": 42.91,
                "merchant_id": 1
            }
        },
        {
            "id": "5",
            "type": "item",
            "attributes": {
                "name": "Item Expedita Aliquam",
                "description": "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.",
                "unit_price": 687.23,
                "merchant_id": 1
            }
        },
        { ... }
    ]
}      
```

---

### Get a Single Item
Returns a single item in a response. 

```
GET /api/v1/item/:id
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`id`  | Integer | Path | Required | Item ID

### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": "4",
        "type": "item",
        "attributes": {
            "name": "Item Nemo Facere",
            "description": "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.",
            "unit_price": 42.91,
            "merchant_id": 1
        }
    }
}     
```

---

### Create a new Item
Creates a new item and returns the newly created item in the response. 

```
POST /api/v1/items
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`name`  | String | Path | Required | Item Name
`description`  | String | Path | Required | Item Description
`unit_price`  | Float | Path | Required | Item Unit Price
`merchant_id`  | Integer | Path | Required | Merchant ID the Item belongs to

### Example Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "16",
    "type": "item",
    "attributes": {
      "name": "Widget",
      "description": "High quality widget",
      "unit_price": 100.99,
      "merchant_id": 14
    }
  }
}   
```

---

### Update an Item
Updates attributes of an existing item.

```
PATCH /api/v1/items/:id
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`name`  | String | Path | Optional | Item Name
`description`  | String | Path | Optional | Item Description
`unit_price`  | Float | Path | Optional | Item Unit Price
`merchant_id`  | Integer | Path | Optional | Merchant ID the Item belongs to

### Example Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "16",
    "type": "item",
    "attributes": {
      "name": "Widget",
      "description": "Newly updated high quality widget",
      "unit_price": 99.99,
      "merchant_id": 14
    }
  }
}   
```

---

- For deleing an Item(note that invoice items for the item will be deleted, and invoices and transactions will be deleted if the item being deleted is the only item on the invoice)
```
DELETE /api/v1/items/:item_id
```
### Delete an Item
Deletes an item.

```
DELETE /api/v1/items/:id
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`name`  | String | Path | Optional | Item Name
`description`  | String | Path | Optional | Item Description
`unit_price`  | Float | Path | Optional | Item Unit Price
`merchant_id`  | Integer | Path | Optional | Merchant ID the Item belongs to

### Example Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "16",
    "type": "item",
    "attributes": {
      "name": "Widget",
      "description": "Newly updated high quality widget",
      "unit_price": 99.99,
      "merchant_id": 14
    }
  }
}   
```
### Merchant Items
- Merchant Items
```
GET /api/v1/merchants/:merchant_id/items
```

### Search Merchants
- By merchant name(will return a list of merchants with a similar name if merchants exists with a similar name exist in the DB, note name query params must be present to complete request)
```
GET /api/v1/merchants/find_all?name=NAME
```

### Search Items
- By Item Name(will return one item by partial name search, note name query params must be present to complete request)
```
GET /api/v1/items/find?name=NAME
```

- By minimum price or maximum price
```
GET /api/v1/items/find?min_price=MIN_PRICE
```

```
GET /api/v1/items/find?max_price=MAX_PRICE
```

```
GET /api/v1/items/find?max_price=MAX_PRICE&min_price=MIN_PRICE
```

### Revenue Endpoints
- Get revenue for Merchants by quantity
```
GET /api/v1/revenue/merchants?quantity=QUANTITY
```

- Get total revenue between a start date and an end date
```
GET /api/v1/revenue?start={{start_date}}&end={{end_date}}
```

- Get total revenue of a single merchant
```
GET /api/v1/revenue/merchants/:merchant_id
```

- Get all revenue of unshipped invoices
```
GET /api/v1/revenue/unshipped
```

- Get a revenue repoer sorted by week 
```
GET /api/v1/revenue/weekly
```
<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/matt-toensing
