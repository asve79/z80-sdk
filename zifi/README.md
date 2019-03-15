# z80-sdk zifi module

Описание: Библиотека ф-ций для работы через zifi модуль + демо программа.

Цель: сделать минимальной и простой набор ф-ций для работы с данными через Zifi

Именование макросов: Макрос именуется названием ф-ции с префиксом _zifi

## TO DO / In progress

- init
- list_ap
- connect_ap
- disconnect_ap
- open_tcp
- close_tcp
- send
- receve

# Функции и макросы модуля

## init
Инициализация Zifi

Вых:
 A=0 - OK
 A=1 - ERROR

Вызов:
```
	call zifi.init
```
	или
```
	_zifi_init
```

## list_ap
Получить список доступных точек доступа

Вх:
 HL - адрес буфера
Вых:
 A=0 - ОК
 A=1 - ERROR
 HL  - указатель на буфер с выводом ESP

Вызов:
```
	ld hl,bufer
	call zifi.list_ap
```
	или
```
	_list_ap bufer
```
