#!/usr/bin/env bash 
echo -e '\033[1;31m 安装cockpit \033[0m'
yum -y install cockpit
echo -e '\033[1;31m 设置开机自启 \033[0m'
systemctl enable --now cockpit.socket
# echo -e '\033[1;31m 防火墙处理 \033[0m'
# firewall-cmd --permanent --zone=public --add-service=cockpit
# firewall-cmd --reload
echo -e '\033[1;31m 启动cockpit \033[0m'
systemctl start cockpit
echo -e '\033[1;31m 查看cockpit状态 \033[0m'
systemctl status cockpit
echo -e '\033[1;31m 访问http://localhost:9090；使用本机用户名和密码登录 \033[0m'
exit