
# Estoque
Projeto final da turma 6 do TreinaDev, realizado pela Campus Code, com apoio das empresas Rebase, Konduto, Vindi, Portal Solar e SmartFit. O projeto consiste na criação de uma plataforma de estoque vinculada ao ecommerce. Tem como objetivo registrar a quantidade de itens cadastrados pelo ecommerce, os fornecedores, os galpões onde são armazenados os produtos e todo o processo de entrada e saída de produto.

# Tecnologias Utilizadas
## Backend
- Ruby 3.0.1
- Rails 6.1.4

- ### Gems 
    * Rspec
    * Capybara 
    * Shoulda Matchers
    * FactoryBot 
    * Devise 
    * Geocoder
    * Rubocop
    * Cpf_Cnpj

## Frontend 
- Html 5
- Css 3
- Bootstrap


## Instalação

Primeiramente, clone o projeto:

```bash
  $ git clone https://github.com/TreinaDev/storage-td6.git
```
Em seguida instale as dependências:

```bash 
$ cd storage-td6 
$ bin/setup 
```

Popule o banco de dados:

```bash
$ rails db:seed
```

Inicie o servidor localmente:
```bash 
$ rails server
```

Em seguida, clique no link para acessar a aplicação:

http://127.0.0.1:3000/


## API 

#### Consulta de galpões que possuem um produto (frete)

```http
  GET '/api/v1/freightage/warehouses/:sku'

```

| Parametro | Tipo     | Descrição               |
| :-------- | :------- | :------------------------- |
| `sku` | `string` | **Obrigatório**. SKU do produto |

Resposta:

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



#### Consulta de galpões que possuem um produto e suas quantidades disponíveis em cada galpão (e-commerce)

```http 
GET '/api/v1/ecommerce/warehouses/:sku'
```

| Parametro | Tipo     | Descrição                       |
| :-------- | :------- | :-------------------------------- |
| `sku`      | `string` | **Obrigatório**. SKU do produto |


Resposta:

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

#### Consulta do endereço de um galpão

  ```http
  GET '/api/v1/ecommerce/warehouse/:code'
  ```

  | Parametro | Tipo     | Descrição                       |
| :-------- | :------- | :-------------------------------- |
| `code`      | `string` | **Obrigatório**. Código do galpão |


Resposta:

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

#### Criar uma reserva de produto
  ```http
  POST '/api/v1/reserve'
  ```
  - Cria uma reserva de produto em um determinado galpão, com os seguintes parametros:
  ```json
  {
    "reserve": {
          "sku": "abcd0000001" ,
          "shipping_company:" "XYZ8",
          "request_number": "125",
          "warehouse": "abcd"
        }
  }
  ```
  | Parametro | Tipo     | Descrição                       |
| :-------- | :------- | :-------------------------------- |
| `sku`      | `string` | **Obrigatório**. SKU do produto |
| `shipping_company` | `int` | **Obrigatório**. Identificador da empresa de entrega|
|`request_number` | `string` | **Obrigatório**. Número do pedido |
| `warehouse` | `string` | **Obrigatório**. Código do Galpão |

Resposta: 

- HTTP Status: 201 

```json
{
   "status":"reserved",
   "code":"abcd000001",
   "supplier_id":"1",
   "product_entry_id":"1",
   "warehouse_id":"1",
   "sku":"AIXRP128"
}
```

#### Criar uma devolução de item
  ```http
  POST '/api/v1/freightage/return_entries'
  ```
  - Cria uma devolução de item em um determinado galpão, com os seguintes parametros:
  ```json
  {
    "return_entry": {
          "request_number": "123456"
        }
  }
  ```
  | Parametro        | Tipo      | Descrição                        |
	| :--------------- | :-------- | :------------------------------- |
	| `resquest_number`| `integer` | **Obrigatório**. Código da venda |

Resposta: 

- HTTP Status: 201 

```json
{
   "message":"Ordem de retorno criada com sucesso!",
}
```

## Entrada de produtos por csv
	Um arquivo csv válido deve ser parecer com:
	```
	sku,invoice,quantity,supplier_id
	abc123,1034,7,1
	abc124,1036,3,1
	```
## Autores

* [@cohako](https://www.github.com/cohako)
* [@ericdaher](https://www.github.com/ericdaher)
* [@glmsilva](https://www.github.com/glmsilva)
* [@Laryssa-lfa](https://www.github.com/Laryssa-lfa)
* [@rog404](https://www.github.com/rog404)

  