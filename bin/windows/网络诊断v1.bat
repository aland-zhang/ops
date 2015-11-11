@echo off
rem ## version 1.9.3 @ 2015/4/17
rem ## via NosmoKing
rem ��������
chcp 936 >nul
color fc
title ��������Ϲ��ߡ�v1.9.3 ^| ���д��ţ������½� :-)

set s_URLS=tmpURLs.txt
set s_Date=%date:~5,2%%date:~8,2%
set s_Hour=%time:~0,2%

if /i %s_Hour% LSS 10 (
	set s_Hour=0%time:~1,1%
	color 2f
)

rem Ҫ������ַ�б����£�
rem -------------------------

echo www.qq.com >%s_URLS%
echo www.163.com >>%s_URLS%

rem -------------------------

echo.

goto MENU

rem ============================================================================================
:MENU
echo.
echo [+] ���ã���ѡ��
echo.
echo               [1] ���٣��ӳ٣�
echo              *[2] �Ƽ����ӳ٣�������
echo               [3] ȫ�棨�ӳ٣�������·�ɣ�
echo.
echo               [4] ������־
echo               [8] ˵��
echo               [9] �˵�
echo               [0] �˳�
echo.
set OPT=2
set /p OPT=�������Ӧ���֣�
if %OPT%==1 goto FASTTEST
if %OPT%==2 goto DOTEST
if %OPT%==3 goto FULLTEST
if %OPT%==4 goto LOGFILE
if %OPT%==8 goto TEST
if %OPT%==9 goto MENU
if %OPT%==0 goto THEEND


rem [Simple Test]
:TEST
set s_Time=%s_Hour:~0,2%%time:~3,2%%time:~6,2%
set s_File=result_%s_Date%_%s_Time%.txt
echo ������Խ�����ļ��������������ĸ�ʽ��
echo %s_File%
echo.
setlocal EnableDelayedExpansion
echo ���Ե���ַ������
for /F %%i in (%s_URLS%) do (
    set www=%%i
    echo !www!
)
endlocal
echo.
pause
goto MENU


rem [Fast Test]
:FASTTEST
set s_Time=%s_Hour:~0,2%%time:~3,2%%time:~6,2%
set s_File=result1_%s_Date%_%s_Time%.txt
echo.
echo [+] ע��Ԥ����ʱ1-2���ӣ���������浽���� %s_File% ��
echo [-] �����У����Ե�Ƭ��..
echo.
echo. >> %s_File%
echo ---------��ʼʱ�䣺[%date%  %time%]  >> %s_File%
echo. >> %s_File%

for /F %%i in (%s_URLS%) do (
echo. >> %s_File%
echo ========================================== >> %s_File%
echo. >> %s_File%

echo.
echo [+] [1/1]
echo. >> %s_File%
echo [-]  ���У�ping -n 20 %%i
echo $$ ping -n 20 %%i >> %s_File%
ping %%i -n 20 >> %s_File%
echo. >> %s_File%

echo. >> %s_File%
echo __________________________________________ >> %s_File%
echo. >> %s_File%
)

echo.
echo  ���Խ�����
echo. >> %s_File%
echo ---------����ʱ�䣺[%date%  %time%]  >> %s_File%
echo. >> %s_File%
goto EOF


rem [Do Test]
:DOTEST
set s_Time=%s_Hour:~0,2%%time:~3,2%%time:~6,2%
set s_File=result2_%s_Date%_%s_Time%.txt
echo.
echo [+] ע��Ԥ����ʱ2-3���ӣ���������浽���� %s_File% ��
echo [-] �����У����Ե�Ƭ��..
echo.
echo. >> %s_File%
echo ---------��ʼʱ�䣺[%date%  %time%]  >> %s_File%
echo. >> %s_File%

for /F %%i in (%s_URLS%) do (
echo. >> %s_File%
echo ========================================== >> %s_File%
echo. >> %s_File%

echo.
echo [+] [1/2]
echo. >> %s_File%
echo [-]  ���У�ping -n 20 %%i
echo $$ ping -n 20 %%i >> %s_File%
ping %%i -n 20 >> %s_File%
echo. >> %s_File%

echo. 
echo [+] [2/2]
echo. >> %s_File%
echo [-]  ���У�nslookup %%i
echo $$ nslookup %%i >> %s_File%
nslookup %%i >> %s_File%
echo. >> %s_File%


echo. >> %s_File%
echo __________________________________________ >> %s_File%
echo. >> %s_File%
)

