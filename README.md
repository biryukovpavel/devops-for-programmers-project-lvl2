### Hexlet tests and linter status:
[![Actions Status](https://github.com/biryukovpavel/devops-for-programmers-project-lvl2/workflows/hexlet-check/badge.svg)](https://github.com/biryukovpavel/devops-for-programmers-project-lvl2/actions)

# Деплой Docker-образов с помощью Ansible

## Оглавление

1. [Введение](#introduction)
1. [Требования](#requirements)
1. [Начало работы](#getting-started)
1. [Деплой](#deploy)

<a name="introduction"></a>
## Введение

Это приложение позволяет развернуть Redmine при помощи Ansible

<a name="requirements"></a>
## Требования
- Make
- Docker
- Ansible 2.9 или выше

<a name="getting-started"></a>
## Начало работы

Эта инструкция позволяет вам запустить копию проекта на вашем локальном компьютере в целях разработки и тестирования.

### Скачивание и установка

* Клонировать проект
```shell
git clone git@github.com:biryukovpavel/devops-for-programmers-project-lvl2.git
```

* Установить роли и коллекции из Ansible Galaxy
```shell
make ansible-galaxy-install
```

* Добавить файл с паролем от ansible-vault в `./tmp/ansible-vault-password`

<a name="deploy"></a>
### Деплой

Деплой на сервера
```shell
make deploy
```
