#!/bin/bash


# 安装acme.sh curl https://get.acme.sh | sh -s email=my@example.com

# 网站目录路径，下面申请时，会通过域名拼接出完成路径
web_path=/www/wwwroot/

while read line  || [[ -n ${line} ]]
do

echo "域名 $line 开始申请，加入后台运行。"
nohup /root/.acme.sh/acme.sh --issue -d $line --webroot $web_path$line > $line.log 2>&1 &

done < domain.txt

echo ""
echo "##################################################"
echo "执行 sh status.sh 可以监控后台申请进程数及成功数"
echo "当 当前运行中的进程数 为 0 时，则全部进程执行完毕，可以执行 sh rs.sh 脚本，证书文件会复制到当前目录下的 cert 目录中。"
echo "成功的域名会从 domain.txt 中删除，可以执行 sh apply.sh 继续申请证书，直至成功。"
echo "##################################################"