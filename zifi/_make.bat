set prog=demo-ts-conf
rem #%frompage=02
rem #%topage=61

for %%i in ( %prog%.asm ) do sjasmplus --labels %%i

if EXIST %prog%.lab (
 rem # sed -i "s/${frompage}:/${topage}:/g" %prog%.lab
 sed -i "s/main\./m\./g" %prog%.lab
 sed -i "s/zifi\./z\./g" %prog%.lab
 sed -i "s/string\./s\./g" %prog%.lab
 sed -i "s/uart_ts_zifi\./utz\./g" %prog%.lab
)
