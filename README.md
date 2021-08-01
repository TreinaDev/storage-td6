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
{
   "warehouses":[
      {
         "warehouse_code":"0000",
         "number":4,
         "district":"Leão",
         "city":"Papagolândia",
         "state":"AM",
         "latitude":"-23.5672582",
         "longitude":"-46.651529",
         "address":"Rua Jaguar"
      },
      {
         "warehouse_code":"0001",
         "number":4,
         "district":"Leão",
         "city":"Papagolândia",
         "state":"AM",
         "latitude":"-23.5672582",
         "longitude":"-46.651529",
         "address":"Rua Jaguar"
      },
      {
         "warehouse_code":"0002",
         "number":4,
         "district":"Leão",
         "city":"Papagolândia",
         "state":"AM",
         "latitude":"-23.5672582",
         "longitude":"-46.651529",
         "address":"Rua Jaguar"
      }
   ]
}
```


## Consulta de galpões que possuem um produto e suas quantidades disponíveis em cada galpão

```
GET '/api/v1/ecommerce/warehouses/:sku'
```

resposta:

```json
{
   "warehouses":[
      {
         "warehouse_code":"ROB2",
         "quantity":9
      },
      {
         "warehouse_code":"AMZ1",
         "quantity":3
      }
   ]
}
```

## Consulta do endereço de um galpão

```
GET '/api/v1/ecommerce/warehouse/:code'
```

resposta:

```json
{
  "warehouse": {
    "code": "0002",
    "full_address": {
      "number": 1293,
      "district": "Jardim Paulista",
      "city": "São Paulo",
      "state": "SP",
      "latitude": "-23.5569296",
      "longitude": "-46.6635382",
      "address": "Alameda Santos"
    }
  }
}
```