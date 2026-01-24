#!/bin/bash

# 设置默认IP地址
sed -i 's/192.168.1.1/10.0.0.3/g' package/base-files/files/bin/config_generate

# 清除登陆密码
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings

set -e

echo "==> Step 1: 更新官方 feeds（基础设施，不能删）"
./scripts/feeds update -a
./scripts/feeds install -a

echo "==> Step 2: 移除 feeds 中会和 passwall 冲突的包（只删 net 代理相关）"
rm -rf feeds/packages/net/{ \
xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria, \
ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust, \
shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client, \
v2ray-plugin,xray-plugin,geoview,shadow-tls \
}

rm -rf feeds/luci/applications/luci-app-passwall

echo "==> Step 3: 集成 mosdns（完整仓库，含核心+LuCI）"
rm -rf package/mosdns package/v2ray-geodata
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

echo "==> Step 4: 集成 passwall2 及其依赖"
rm -rf package/passwall-packages package/passwall-luci package/passwall2

git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/passwall-packages
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall package/passwall-luci
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall2 package/passwall2
