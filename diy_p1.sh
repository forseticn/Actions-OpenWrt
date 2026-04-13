#!/bin/sh

# 清理旧版本OpenClash
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/*/luci-app-openclash
rm -rf package/OpenClash

# 拉最新OpenClash
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/OpenClash

