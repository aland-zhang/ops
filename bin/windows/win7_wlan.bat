@echo off
color 2f
title Windows 7 WLAN

:menu
echo.
echo        �˵���
echo            1. �趨
echo            2. ��
echo            3. �ر�
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
if /i %choice%==1 goto set
if /i %choice%==2 goto open
if /i %choice%==3 goto close
if /i %choice%==9 goto menu
if /i %choice%==0 goto end

:warn
echo ��Ч�˵�,������ѡ�� & goto start

:set
netsh wlan set hostednetwork mode=allow ssid="pcwlan" key="123456"
goto start

:open
netsh wlan start hostednetwork
goto start

:close
netsh wlan stop hostednetwork
goto start

:end
exit
@echo on