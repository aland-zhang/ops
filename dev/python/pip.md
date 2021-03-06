# 使用pip来管理python包
2018/11/19

### 安装pip
##### linux
`yum install python-pip`

##### windows
安装python时，默认已经安装pip


### 使用pip安装包
###### Linux
```bash
[root@tvm-test ~]# pip install Django==1.6.0
Collecting Django==1.6.0
/usr/lib/python2.6/site-packages/pip/_vendor/requests/packages/urllib3/util/ssl_.py:90: InsecurePlatformWarning: A true SSLContext object is not available. This prevents urllib3 from configuring SSL appropriately and may cause certain SSL connections to fail. For more information, see https://urllib3.readthedocs.org/en/latest/security.html#insecureplatformwarning.
  InsecurePlatformWarning
  Downloading Django-1.6-py2.py3-none-any.whl (6.7MB)
    100% |████████████████████████████████| 6.7MB 74kB/s
Installing collected packages: Django
Successfully installed Django-1.6
[root@tvm-test ~]# python -c "import django;print(django.get_version())"
1.6

【Win】
D:\apps\Python34\Scripts>pip install Django
You are using pip version 6.0.8, however version 7.1.0 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
Collecting Django
  Downloading Django-1.8.3-py2.py3-none-any.whl (6.2MB)
    100% |################################| 6.2MB 75kB/s
Installing collected packages: Django
D:\apps\Python34>python -c "import django;print(django.get_version())"
1.8.3

Successfully installed Django-1.8.3
```


### 其他用法
##### 指定版本号安装
`pip install Django==1.6.0`

##### 卸载
`pip uninstall Django`

##### 从文本文件中安装指定的包
`pip install -r requirements.txt`

##### 导出当前环境的依赖包的信息
`pip freeze >requirements.txt`

##### 指定从阿里云的 pip 仓库安装
```bash
~]# cat requirements.txt
-i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
Pillow==5.0.0

~]# pip install -r requirements.txt
```

### 版本问题
##### 在windows下安装 ovirt-engine-sdk-python 时遇到异常
```
# pip install ovirt-engine-sdk-python
Please specify --curl-dir=/path/to/built/libcurl
```
pycurl异常，，官网是win32的版本，安装后，后续使用可能会报错：
pycurl DLL load failed: %1 不是有效的 Win32 应用程序。

可以在这里找到amd64的版本，然后用pip手动安装：
http://www.lfd.uci.edu/~gohlke/pythonlibs/#pycurl
假设下载后，路径为：D:/pycurl-7.19.5.1-cp27-none-win_amd64.whl

安装：
```
C:\Users\admin>pip install D:/pycurl-7.19.5.1-cp27-none-win_amd64.whl
Processing d:\pycurl-7.19.5.1-cp27-none-win_amd64.whl
Installing collected packages: pycurl
Successfully installed pycurl-7.19.5.1
```

##### 升级
pip install --upgrade ovirt-engine-sdk-python
如果又遇到pycurl异常的提示:
```
C:\Users\admin>pip install D:/pycurl-7.19.5.1-cp27-none-win_amd64.whl
Processing d:\pycurl-7.19.5.1-cp27-none-win_amd64.whl
Installing collected packages: pycurl
Successfully installed pycurl-7.19.5.1

C:\Users\admin>pip install --upgrade ovirt-engine-sdk-python
Collecting ovirt-engine-sdk-python
  Using cached ovirt-engine-sdk-python-3.6.0.3.tar.gz
Collecting lxml>=2.2.3 (from ovirt-engine-sdk-python)
  Using cached lxml-3.5.0.tar.gz
Collecting pycurl>=7.19.0 (from ovirt-engine-sdk-python)
  Using cached pycurl-7.19.5.3.tar.gz
    Complete output from command python setup.py egg_info:
    Please specify --curl-dir=/path/to/built/libcurl

    ----------------------------------------
Command "python setup.py egg_info" failed with error code 10 in c:\users\pc5e16~
1.pen\appdata\local\temp\pip-build-owiy_9\pycurl
```

则尝试 uninstall ovirt-engine-sdk-python 再重新install
```
C:\Users\admin>pip install ovirt-engine-sdk-python
Collecting ovirt-engine-sdk-python
  Using cached ovirt-engine-sdk-python-3.6.0.3.tar.gz
Requirement already satisfied (use --upgrade to upgrade): lxml>=2.2.3 in d:\apps
\python27\lib\site-packages (from ovirt-engine-sdk-python)
Requirement already satisfied (use --upgrade to upgrade): pycurl>=7.19.0 in d:\a
pps\python27\lib\site-packages (from ovirt-engine-sdk-python)
Installing collected packages: ovirt-engine-sdk-python
  Running setup.py install for ovirt-engine-sdk-python
Successfully installed ovirt-engine-sdk-python-3.6.0.3
```


### ZYXW、参考
1. [Django 环境搭建](http://www.ziqiangxuetang.com/django/django-install.html)
