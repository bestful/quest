
# Реляционная модель

## Таблицы основные

*Основные*
- user
- location
- состояние
<!-- 

## Таблицы сложные
*Дополнительные:*

(данные поля используются для функциональности)

- contactFor_person
- companyFor_person
- stockFor_productIn_location
- recipientIn_location
- supplierIn_location

*Кешируемые:*
(данные поля можно присобачить ко всему)
- linkIn_System (для тегов и поиска по ним)

## Видовые таблицы

- user (person + contact)
- place (location + tags)


## Поля

- [x] person:
  - Имя
  - Пароль

- [x] location:
  - Ширина
  - Долгота
  - *Адрес*

- [x] product:
  - name
  - *manufacturer*

- [x] companyFor_person
  - id
  - person_id (director)
  - name

- [X] stockFor_productIn_location:
  - product_id
  - location_id
  - count
  - price

- [x] recipientIn_location
  - location_id
  - company_id

- [x] supplierIn_location
  - location_id
  - company_id


## Связи

Поля со связями
- person-> contactFor_person
- location -> linkIn_System
- product -> stockFor_productIn_location
- location -> recipientIn_location
- location -> supplierIn_location -->