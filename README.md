

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
* API keys from Unsplash, Mapquest, and OpenWeather. Instructions on obtaining and using API keys locally with this application can be found below. 
* <a href="https://www.postgresql.org/download/">Postgresql</a>

## Endpoints

### Merchants
- For finding all Merchants
```
GET /api/v1/merchants
```

- For finding a single Merchant
```
GET /api/v1/merchants/:merchant_id
```

### Items
- For finding all Items
```
GET /api/v1/items
```

- For finding a single item
```
GET /api/v1/items/:item_id
```

- For creating an Item(note that merchant ID is required to make a post request to create an item as items belong to merchants)
```
POST /api/v1/items
```

- For updating an Item
```
PATCH /api/v1/items/:item_id
```

- For deleing an Item(note that invoice items for the item will be deleted, and invoices and transactions will be deleted if the item being deleted is the only item on the invoice)
```
DELETE /api/v1/items/:item_id
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
