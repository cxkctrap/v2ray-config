# v2ray-config
v2ray-docker配置工具，自动生成v2ray配置文件和docker-compose文件
## 环境要求
需要安装好docker和docker-compose，安装过程自行百度
## 使用方法
### 开启v2ray
```shell
git clone https://github.com/cxkctrap/v2ray-config.git
cd v2ray-config
```
修改配置文件v2ray.conf中的配置为你想要的,修改方法见v2ray.conf的注释，注意不要带有空行
```shell
docker build -t cxk/v2ray-config ./dockerfiles
```
第一次使用要手动创建镜像，后面我会考虑传到dockerhub上，现在先这样
```shell
docker run --rm -v $(pwd):/root cxk/v2ray-config
```
这样也就完成了所有的配置过程，如果要重新查看配置链接可以查看生成的url.txt文件
```shell
docker-compose up -d
```
然后就可以直接使用docker-compose启动你的v2ray了
### 关闭v2ray
```shell
docker-compose down
```
## 参考
> 1. https://github.com/pengchujin/v2rayDocker  
> 2. https://github.com/233boy/v2ray

