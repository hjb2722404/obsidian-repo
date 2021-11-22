服务器设置Cache-Control的方法

# 服务器设置Cache-Control的方法

服务器
网络设置
**Apache**
.htaccess文件

	<filesMatch "\.(ico|gif|jpg|png|jpeg)$">
	ExpiresActive On
	ExpiresDefault "access plus 11 month"
	Header append Cache-Control "public"
	</filesMatch>

**Nginx**
.conf文件

	location ~* ^.+\.(jpg|jpeg|gif|png|ico)$
	{
	expires max;
	}

**IIS**
config.xml文件

	<configuration>
	    <system.webServer>
	        <staticContent>
	            <clientCache cacheControlMode="UseExpires" httpExpires="Tue, 19 Jan 2038 03:14:07 GMT" />
	        </staticContent>
	    </system.webServer>
	</configuration>

[markdownFile.md](../_resources/5423bca7a13522a0b1913aac5d7b31c8.bin)