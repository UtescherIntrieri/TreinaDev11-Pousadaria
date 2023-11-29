
# Pousadaria API

| Prefix | Verb | URI Pattern | Conroller#Action |
| ----------- | ----------- | ----------- | ----------- |
| api_v1_inns | GET | /api/v1/inns | api/v1/inns#index |
| api_v1_inn | GET | /api/v1/inns/:id | api/v1/inns#show |
| api_v1_inn_rooms | GET | /api/v1/inns/:inn_id/rooms | api/v1/rooms#index |
| api_v1_inn_room | GET | /api/v1/inns/:inn_id/rooms/:id | api/v1/rooms#show |
| check_api_v1_inn_room | GET | /api/v1/inns/:inn_id/rooms/:id/check | api/v1/rooms#check |

#

* ### /api/v1/inns
  
  * Lista todas as pousadas ativas.
  * Suporta Query pelo nome da pousada.
    * Irá pesquisar pousadas que contenham, em qualquer lugar do `brand_name`, o parâmetro passado. ( %param% )\
       &ensp; \- Pesquisa com nome simples:&ensp; */api/v1/inns?name=foo*\
       &ensp; \- Pesquisa com nome composto:&ensp; */api/v1/inns?name=foo+bar*

    <details>
      <summary><i>Exemplo de resposta esperada:</i></summary>
    
          [
            {
              "id": 1,
              "brand_name": "Pousada da 16",
              "phone_number": "(13)99706-9746",
              "email": "pousada@contato.com",
              "address": "rua 15 - 47",
              "neighborhood": "guarau",
              "city": "peruibe",
              "state": "SP",
              "postal_code": "11750000",
              "description": "Pousada linda",
              "payment_methods": "Cartão",
              "pet_friendly": false,
              "usage_policy": "não fumar",
              "check_in": "2000-01-01T12:00:00.000-02:00",
              "check_out": "2000-01-01T11:00:00.000-02:00",
              "status": "active",
              "host_id": 1
            },
            {
              "id": 2,
              "brand_name": "Casa Verde",
              "phone_number": "(13)997563453",
              "email": "casaverde@contato.com",
              "address": "avenida qualquer",
              "neighborhood": "amarindo",
              "city": "eusébio",
              "state": "CE",
              "postal_code": "25840000",
              "description": "Pousada do muro verde",
              "payment_methods": "Cartão",
              "pet_friendly": true,
              "usage_policy": "Usar chinelo",
              "check_in": "2000-01-01T11:22:00.000-02:00",
              "check_out": "2000-01-01T10:22:00.000-02:00",
              "status": "active",
              "host_id": 3
            }
          ]
          
    </details>

#

* ### /api/v1/inns/:id
  
  &ensp; Eg:&ensp; */api/v1/inns/1*
  * Mostra detalhes da Pousada, junto com a nota média de avaliação.
 
    <details>
      <summary><i>Exemplo de resposta esperada:</i></summary>
      
      ```
      [
        {
          "id": 3,
          "brand_name": "pousada da ana",
          "phone_number": "123123123",
          "email": "teste@gmail.com",
          "address": "rua da ana",
          "neighborhood": "vila da ana",
          "city": "anapolis",
          "state": "SP",
          "postal_code": "54646",
          "description": "ana esteve aqui",
          "payment_methods": "todos",
          "pet_friendly": false,
          "usage_policy": "seja gentil com a ana",
          "check_in": "2000-01-01T21:10:00.000-02:00",
          "check_out": "2000-01-01T10:10:00.000-02:00",
          "status": "active",
          "host_id": 4
        },
        {
          "average_rating": 3
        }
      ]      
      ```
      
    </details>

#
  
* ### /api/v1/inns/:inn_id/rooms
  
  &ensp; Eg:&ensp; */api/v1/inns/1/rooms*
  * Lista todos os quartos disponíveis para aquela pousada.

    <details>
      <summary><i>Exemplo de resposta esperada:</i></summary>
    
      ```
      [
        {
          "id": 4,
          "name": "Quarto teste",
          "description": "Testeeee",
          "dimension": 5,
          "capacity": 2,
          "price": 123,
          "bathroom": true,
          "balcony": false,
          "ac": true,
          "tv": false,
          "wardrobre": false,
          "safe_box": false,
          "accessible": false,
          "status": "vacant",
          "inn_id": 1
        },
        {
          "id": 6,
          "name": "quartinho",
          "description": "pequeno",
          "dimension": 1,
          "capacity": 1,
          "price": 50,
          "bathroom": false,
          "balcony": false,
          "ac": true,
          "tv": false,
          "wardrobre": false,
          "safe_box": false,
          "accessible": false,
          "status": "vacant",
          "inn_id": 1
        }
      ]
      ```
        
    </details>

#
  
* ### /api/v1/inns/:inn_id/rooms/:id
  
  &ensp; Eg:&ensp; */api/v1/inns/1/rooms/1*
  * Mostra detalhes do Quarto

    <details>
      <summary><i>Exemplo de resposta esperada:</i></summary>
    
      ```
      [
        {
          "id": 6,
          "name": "quartinho",
          "description": "pequeno",
          "dimension": 1,
          "capacity": 1,
          "price": 50,
          "bathroom": false,
          "balcony": false,
          "ac": true,
          "tv": false,
          "wardrobre": false,
          "safe_box": false,
          "accessible": false,
          "status": "vacant",
          "inn_id": 3
        }
      ]
      ```
    
    </details>

#

* ### /api/v1/inns/:inn_id/rooms/:id/check
  
  &ensp; Eg:&ensp; */api/v1/inns/3/rooms/6/check?arrive_date=2023-11-28&leave_date=2023-11-30&group_size=1*
  * Faz a validação para a possível criação de uma reserva.
    * Recebe 3 parâmetros obrigatórios, divididos na URL por &:\
       \- `arrive_date` => yyyy-mm-dd\
       \- `leave_date` => yyyy-mm-dd\
       \- `group_size` => integer
       
        <details>
        <summary><i>Se a reserva for validada com sucesso, os parâmetros e o valor total são retornados:</i></summary>
          
          ```
          {
            "arrive_date": "2025-01-01",
            "leave_date": "2025-01-12", 
            "group_size": 2,                
            "total_price": 2560   # Valor total dessa reserva (já calculado com os possíveis preços por periodo)
          }
          ```
  
        </details>

        <details>
          <summary><i>Se a reserva não for validada com sucesso é retornado um objeto com os erros do model:</i></summary>
         
          ```
          {
            "errors": {
              "arrive_date": [
                "A data escolhida coincide com outra reserva: 26/11/23 - 27/11/23",
                "A data escolhida coincide com outra reserva: 24/11/23 - 25/11/23"
              ]
            }
          }    # Nesse caso há duas reservas em que as datas coincidem com a reserva a ser validada
          ```
  
        </details>
#

<br>
<br>
<br>
<img src="https://user-images.githubusercontent.com/22280294/179611382-5704fe4f-ef8c-40f2-b868-5921cfb56da6.png" alt="pusheen" height="120px" align="right">
