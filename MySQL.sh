#!/bin/bash
echo -e '\033[1;31m ********************************此脚本自动化安装MySQL******************************** \033[0m'
echo -e '\033[1;31m 开始安装mysql最新稳定版5.7（实际上为社区版本)\033[0m'
echo -e '\033[1;31m 下载mysql安装包 \033[0m'
wget http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
echo -e '\033[1;31m 安装mysql依赖 \033[0m'
yum localinstall -y mysql57-community-release-el7-11.noarch.rpm
# echo '查看最新稳定版本信息'
# yum repolist all | grep mysql
echo -e '\033[1;31m 安装mysql社区服务器 \033[0m'
yum -y install mysql-community-server
echo -e '\033[1;31m 修改mysql配置文件 \033[0m'
sed -i '$a\federated'  /etc/my.cnf
sed -i '$a\max_connections = 2000'  /etc/my.cnf
sed -i '$a\max_allowed_packet = 64M'  /etc/my.cnf
echo -e '\033[1;31m 设置mysql开机启动 \033[0m'
systemctl enable mysqld
echo -e '\033[1;31m 启动mysql \033[0m'
systemctl start mysqld
echo -e '\033[1;31m 查看mysql启动状态 \033[0m'
systemctl status mysqld
echo -e '\033[1;31m 查看mysql随机密码 \033[0m'
ss=`sed -n '6p' /var/log/mysqld.log`
random_psw=${ss:90:102}
echo -e "\033[1;31m 随机密码为:\033[0m \033[42;34m ${random_psw} \033[0m"
echo -e '\033[1;31m 修改mysql密码为：123456 \033[0m'
echo -e '\033[1;31m 请复制随机密码登录mysql \033[0m'
echo -e '\033[1;31m 设置mysql密码为123456：\033[0m 
mysql -u root -p${random_psw} -e "set global validate_password_policy=0;set global validate_password_length=4;ALTER USER USER() IDENTIFIED BY "123456";grant all privileges on *.* to "root" @"%" identified by "123456";flush privileges;"
echo -e "\033[1;32m mysql密码设置完毕！ \033[0m"
echo -e "\033[1;31m 清除yum安装包 \033[0m"
yum -y clean all
exit
