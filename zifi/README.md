# z80-sdk zifi module

Описание: Библиотека ф-ций для работы через zifi модуль + демо программа.

Цель: сделать минимальной и простой набор ф-ций для работы с данными через Zifi

Именование макросов: Макрос именуется названием ф-ции с префиксом _zifi

## TO DO / In progress

- [x] init
- [x] list_ap
- [ ] connect_ap
- [x] current_ip
- [x] disconnect_ap
- [ ] open_tcp
- [ ] close_tcp
- [ ] send
- [ ] receve

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

## current_ip
Получить текущий IP адрес

Вх:
 HL - адрес буфера
Вых:
 A=0 - ОК
 A=1 - ERROR
 HL  - указатель на буфер с выводом ESP

Вызов:
```
	ld hl,bufer
	call zifi.curremt_ip
```
	или
```
	_curremt_ip bufer
```

## disconnect_ap
Отключиться от точки доступа

Вх:
 HL - адрес буфера
Вых:
 A=0 - ОК
 A=1 - ERROR
 HL  - указатель на буфер с выводом ESP

Вызов:
```
	ld hl,bufer
	call zifi.disconnect_ap
```
	или
```
	_disconnect_ap bufer
```
