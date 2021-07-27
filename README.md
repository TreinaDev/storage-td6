# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# API

## Consulta de galpões que possuem um produto

```
GET '/api/v1/freightage/warehouses/:sku'
```

resposta:

```json
[
  {
    warehouse_code: AB12,
    lat: -12.980587,
    lon: -38.494138,
    name: rua maracujá,
    number: 4,
    district: fruteira,
    city: cidade das frutas,
    state: estado das frutas
  },
  {
    warehouse_code: CD34,
    lat: -11.980587,
    lon: -39.494138,
    name: rua jabuticaba,
    number: 456,
    district: fruteira,
    city: cidade das frutas,
    state: estado das frutas
  }
]
```


## Consulta de galpões que possuem um produto e suas quantidades disponíveis em cada galpão

```
GET '/api/v1/ecommerce/warehouses/:sku'
```

resposta:

```json
[
  {
    warehouse_code: AB12,
    quantity: 10
  },
  {
    warehouse_code: CD34,
    quantity: 5
  }
]
```