echo.
echo  ���Խ�����
echo. >> %s_File%
echo ---------����ʱ�䣺[%date%  %time%]  >> %s_File%
echo. >> %s_File%
echo.
echo [+] �����������뽫���ɵĽ�������ͷ���Ա��
echo.

goto EOF


rem [Full Test]
:FULLTEST
set s_Time=%s_Hour:~0,2%%time:~3,2%%time:~6,2%
set s_File=result3_%s_Date%_%s_Time%.txt
echo.
echo [+] ע��Ԥ����ʱ3-5���ӣ���������浽���� %s_File% ��
echo [-] �����У����Ե�Ƭ��..
echo.
echo. >> %s_File%
echo ---------��ʼʱ�䣺[%date%  %time%]  >> %s_File%
echo. >> %s_File%

for /F %%i in (%s_URLS%) do (
echo. >> %s_File%
echo ========================================== >> %s_File%
echo. >> %s_File%

echo.
echo [+] [1/3]
echo. >> %s_File%
echo [-]  ���У�ping -n 20 %%i
echo $$ ping -n 20 %%i >> %s_File%
ping %%i -n 20 >> %s_File%
echo. >> %s_File%

echo. 
echo [+] [2/3]
echo. >> %s_File%
echo [-]  ���У�nslookup %%i
echo $$ nslookup %%i >> %s_File%
nslookup %%i >> %s_File%
echo. >> %s_File%

echo. 
echo [+] [3/3]
echo. >> %s_File%
echo [-]  ���У�tracert -d %%i
echo $$ tracert -d %%i >> %s_File%
tracert -d %%i >> %s_File%
echo. >> %s_File%

echo. >> %s_File%
echo __________________________________________ >> %s_File%
echo. >> %s_File%
)

echo.
echo  ���Խ�����
echo. >> %s_File%
echo ---------����ʱ�䣺[%date%  %time%]  >> %s_File%
echo. >> %s_File%
echo.
echo [+] �����������뽫���ɵĽ�������ͷ���Ա��
echo.

goto EOF


rem ============================================================================================

:LOGFILE
rem today=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%.%time:~9,2%
set today=%date:~5,2%-%date:~8,2%-%date:~0,4%
set targdir=��־�ļ�
set logdir="%USERPROFILE%\Documents"

ver|find "5." >nul
if %errorlevel% == 0 (
rem win7���°汾��ϵͳ���ҵ��ĵ�·����Ҫ��ѯ����Ϊ�����İ��ϵͳ���޸���Ĭ�ϵ�·��
rem set logdir="%USERPROFILE%\My Documents"

for /F "tokens=1,2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User shell Folders" ^| find /I "Personal"') do set logdir=%%k

)

echo.
echo [+] �����û�����־�ļ����ļ��С�%targdir% ���У�
echo.
echo [-] �������ڣ�%date%
echo     _______________________________
echo.

if not exist %targdir%\ (
echo [-] �½����ļ��� ��%targdir%��
mkdir %targdir%\
)

echo. 
echo [-] ��ѯ�����ҵ��ĵ�����·��Ϊ %logdir%
echo.
echo     _______________________________
echo.
echo [+] ׼�������µ���־��ȡ����������Ķ������ļ���
rem ��xcopy���copy
rem copy "%logdir%\logs\"*.log %targdir%\
echo [-] ����-Ӧ�ó���-������־��
xcopy /C /D:%today% /Y "%logdir%\logs\"*.log* %targdir%\

echo.
echo [*] ��������ɡ����齫��־�ļ�ѹ���󷢸��ͷ���Ա��
echo     _______________________________

goto EOF


:EOF
echo.
pause
goto MENU

:THEEND
echo.
if exist %s_URLS% (
del %s_URLS%
)
exit


@echo on