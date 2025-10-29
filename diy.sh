#!/bin/bash

# 设置默认IP地址
sed -i 's/192.168.1.1/10.0.0.3/g' package/base-files/files/bin/config_generate

# 清除登陆密码
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings

# 移除旧的 mosdns 和 v2ray-geodata
rm -rf feeds/packages/net/mosdns feeds/packages/net/v2ray-geodata package/mosdns package/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 替换 passwall 系列
rm -rf feeds/packages/net/{xray-core,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/passwall-packages
rm -rf feeds/luci/applications/luci-app-passwall
git clone https://github.com/xiaorouji/openwrt-passwall package/passwall-luci
rm -rf feeds/luci/applications/luci-app-passwall2
git clone https://github.com/xiaorouji/openwrt-passwall2 package/passwall2-luci

# 更新 feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 替换 OpenClash 核心为 Clash Meta (x86_64)
CORE_DIR="feeds/luci/applications/luci-app-openclash/root/etc/openclash/core"
META_URL="https://github.com/MetaCubeX/mihomo/releases/download/v1.19.15/mihomo-linux-amd64-v1-v1.19.15.gz"
rm -rf ${CORE_DIR}
mkdir -p ${CORE_DIR}
wget -qO- ${META_URL} | tar xz -C ${CORE_DIR}
chmod +x ${CORE_DIR}/clash-meta
