@echo off
color 2f
title IP�л�

:menu
echo.
echo        �˵���
echo            1. 192.168.10.120
echo            2. 192.168.20.120
echo            3. ��ʾ��ǰIP��
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
if /i %choice%==1 goto rule_10
if /i %choice%==2 goto rule_20
if /i %choice%==3 goto rule_show
if /i %choice%==9 goto menu
if /i %choice%==0 goto end

:warn
echo ��Ч�˵�,������ѡ�� & goto start

:rule_10
echo ���Ժ�...
netsh interface ip set address name="��������" static 192.168.10.120 255.255.255.0 192.168.10.1 1
netsh interface ip set dns "��������" static 202.96.128.86 primary
goto start


:rule_20
netsh interface ip set address name="��������" static 192.168.20.120 255.255.255.0 192.168.20.1 1
netsh interface ip set dns "��������" static 202.96.128.86 primary
goto start


:rule_show
ipconfig /all|findstr IPv4|findstr ��ѡ
goto start


:end
exit
@echo on