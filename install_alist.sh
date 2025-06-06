# 作者: 槿南11
# 主页：https://jinnan.top
# GitHub：https://github.com/jinnan11/serv00-alist
# 版权所有，请勿删除

# 清屏
clear

# 判断是否在 public_nodejs 目录下
if [ "$(basename "$(pwd)")" == "public_nodejs" ]; then
    # 删除残留文件，如果不存在则跳过
    [ -f public/index.html ] && rm public/index.html
    [ -f start.sh ] && rm start.sh
    [ -f alist ] && rm alist
    
    # 判断是否有所需文件
    files=("app.js" "start.sh" "package.json" "web.js")
    urls=(
        "https://raw.githubusercontent.com/jinnan11/serv00-alist/main/alist/app.js"
        "https://raw.githubusercontent.com/jinnan11/serv00-alist/main/alist/start.sh"
        "https://raw.githubusercontent.com/jinnan11/serv00-alist/main/alist/package.json"
        "https://github.com/AlistGo/alist/releases/latest/download/alist-freebsd-amd64.tar.gz"
    )

    for i in "${!files[@]}"; do
        if [ ! -f "${files[$i]}" ]; then
            wget "${urls[$i]}"
        fi
    done

    # 判断是否存在 alist 文件
    if [ -f "alist-freebsd-amd64.tar.gz" ]; then
        # 如果存在，执行以下操作
        tar -xzf alist-freebsd-amd64.tar.gz
        rm alist-freebsd-amd64.tar.gz
        rm -rf temp
        mv alist web.js
        chmod +x web.js
        ./web.js server
    fi

    # 判断是否存在 data 文件夹
    if [ -d "data" ]; then
        # 清屏
        clear

        # 如果存在，显示安装完成信息
        echo -e "已成功安装 Alist！\n"
        echo -e "请在 File manager 中，编辑 app.js 和 data/config.json\n"
        echo -e "作者：https://jinnan.top\nQQ群：244184124 欢迎加入交流~\n"
        
    else
        # 使您能够运行自己的软件
        devil binexec on

        # 删除残留文件，如果不存在则跳过
        [ -f web.js ] && rm web.js
        [ -f start.sh ] && rm start.sh

        # 清屏
        clear

        # 如果不存在，提示信息
        echo "检测到不存在 data 文件夹，请断开重连SSH，再次输入这条指令。"
    fi

else
    # 清屏
    clear
    
    # 显示错误信息
    echo "检测到未在public_nodejs目录下，请确认网站添加的类型是否为nodejs。"
fi
