## Serv00 部署 AList

在serv00上一键部署alist，并且实现访问即拉起和保持更新最新版

搭建视频演示：[查看链接](https://blog.jnpan.top/001%20Serv00搭建AList)

### 部署 Alist 前的准备工作

1. **注册账号**

   - 去 [Serv00 官网](https://www.serv00.com/) 注册账号，建议不要使用国内邮箱。

      ![image](https://github.com/user-attachments/assets/dc24b285-c7e9-44a2-9588-b656725c8c5e)

   - 在邮箱中查收注册信息。

      ![image](https://github.com/user-attachments/assets/030819cc-075a-4db8-bfd0-1748f5ef995f)

2. **登入 DevilWEB webpanel**

   - 进入 Additional Service 选项卡，允许 Run your own applications。

      ![image](https://github.com/user-attachments/assets/6472ea16-6ce5-469f-a67a-4879f637cffa)

   - 在 Port reservation 选项卡，添加两个随机 TCP 端口并记下。

      ![image](https://github.com/user-attachments/assets/81358b39-ddc7-4936-9268-c5e974bda2cd)

   - （可选）添加数据库，记下数据库名称、用户名和密码。

      ![image](https://github.com/user-attachments/assets/942a5588-3bef-4d53-b85e-cfd7fcf569e6)

3. **新建 Node.js 网站**

   - 在 WWW Websites 选项卡，添加 Node.js 类型的网站。

      ![image](https://github.com/user-attachments/assets/8fddad90-bba6-4253-803e-824f95151469)

   - （可选）自定义域名

      ![image](https://github.com/user-attachments/assets/57e2e9b0-6630-4cd1-b090-b44d14d373a6)

   - （可选）生成 Let's Encrypt 证书。
   
      ![image](https://github.com/user-attachments/assets/ccfb5570-219d-4a70-afe2-6889dd41efa9)

      ![image](https://github.com/user-attachments/assets/5dcdf608-7c51-43aa-9603-7e02a79f2737)

### 部署 Alist

1. **使用 SSH 登入账户**

   - 使用 [Termius](https://termius.com/) 或其他 SSH 客户端。

      ![image](https://github.com/user-attachments/assets/6eb1fed0-ba38-417d-baf9-eb45defb9483)
     
2. **进入 Node.js 工作目录：**

     ```bash
     cd ~/domains/网站/public_nodejs
     ```

3. **下载并运行 AList**

   - 执行以下命令：

     ```bash
     bash <(curl -s https://raw.githubusercontent.com/jinnan11/serv00-alist/main/install_alist.sh)
     ```

      ![image](https://github.com/user-attachments/assets/8055b6f4-62eb-40d1-9ad1-e4458840a7e6)

4. **修改端口号**

   - 在 File manager 中，编辑 app.js 和 data/config.json

      ![image](https://github.com/user-attachments/assets/6dfb2882-f956-4cf9-80d4-8a249e8c9ff5)

   - app.js

      第13行网站端口号
     
      （可选）第 50 行 Aria2 端口号

      ![image](https://github.com/user-attachments/assets/8715b4ac-5d8f-40ea-be3d-a7f39b5cabde)

   - data/config.json

      （可选）CDN可以在[Alist的官方文档](https://alist.nn.ci/zh/config/configuration.html#cdn)找到，请选择你本地网络连接速度最快的一个。
     
      （可选）配置数据库信息。
     
      第 26 行网站端口号，确保和 app.js 中的网站端口号一致。
     
      第 83 行的端口号 5246 改为 0

      ![image](https://github.com/user-attachments/assets/e736d97d-05e6-4c49-9fd7-afb8a201efe7)

5. **启动 AList**

   - 启动 AList 并查看运行是否正常：

     ```bash
     ./web.js server
     ```

      ![image](https://github.com/user-attachments/assets/be741399-fcf8-4e2b-9d44-397c1927b125)

      运行正常，记得把管理员用户的密码记住。接着使用 Ctrl+c 停止运行。

   - （可选）生成随机管理员密码：

     ```bash
     ./web.js admin random
     ```

6. **安装 npm22**

   - 执行以下命令：

     ```bash
     npm22 install
     ```

      ![image](https://github.com/user-attachments/assets/3fecaf82-ed63-4a74-8b6c-22406cd634d3)
     
7. **访问您的网站**

      ![image](https://github.com/user-attachments/assets/09cb34dc-9803-48ea-8148-d25e30187325)

### 自动启动

- 使用 [cron-job.org](https://console.cron-job.org/) 或 [UptimeRobot](https://uptimerobot.com/) 监控网站。

- 或自建 [Uptime-Kuma](https://github.com/louislam/uptime-kuma) 进行监控。

### 常见问题

1. **如何更新 AList**

   - SSH 登录 Serv00，执行以下命令：

     ```bash
     killall -u $(whoami)
     ```

   - 访问您的网站。

2. **离线下载 Aria2 配置**

   - 管理-设置-其他-Aria2 地址：

     ```bash
     http://localhost:6800/jsonrpc
     ```

   - 端口号改为 app.js 中第 50 行的端口号。

      ![image](https://github.com/user-attachments/assets/f18cdd5f-ecec-4c0d-bd0d-1fb49c5f40e1)


3. **国内访问问题**

   - Serv00 部分服务器屏蔽国内 IP，建议使用代理工具或套一层 CF。

4. **挂载国内网盘问题**

   - Serv00 部分服务器屏蔽国内 IP，查看支持情况请访问测试站：https://test.jnpan.top

### 常用指令

- 随机生成 AList 密码：

  ```bash
  ./web.js admin random
  ```
  
- 关闭用户所有进程：

  ```bash
  killall -u $(whoami)
  ```

### 参考网站

- [使用 Serv00 免费虚拟主机部署 Alist](https://zhuanlan.zhihu.com/p/680607217)

- [Serv00 进程保活最终解决方案](https://saika.us.kg/2024/08/15/serv00-keep-alive)
