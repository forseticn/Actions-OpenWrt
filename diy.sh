
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


# 替换 Clash 核心
echo "Replacing Clash Meta Core..."
CLASH_CORE_URL="https://github.com/MetaCubeX/mihomo/releases/download/v1.18.3/mihomo-linux-amd64-compatible.gz"
mkdir -p ./files/etc/openclash/core/
wget -qO- $CLASH_CORE_URL | gunzip > ./files/etc/openclash/core/clash_meta
chmod +x ./files/etc/openclash/core/clash_meta

