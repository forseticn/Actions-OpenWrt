
# 没有docker  有smartdns mosdns passwall passwall2（lede自带）

# 修改默认 IP（务必在 feeds 更新之前执行）
CFG_FILE=$(find package/base-files -name config_generate)
[ -n "$CFG_FILE" ] && sed -i 's/192.168.1.1/10.0.0.3/g' "$CFG_FILE"

# 清除默认登录密码（root 无密码）
ZZZ_FILE="package/lean/default-settings/files/zzz-default-settings"
[ -f "$ZZZ_FILE" ] && sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' "$ZZZ_FILE"

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
