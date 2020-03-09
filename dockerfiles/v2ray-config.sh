#! /bin/bash

# ---- V2Ray 配置文件保存的位置 -----
v2ray_server_config="/etc/v2ray/config.json"
v2ray_client_config="/etc/v2ray/233blog_v2ray_config.json"
old_id="e55c8d17-2cf3-b21a-bcf1-eeacb011ed79"

_load() {
	local _dir="/etc/v2ray/233boy/v2ray/src/"
	. "${_dir}$@"
}

# 载入函数库
. "/etc/v2ray-config/v2ray.sh"

# 读取配置列表
conf_file="/root/v2ray.conf"
. $conf_file

# 生成v2ray配置
mkdir /root/config
config="/etc/v2ray/233boy/v2ray/src/config.sh"
. $config
cp $v2ray_server_config /root/config/config.json
cp $v2ray_client_config /root/config/client-config.json
if [[ $v2ray_transport == [4] ]]; then
	sed -i '58,140d' /root/config/config.json
fi

# 生成caddy配置
if [[ $v2ray_transport == [45] ]]; then
	caddy_config="/etc/v2ray/233boy/v2ray/src/caddy-config.sh"
	. $caddy_config
	cp /etc/caddy/Caddyfile /root/config
	# sed -i 's/127.0.0.1/v2ray/g' /root/config/Caddyfile
	sed -i 's/127.0.0.1//g' /root/config/Caddyfile
else
	echo '' > /root/config/Caddyfile
fi

# 显示v2ray配置信息和订阅链接
create_vmess_URL_config
cp /etc/v2ray/vmess_qr.json /etc/v2rayDocker/sebs.js
cd /etc/v2rayDocker
node v2ray.js | tee /root/url.txt

# 配置docker-compose
if [[ $v2ray_transport == [45] ]]; then
	cp /etc/v2ray-config/compose-caddy.yml /root/docker-compose.yml
	cp /etc/v2ray-config/caddy.sh /root/config/caddy.sh
	chmod +x /root/config/caddy.sh
else
	cp /etc/v2ray-config/compose-v2ray.yml /root/docker-compose.yml
	sed -i "s/v2ray_port/$v2ray_port/g" /root/docker-compose.yml
fi