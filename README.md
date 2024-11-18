## Serv00 部署 AList

在serv00上实现一键部署Alist，访问即唤醒、保持活跃，并自动更新到最新版，同时集成Aria2以支持离线下载

搭建视频演示：https://blog.jnpan.top/001%20Serv00搭建AList

### 部署 Alist 前的准备工作

1. **注册账号**
   - 去 [Serv00 官网](https://www.serv00.com/) 注册账号，建议不要使用国内邮箱。
   - 在邮箱中查收注册信息。

2. **登入 DevilWEB webpanel**
   - 进入 Additional Service 选项卡，允许 Run your own applications。
   - 在 Port reservation 选项卡，添加两个随机 TCP 端口并记下。
   - （可选）添加数据库，记下数据库名称、用户名和密码。

3. **新建 Node.js 网站**
   - 在 WWW Websites 选项卡，添加 Node.js 类型的网站。
   - （可选）自定义域名并生成 Let's Encrypt 证书。

### 部署 Alist

1. **使用 SSH 登入账户**
   - 使用 [Termius](https://termius.com/) 或其他 SSH 客户端。
   - 进入 Node.js 工作目录：
     ```bash
     cd ~/domains/网站/public_nodejs
     ```

2. **下载并运行 AList**
   - 执行以下命令：
     ```bash
     bash <(curl -s https://raw.githubusercontent.com/jinnan11/serv00-alist/main/install_alist.sh)
     ```

3. **修改端口号**
   - 在 File manager 中，编辑 `app.js` 和 `data/config.json`，确保端口号一致。
   - 配置 Aria2 端口号（可选）。
   - 配置数据库信息（可选）。

4. **启动 AList**
   - 启动 AList 并查看运行是否正常：
     ```bash
     ./web.js server
     ```
   - （可选）生成随机管理员密码：
     ```bash
     ./web.js admin random
     ```

5. **安装 npm22**
   - 执行以下命令：
     ```bash
     npm22 install
     ```

### 自动启动

- 使用 [cron-job.org](https://console.cron-job.org/) 或 [UptimeRobot](https://uptimerobot.com/) 监控网站。
- 或自建 [Uptime-Kuma](https://github.com/louislam/uptime-kuma) 进行监控。

### 常见问题

1. **如何更新 AList**
   - SSH 登录 Serv00，执行以下命令：
     ```bash
     killall -u $(whoami)
     ```
   - 访问网站。

2. **离线下载 Aria2 配置**
   - 管理-设置-其他-Aria2 地址：
     ```bash
     http://localhost:6800/jsonrpc
     ```
   - 端口号改为 `app.js` 中第 50 行的端口号。

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
