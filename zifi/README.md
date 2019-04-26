# z80-sdk zifi module

Описание: Библиотека ф-ций для работы через zifi модуль + демо программа.

Цель: сделать минимальной и простой набор ф-ций для работы с данными через Zifi

Именование макросов: Макрос именуется названием ф-ции с префиксом _zifi

## TO DO / In progress / Done

- [x] init
- [x] list_ap
- [x] connect_ap
- [x] current_ip
- [x] disconnect_ap
- [x] ping
- [x] open_tcp
- [x] close_tcp
- [ ] send
- [ ] receive

- [x] Обработка ситуации с таймаутом
- [ ] Работа с реестром подключений (выделение номера, удаление номера)

- [ ] Рефактор таймаута

# Функции и макросы модуля

## init - Инициализация Zifi
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

## list_ap - Получить список доступных точек доступа
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
	_zifi_list_ap bufer
```

## current_ip - Получить текущий IP адрес
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
	_zifi_curremt_ip bufer
```

## connect_ap - Подключиться к точке доступа
Вх:
 HL - адрес буфера
 DE - адрес строки формата <ssid>.<pass>,0
Вых:
 A=0 - ОК
 A=1 - ERROR
 HL  - указатель на буфер с выводом ESP

Вызов:
```
	ld hl,bufer
	ld de,input
	call zifi.connect_ap
```
	или
```
	_zifi_connect_ap bufer, input
```

## disconnect_ap - Отключиться от точки доступа
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
	_zifi_disconnect_ap bufer
```

## ping - PING адреса
Вх:
 HL - адрес буфера
 DE - адрес строки формата <addr>,0
Вых:
 A=0 - ОК
 A=1 - ERROR
 HL  - указатель на буфер с выводом ESP

Вызов:
```
	ld hl,bufer
	ld de,addr
	call zifi.ping
```
	или
```
	_zifi_ping bufer, addr
```

## open_tcp - Открыть TCP соединение
Вх:
     HL - буфер для операций.
     DE - address,0,port,0
     DE` - адрес приемного буфера для данного канала. Адрес будет зарегистрирован в реестре. При входящие данных по данному дескриптору будут отправляться в этот буфер
     BC - максимальный размер буфера
Вых:
     HL - указатель на сообщение
      A - 0-9 - Connection ID, #FF - ERROR

Вызов:
```
	ld hl,res_bufer
	ld de,addr_url
	exx
	ld de,rcv_buf
	BC,512
	call zifi.open_tcp
```
	или
```
	_zifi_open_tcp obufer, addr, rcv_buf, 512
```

## close_tcp - закрыть TCP соединение
Вх:
     HL - буфер для операций.
     A - номер соединения
Вых:
     HL - указатель на сообщение
	 A=0 - ОК
 	 A=1 - ERROR

Вызов:
```
	ld hl,bufer
	ld a,1
	call zifi.close_tcp
```
	или
```
	LD A,1
	_zifi_close_tcp bufer
```
