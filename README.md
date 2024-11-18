## Serv00 部署 AList

实现真正的访问即保活，访问即唤醒。

实现重启进程自动更新最新版的Alist，运行 AList

搭建视频演示：https://blog.jnpan.top/001%20Serv00搭建AList

---

### 部署 Alist 前的一些准备工作

**注册账号**

首先去serv00的官网[注册一个账号](https://www.serv00.com/offer/create_new_account)，最好不要使用国内邮箱。

![a130f3ba893c648e19b9b6f3b52491fc](https://test.jnpan.top/d/OneDrive/图床/386852680-53a652e9-0968-4b87-8fd5-9894d218b748.png)

**接着你可以在邮箱里收到你的注册信息的邮件：**

![10b49b9bc2a1f096495583c666a7335b](https://test.jnpan.top/d/OneDrive/图床/386852908-6b484360-e218-4d2c-91a6-eb989a263f86.png)

**登入DevilWEB webpanel进行操作：**

![image](https://test.jnpan.top/d/OneDrive/图床/386854136-17740c09-0455-47d8-a3ad-a7148e3e7100.png)

**首先去左侧的Additional Service选项卡中，找到Run your own applications选项，将其设置为允许：**

![image](https://test.jnpan.top/d/OneDrive/图床/386853609-0b276ff2-6a87-489b-aaf5-703f2b06f575.png)

**接着去Port reservation选项卡，使用Add port功能，随机添加两个TCP端口：**

![image](https://test.jnpan.top/d/OneDrive/图床/386853818-12de6a50-67c9-4555-8f2d-37e4ebd2e915.png)

记下你添加的端口，后面要用。

**接着去Port reservation选项卡，使用Add database功能新建一个数据库：**

(可跳过该步骤)

![1233ed26bca7aafe857c7bcaa77b0a59](https://test.jnpan.top/d/OneDrive/图床/386856956-08468b52-990c-4f68-958b-c6397786cc81.png)

密码要求含有大写字母、小写字母和数字三种字符，且长度必须超过6个字符。

记下你添加的数据库名称、用户名和密码，后面要用。

**接着去WWW Websites选项卡，使用Add website功能新建一个Node.js类型的网站**

可删除原来的xxx.serv00.net并重新使用xxx.serv00.net

![新建Node.js类型的网站](https://test.jnpan.top/d/OneDrive/图床/368005812-b8ef1f8b-edcd-4cee-9510-a4ca096de1b0.jpeg)

最后点击下方的 Add 按钮进行生成。

**自定义域名**

(使用xxx.serv00.net二级域名可跳过该步骤)

接着去 SSL 选项卡，然后点击上方菜单栏中的 WWW websites ，复制第一个 IP Address ，并在网站管理处添加 A 记录

![自定义域名](https://test.jnpan.top/d/OneDrive/图床/368006185-146db739-256a-4e52-b080-ad1c2e64896c.jpeg)

**生成一个 Let's Encrypt 证书：**

(可跳过该步骤)

接着去 SSL 选项卡，然后点击上方菜单栏中的 WWW websites ，点击第一个 IP Address 最右侧的 Manage 按钮，再点击上方菜单栏中的 Add certificate 按钮，Type 选择 Generate Let's Encrypt certificate， Domain任选一个即可，最后点击下方的 Add 按钮进行生成。

![Manage](https://test.jnpan.top/d/OneDrive/图床/368006428-0e9f7dfe-dfe4-4bf7-9c6e-6c87ee0b0677.jpeg)

![Add certificate](https://test.jnpan.top/d/OneDrive/图床/368006309-48e74666-633a-4f29-a2cd-6363e78f3514.jpeg)

---

### 部署 Alist

**接着使用SSH登入到你的账户，我使用的SSH客户端是[Termius](https://termius.com)**

![SSH](https://test.jnpan.top/d/OneDrive/图床/368006553-8b53ddc3-123f-4d08-944c-3a3922473b75.jpeg)

**进入 nodejs 的工作目录：**

~~~
cd ~/domains/网站/public_nodejs
~~~

记得把网站替换成你的网站

**下载AList和运行Node.js的基础文件：**

~~~
bash <(curl -s https://raw.githubusercontent.com/jinnan11/serv00-alist/main/install_alist.sh)
~~~

![SSH](https://test.jnpan.top/d/OneDrive/图床/368006643-96fc3313-955b-41e3-babf-986096fca470.jpeg)

**根据提示修改相关端口号。**

进入File manager选项卡，进入~/domains/网站/public_nodejs路经

右键点击文件，选择View/Edit > Source Editor，进行编辑

首次使用需要在Choose another editor添加Source Editor

![Source Editor](https://test.jnpan.top/d/OneDrive/图床/368006731-5de75781-0cd9-420d-a398-12b020139aeb.jpeg)

1. app.js 第13行端口号需要和data/config.json中的第26行的端口号保持一致

   第50行的端口号是 Aria2 即离线下载用的

![app.js](https://test.jnpan.top/d/OneDrive/图床/368006913-84089bb6-d0dd-4af1-abcc-6ea60c108f4d.jpeg)



2. 修改data/config.json

   第4行的CDN可以在[Alist的官方文档](https://alist.nn.ci/zh/config/configuration.html#cdn)找到，选择你本地网络连接速度最快的一个。(可跳过不填)

   第7~18行的database部分，type需要改成 mysql ，host填写你在注册邮件中看到的mysql的地址，port是默认的3306，用户名、密码、数据库名则按照你创建的情况进行填写，table_prefix填写 ALIST_ (可跳过不填)

   第26行的端口号需要和app.js中的第13行端口号保持一致

   第83行的端口号5246改为0

![image](https://test.jnpan.top/d/OneDrive/图床/386860143-7baee27a-27f0-4c0a-b8e6-3be2227042b4.png)

   改完之后，点击save保存

**启动一次AList，查看运行是否正常**

~~~
./web.js server
~~~

![启动AList](https://test.jnpan.top/d/OneDrive/图床/368007143-e2b04370-7506-4c12-9a8f-1f02ab99bfcf.jpeg)

(没有填写数据库是不显示管理员用户密码的，可以输入这个指令随机生成一个AList密码）

~~~
./web.js admin random
~~~

运行正常，记得把管理员用户的密码记住。接着使用Ctrl+c停止运行。

**安装npm22:**

~~~
npm22 install
~~~

![安装npm22](https://test.jnpan.top/d/OneDrive/图床/368007236-2054252d-c406-41de-ab9c-30aff1fb11ae.jpeg)


访问您的网站

![槿南盘](https://test.jnpan.top/d/OneDrive/图床/368008677-ab6b52dd-fb96-497e-a7a6-ab87b0b996b1.jpeg)


---

### 自动启动

你可以通过访问网站对项目进行唤醒，如果你需要保活，可以使用以下公共服务对网页进行监控：

1. [cron-job.org](https://console.cron-job.org)
2. [UptimeRobot](https://uptimerobot.com/) 

同时，你也可以选择自建 [Uptime-Kuma](https://github.com/louislam/uptime-kuma) 等服务进行监控。

---

### 常见问题

**如何更新AList**

   SSH 登录 Serv00，输入以下命令：
   
   ~~~
   killall -u $(whoami)
   ~~~

   访问网站

**离线下载 Aria2 如何使用**

   管理-设置-其他-Aria2 地址

   ~~~
   http://localhost:6800/jsonrpc
   ~~~

   6800改为app.js中，第50行的端口号，点设置Aria2

   ![image](https://test.jnpan.top/d/OneDrive/图床/386864712-bf608abd-cccf-4e2d-803f-d26f456b2655.png)


**国内为什么访问不了网站**

   Serv00部分服务器不定期屏蔽国内IP。

   套一层CF 或 使用代理工具，访问网站

**为什么挂载不了国内网盘**

   Serv00部分服务器不定期屏蔽国内IP。

   看邮件 SSH/SFTP server address

   ~~~
   s7.serv00.com = S7
   s8.serv00.com = S8
   ~~~

   请自行访问测试站查看支持情况：
   
   测试站：https://test.jnpan.top

---

### 本教程常见指令

**随机生成一个AList密码**

~~~
./web.js admin random
~~~

(需要cd ~/domains/网站/public_nodejs路经下运行)

**关闭用户所有进程**

~~~
killall -u $(whoami)
~~~

---

### 相关参考网站

使用Serv00免费虚拟主机部署Alist：https://zhuanlan.zhihu.com/p/680607217

Serv00 搭建各种服务：https://saika.us.kg/2024/01/27/serv00_logs

Serv00 进程保活最终解决方案：https://saika.us.kg/2024/08/15/serv00-keep-alive
