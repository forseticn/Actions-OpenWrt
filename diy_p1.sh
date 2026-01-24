#!/bin/bash

echo 'src-git passwall_packages https://github.com/OpenWrt-Passwall/openwrt-passwall-packages.git;main' >>feeds.conf.default
echo 'src-git passwall https://github.com/OpenWrt-Passwall/openwrt-passwall.git;main' >>feeds.conf.default
echo 'src-git passwall2 https://github.com/OpenWrt-Passwall/openwrt-passwall2.git;main' >>feeds.conf.default
