@echo off
rem ## version 0.3 @ 2015/3/26
rem ## via NosmoKing
rem ��������
chcp 936 >nul
color fc
title �л���������DNS�����Թ���Ա������С� ^| ���д��ţ������½� :-)

set s_Hour=%time:~0,2%
if /i %s_Hour% LSS 10 (
	color 2f
)

:menu
echo.
echo        �˵���
echo            1. ��������192.168.1.240
echo            2. ��������223.5.5.5
echo            3. ��ʾ��ǰDNS
echo            9. �˵�
echo            0. �˳�
echo.
echo        ע��������˵���Ӧ�����֣�ֱ���˳��밴�س���
echo        ________________________________________________
echo.
goto start


:start
echo.
set choice=0
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
netsh interface ip set dns "��������" static 192.168.1.240 primary
netsh interface ip set dns "������������" static 192.168.1.240 primary
goto rule_show


:rule_20
netsh interface ip set dns "��������" static 223.5.5.5 primary
netsh interface ip set dns "������������" static 223.5.5.5 primary
goto rule_show


:rule_show
netsh interface ip show dnsservers "��������"
netsh interface ip show dnsservers "������������"
goto start


:end
exit
@echo on