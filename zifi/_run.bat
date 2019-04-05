set here=%CD%
set prog=demo-ts-conf.sna
set labels=demo-ts-conf.lab
set unreal_path=c:\zx-speccy\Unreal
set unreal=%unreal_path%\unreal.exe

echo test

for %%i in (%prog%) do (
 echo %%i
 if not exist %%i (
  echo no file %%i found
  goto 1
 )
)

echo test1

if exist %unreal%\%labels% (
 delete %unreal%\%labels%
)

rem if exist %labels% (
rem  copy %labels% %unreal%\
rem )

rem if not exist %unreal%\%prog% (
rem  ln -s %here%/%prog% %unreal%\%prog%
rem )

rem #sudo mount -t vfat ~/zx-speccy/unreal-ts/wc.img /mnt/tmp -o loop
rem #if [ $? -ne 0 ];then
rem # echo "error mount image"
rem # exit 1
rem #fi
rem #for i in $prog; do
rem # sudo cp $i /mnt/tmp/WC
rem #done
rem #sudo umount /mnt/tmp

cd %unreal_path%

if exist %unreal%\%labels% (
 %unreal% -l%here%\%labels% %here%\%prog%
) else (
 %unreal% %here%\%prog%
)

:1