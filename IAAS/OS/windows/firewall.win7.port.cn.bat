@echo off
rem v1.0.2
color 2f
title Windows����ǽ�˿�����

set dport=8000
set direction=out
goto menu

:menu
set rule_name=block_tcp_%direction%_%dport%
echo.
echo        �˵���
echo            1. ������������:      
echo                                   [��������%rule_name%]
echo                                   [����: ����]
echo                                   [�˿�: %dport%]
echo                                   [����: %direction%]
echo            2. ɾ����������:   
echo                                   [������: %rule_name%]
echo            3. �趨�µĶ˿ںͷ���: 
echo                                   [Ĭ��ֵ: �˿�=8000, ����=out]
echo            4. ��ʾ��������:     
echo                                   [������: %rule_name%]
echo            5. ��ʾ����������block_tcp��ͷ�Ĺ���:     
echo                                   [������: �ԡ�block_tcp����ͷ]
echo            8. ����
echo            9. �˵�
echo            0. �˳�
echo        _____________________________________________________________
echo        ע1��ѡ�����֣�Ȼ�󰴻س���
echo.
goto start


:menu_help
echo.
echo  ����������
echo.
echo    ��  ��3���س������趨������ʾ�����£�
echo                          �˿�[8000]=9001���س���
echo                          ����[out]=���س�������Ĭ�ϵ�out��;
echo    ��  ��1���س����������¹���block_tcp_out_9001��������ǽ��
echo    ��  ��4���س�������ʾ��ǰ����block_tcp_out_9001����
echo    ��  ��2���س�����ɾ����ǰ����block_tcp_out_9001����
echo     �ظ��������裬�����µĹ���
echo    ��  ��5���س�������ʾ���������ԡ�block_tcp����ͷ�Ĺ���
echo     ɾ��ǰ������ȷ�ϵ�ǰ�趨�Ķ˿ںͷ���
echo.
goto start


:start
echo.
echo        [1(����),2(ɾ��),3(�趨),4(��ʾ),5(��ʾ����)]
echo        -------------------------------------------------------------
set choice=
set /p choice=��ѡ��
echo.
if /i "%choice%"=="" goto warn
if /i %choice%==1 goto rule_add
if /i %choice%==2 goto rule_del
if /i %choice%==3 goto setting
if /i %choice%==4 goto rule_show
if /i %choice%==5 goto rule_show_all
if /i %choice%==8 goto menu_help
if /i %choice%==9 goto menu
if /i %choice%==0 goto end



:warn
echo ���棡������Ч��������ѡ��& goto start

:rule_add
netsh advfirewall firewall add rule name="%rule_name%" dir=%direction% protocol=tcp remoteport=%dport% action=block
goto start


:rule_del
netsh advfirewall firewall del rule dir=%direction% name="%rule_name%"
goto start


:rule_show
netsh advfirewall firewall show rule dir=%direction% name="%rule_name%"
goto start


:rule_show_all
netsh advfirewall firewall show rule dir=%direction% name=all|findstr block_tcp
goto start


:setting
set dport=8000
set /p dport=�˿�[8000]:
echo %dport%|findstr "[^0-9]"
echo %dport%|findstr "[^0-9]" > nul && goto setting || goto setting_2



:setting_2
set direction=out
set /p direction=����[out]:
echo %direction%|findstr "in out" > nul && goto menu || goto setting_2



:end
exit