@echo off
color 2f
title basic information
IF EXIST zero.txt DEL zero.txt

echo һ���򵥵�ʾ������ȡ���̣�IP�Ȼ�����Ϣ
echo.
echo ���,%USERNAME%��>zero.txt 
VER >>zero.txt
FOR /F "tokens=1,2,3,4 delims=- " %%a in ('date /t') Do @ECHO ������%%a %%b >>zero.txt
echo _____________________������Ϣ_______________________ >>zero.txt
FOR %%i in ( C D E F G H I J K L M N O P Q R S T U V W X Y Z ) DO (
IF EXIST %%i:\ @ECHO %%i >> Drivers.txt
)
echo �����ԵĴ��̷���������>> zero.txt
type Drivers.txt >> zero.txt
echo.
rem FOR /F %%i IN (Drivers.txt) DO dir /a /o %%i:\ >>zero.txt
echo _____________________IP ��Ϣ_________________________ >>zero.txt
ipconfig /all >>zero.txt

IF EXIST Drivers.txt DEL Drivers.txt

echo finished!
pause
@echo on


