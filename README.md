

[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/github_username/repo_name">
    <img src="https://user-images.githubusercontent.com/80132364/132785374-6483e60c-7a65-4101-b611-3546ef1a2f84.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Rails Engine</h3>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#endpoints">Endpoints</a>
    </li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<img width="1096" alt="Screen Shot 2021-09-03 at 2 01 23 PM" src="https://user-images.githubusercontent.com/80132364/132785754-258e2580-71ec-4de4-8aeb-005fc6c89b3b.png">

- This is a API application built in Rails. Data is exposed through different various endpoints using RESTful architecture. 


### Built With

* Rails 5.2.6
* Ruby 2.7.2
* PostgreSQL

#### Gems Used for Development

* RSpec
* Capybara
* will paginate
* Factory Bot
* Faker
* pry
* fast_jsonapi

<!-- GETTING STARTED -->
## Endpoints

Merchant Endpoints
- For finding all Merchants
```
GET /api/v1/merchants
```

- For finding a single Merchant
```
GET /api/v1/merchants/:merchant_id
```

Items Endpoints 
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

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/matt-toensing
