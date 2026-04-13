#!/bin/bash

# ================================
# 基础设置
# ================================

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.3/g' package/base-files/files/bin/config_generate

# 清空密码
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings


# ================================
# OpenClash
# ================================

echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-openclash-zh-cn=y" >> .config


# ================================
# 依赖
# ================================

echo "CONFIG_PACKAGE_kmod-tun=y" >> .config
echo "CONFIG_PACKAGE_dnsmasq-full=y" >> .config
echo "CONFIG_PACKAGE_iptables=y" >> .config


# ================================
# Clash Meta 内核（x86）
# ================================

mkdir -p files/etc/openclash/core

wget -O files/etc/openclash/core/clash_meta \
https://github.com/MetaCubeX/Clash.Meta/releases/latest/download/clash.meta-linux-amd64

chmod +x files/etc/openclash/core/clash_meta


# ================================
# 默认启动
# ================================

mkdir -p files/etc/uci-defaults

cat > files/etc/uci-defaults/99-openclash <<EOF
uci set openclash.config.enable=1
uci commit openclash
EOF
