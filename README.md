

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
* <a href="https://github.com/lostisland/faraday">Faraday</a>
* <a href="https://github.com/bblimke/webmock">Webmock</a>
* <a href="https://github.com/vcr/vcr">VCR</a>


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
Run `rails s` to start the server locally. Once the server is running, use <a href="https://www.postman.com/">Postman</a> to access the different endpoints in this application. The endpoints, along with information on each one, are listed in the table below. 

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
GET       | `/api/v1/items/:item_id/merchant` | Get an Item's Merchants Information| [Link](#get-items-merchants)
GET       | `/api/v1/merchants/:merchant_id/items` | Get all of a Merchant's Items| [Link](#get-merchant-items)
GET       | `/api/v1/merchants/find_all` | Search for Merchants| [Link](#search-merchants)
GET       | `/api/v1/items/find` | Search for one Item| [Link](#search-items)
GET       | `/api/v1/revenue/merchants` | Get Top Merchants by Revenue| [Link](#merchant-revenue)
GET       | `/api/v1/revenue` | Return Revenue of all Merchants between two dates| [Link](#revenue-generated-between-given-dates)
GET       | `/api/v1/revenue/merchants/:id` | Return Revenue for a Single Merchant| [Link](#get-revenue-for-a-single-merchant)
GET       | `/api/v1/revenue/weekly` | Return Revenue for each week| [Link](#get-revenue-report-sorted-by-week)
GET       | `/api/v1/revenue/unshipped` | Return Potential Revenue of Unshipped Invoices| [Link](#get-revenue-for-unshipped-invoices)

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
        { ... },
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
        { ... },
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
Status: 201 Created
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
`id`  | String | Path | Required | Item ID
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

### Delete an Item
Deletes an existing item. Note that invoice items that belong to the item will be deleted as well. Invoices and transactions will be deleted if the item being deleted is the only item on the invoice. 

```
DELETE /api/v1/items/:id
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`id`  | String | Path | Required | Item ID


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

### Get Items Merchants
Returns an iems merchant information in the response. 

```
GET /api/v1/items/:item_id/merchants
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`item_id`  | Integer | Path | Required | Item ID


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

### Get Merchant Items
Returns a response of all items belonging to a single Merchant. 
```
GET /api/v1/merchants/:merchant_id/items
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`merchant_id`  | String | Path | Required | Merchant ID


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
        { ... },
    ]
}
```

---

### Search Merchants
Return a list of merchants with a similar name, or an empty response if no merchants can be found with that search

```
GET /api/v1/merchants/find_all
```


### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`name`  | String | Path | Required | Name of a Merchant


### Example Response

```
Status: 200 OK
```

```
{
    "data": [
        {
            "id": "2",
            "type": "merchant",
            "attributes": {
                "name": "Klein, Rempel and Jones"
            }
        },
        {
            "id": "45",
            "type": "merchant",
            "attributes": {
                "name": "Dickinson-Klein"
            }
        }
    ]
}   
```

---

### Search Items
Returns one item by partial name search. 
```
GET /api/v1/items/find
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`name`  | String | Path | Optional | Name of an Item
`min_price`  | String | Path | Optional | Items that have unit prices above a given threshold
`max_price`  | String | Path | Optional | Items that have unit prices below a given threshold


### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": "54",
        "type": "item",
        "attributes": {
            "name": "Item Enim Error",
            "description": "Odio inventore quis quia nesciunt. Libero id ipsam et. Perspiciatis porro vero quia aut aperiam. Quaerat rerum et sit earum ut tempore illum.",
            "unit_price": 775.96,
            "merchant_id": 3
        }
    }
}
```

---

### Merchant Revenue
Returns a number of merchants as given by the quantity params in the response in order of highest grossing revenue in descending order. Response includes the total revenue generated for the merchant for all merchant invoices. 

```
GET /api/v1/revenue/merchants
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`quantity`  | String | Path | Required | Number of Merchants to be returned in response


### Example Response

```
Status: 200 OK
```

```
{
    "data": [
        {
            "id": "14",
            "type": "merchant_name_revenue",
            "attributes": {
                "name": "Dicki-Bednar",
                "revenue": 1148393.7399999984
            }
        },
        {
            "id": "89",
            "type": "merchant_name_revenue",
            "attributes": {
                "name": "Kassulke, O'Hara and Quitzon",
                "revenue": 1015275.1500000001
            }
        }
    ]
}
```

---

### Revenue Generated Between Given Dates
Get total revenue of all merchants between a start date and an end date. 

```
GET /api/v1/revenue
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`start`  | String | Path | Required | Starting Date
`end`  | String | Path | Required | Ending Date


### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": null,
        "type": "revenue",
        "attributes": {
            "revenue": 3697159.7799999965
        }
    }
}
```

---

### Get Revenue for a Single Merchant
Returns a response with the total revenue generated for a single merchant. 

```
GET /api/v1/revenue/merchants/:id
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`start`  | String | Path | Required | Starting Date
`end`  | String | Path | Required | Ending Date


### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": "1",
        "type": "merchant_revenue",
        "attributes": {
            "revenue": 528774.6400000005
        }
    }
}
```

---

### Get Revenue for a Single Merchant
Returns a response with the total revenue generated for a single merchant. 

```
GET /api/v1/revenue/merchants/:id
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`start`  | String | Path | Required | Starting Date
`end`  | String | Path | Required | Ending Date


### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": "1",
        "type": "merchant_revenue",
        "attributes": {
            "revenue": 528774.6400000005
        }
    }
}
```

---

### Get Revenue Report Sorted by Week
Returns a response with the total revenue for each week according to invoice created at values. 

```
GET /api/v1/revenue/weekly
```

### Example Response

```
Status: 200 OK
```

```
{
    "data": [
        {
            "id": null,
            "type": "weekly_revenue",
            "attributes": {
                "week": "2012-03-05",
                "revenue": 14981117.170000013
            }
        },
        {
            "id": null,
            "type": "weekly_revenue",
            "attributes": {
                "week": "2012-03-12",
                "revenue": 18778641.380000062
            }
        },
        { ... },
    ]
}
```

---


get-revenue-for-unshipped-invoices

### Get Revenue for Unshipped Invoices
Returns a response with the total revenue of invoices that have an unshipped status. 

```
GET /api/v1/revenue/unshipped
```

### Example Response

```
Status: 200 OK
```

```
{
    "data": [
        {
            "id": "4844",
            "type": "unshipped_revenue",
            "attributes": {
                "potential_revenue": 1504.08
            }
        }
    ]
}
```

## Contact

Matt Toensing - [LinkedIn ](https://linkedin.com/in/matt-toensing/) - [Email](mailto:matthew.toensing@gmail.com) - [GitHub](https://github.com/matttoensing) - [@instagram](https://www.instagram.com/matt_rtoensing/)

Project Link: [https://github.com/matttoensing/rails_engine](https://github.com/matttoensing/rails_engine)


## Acknowledgements
* Turing School of Software and Design
* All the great developers who have helped me along the way

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/matt-toensing
