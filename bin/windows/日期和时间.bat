@echo off
color 2f
title datetime example

:menu
echo.
echo        �˵���
echo            1. ��ʾ
echo            9. �˵���
echo            0. �˳���
echo.
echo        ע��������˵���Ӧ�����֣�ֱ���˳��밴�س���
echo        ________________________________________________
echo.
goto start

:start
echo.
set choice=
set /p choice=�����룺
if /i "%choice%"=="" goto warn
if /i %choice%==1 goto show
if /i %choice%==9 goto menu
if /i %choice%==0 goto end

:warn
echo ��Ч�˵�,������ѡ�� & goto start

:show
set D=%date:~0,4%%date:~5,2%%date:~8,2%
if /i %time:~0,2% LSS 10 ( 
set T=0%time:~1,1%%time:~3,2%%time:~6,2%.%time:~9,2%
) else (
set T=%time:~0,2%%time:~3,2%%time:~6,2%.%time:~9,2%
)
echo %D%_%T%
goto start

:end
exit
@echo on