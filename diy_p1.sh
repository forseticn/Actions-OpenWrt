#!/bin/sh

echo "== 删除旧版 OpenClash =="

rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/*/luci-app-openclash

echo "== 拉取最新版 OpenClash =="

git clone https://github.com/vernesong/OpenClash.git package/OpenClash
