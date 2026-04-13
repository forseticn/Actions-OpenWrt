#!/bin/bash

# ================================
# 基础设置（保留你原有逻辑）
# ================================

# 设置默认IP地址
sed -i 's/192.168.1.1/10.0.0.3/g' package/base-files/files/bin/config_generate

# 清除登陆密码
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings


# ================================
# OpenClash 核心配置
# ================================

# 启用 OpenClash
echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config

# 中文界面（建议）
echo "CONFIG_PACKAGE_luci-i18n-openclash-zh-cn=y" >> .config


# ================================
# x86 必要依赖（非常关键）
# ================================

# TUN 支持（核心）
echo "CONFIG_PACKAGE_kmod-tun=y" >> .config

# DNS 完整版（避免污染）
echo "CONFIG_PACKAGE_dnsmasq-full=y" >> .config

# 防火墙工具
echo "CONFIG_PACKAGE_iptables=y" >> .config

# 网络调试（可选但推荐）
echo "CONFIG_PACKAGE_ip-full=y" >> .config


# ================================
# 内置 Clash Meta 内核（x86_64）
# ================================

mkdir -p files/etc/openclash/core

wget -O files/etc/openclash/core/clash_meta \
https://github.com/MetaCubeX/Clash.Meta/releases/latest/download/clash.meta-linux-amd64

chmod +x files/etc/openclash/core/clash_meta


# ================================
# 默认启动 OpenClash（可选）
# ================================

mkdir -p files/etc/uci-defaults

cat > files/etc/uci-defaults/99-openclash <<EOF
uci set openclash.config.enable=1
uci commit openclash
EOF
