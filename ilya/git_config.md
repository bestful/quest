## Установка
- https://git-scm.com/download/win
- https://code.visualstudio.com/Download

# Организуем подключение

## Глобальная настройка
- git config --global user.name "Ilya Kataev"
- git config --global user.email "kataev.i@gmail.com"

## Генерация ключа

**Если его нет в ~/Documents, то**
- Заходим в ~/.ssh
- ssh-keygen -t rsa -b 4096 -C "kataev.i@gmail.com"

Filename: id_rsa

## Добавление ключа в github
github.com -> Settings -> ssh keys -> SSH and GPG keys -> New ssh key

## Проверка авторизации
Проверка
- ssh -vT git@github.com

# Копирование репозитория
- Заходим в ~/Documents 
- git clone git@github.com:bestful/future.git

## Согласиться на приглашение
- Перейти по ссылке https://github.com/bestful/future/invitations