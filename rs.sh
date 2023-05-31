#!/bin/bash

echo "过滤出包含 Cert success 字符串的域名"
grep -l "Cert success" *.log | sed 's/.log//g' > rs.txt

while read line
do

if [ ! -d cert/$line ]; then
    mkdir cert/$line
fi

echo "移动 $line 证书及私钥到cert目录下"

if [ ! -e /www/server/panel/vhost/cert/$line ]; then
    mkdir /www/server/panel/vhost/cert/$line
fi

mv /root/.acme.sh/$line/fullchain.cer /www/server/panel/vhost/cert/$line/fullchain.pem
mv /root/.acme.sh/$line/$line.key     /www/server/panel/vhost/cert/$line/privkey.pem

rm -rf /root/.acme.sh/$line

echo "从 domain.txt 中删除 $line"
sed -i "/${line}/d" domain.txt

done < rs.txt

rm -f *.log rs.txt
