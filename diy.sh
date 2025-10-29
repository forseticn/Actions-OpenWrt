
# 没有docker  有smartdns mosdns passwall passwall2（lede自带）

# 设置默认IP地址
sed -i 's/192.168.1.1/10.0.0.3/g' package/base-files/files/bin/config_generate

# 清除登陆密码
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings

# drop mosdns and v2ray-geodata packages that come with the source
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

./scripts/feeds update -a
./scripts/feeds install -a

# 移除 openwrt feeds 自带的核心库
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/passwall-packages

# 移除 openwrt feeds 过时的luci版本
rm -rf feeds/luci/applications/luci-app-passwall
git clone https://github.com/xiaorouji/openwrt-passwall package/passwall-luci

# 移除 openwrt feeds 过时的luci版本
rm -rf feeds/luci/applications/luci-app-passwall2
git clone https://github.com/xiaorouji/openwrt-passwall2 package/passwall2-luci

# 替换clash的核心
CORE_DIR="feeds/luci/applications/luci-app-openclash/root/etc/openclash/core"
META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-meta-linux-amd64.tar.gz"
rm -rf ${CORE_DIR}
mkdir -p ${CORE_DIR}
wget -qO- ${META_URL} | tar xz -C ${CORE_DIR}
chmod +x ${CORE_DIR}/clash-meta
