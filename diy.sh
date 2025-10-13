
# 没有docker  有smartdns mosdns passwall passwall2（lede自带）
#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 设置默认IP地址
sed -i 's/192.168.1.1/10.0.0.3/g' package/base-files/luci2/bin/config_generate

# 清除登陆密码
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings


# 替换 Passwall / Passwall2 / MosDNS
rm -rf feeds/smpackage/luci-app-passwall
svn export https://github.com/fw876/helloworld/trunk/luci-app-passwall feeds/smpackage/luci-app-passwall

rm -rf feeds/smpackage/luci-app-passwall2
svn export https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 feeds/smpackage/luci-app-passwall2

rm -rf feeds/smpackage/mosdns
svn export https://github.com/sbwml/luci-app-mosdns/trunk/mosdns feeds/smpackage/mosdns

# 替换 Clash / MosDNS 二进制
mkdir -p ./files/etc/openclash/core
mkdir -p ./files/usr/bin

wget -qO- https://github.com/MetaCubeX/mihomo/releases/download/v1.18.3/mihomo-linux-amd64-compatible.gz | gunzip > ./files/etc/openclash/core/clash_passwall
wget -qO- https://github.com/vernesong/OpenClash/releases/download/ClashMeta-v1.18.3/clash_meta.gz | gunzip > ./files/etc/openclash/core/clash_passwall2
wget -qO- https://github.com/sbwml/mosdns/releases/download/v0.3.1/mosdns_linux_amd64.gz | gunzip > ./files/usr/bin/mosdns

chmod +x ./files/etc/openclash/core/* ./files/usr/bin/mosdns
