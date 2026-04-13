#!/bin/sh

# 清理旧版本OpenClash
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/*/luci-app-openclash
rm -rf package/OpenClash

# 拉最新OpenClash
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/OpenClash

# 调整 Docker 到 服务 菜单
sed -i 's/"admin"/"admin", "services"/g' feeds/luci/applications/luci-app-dockerman/luasrc/controller/*.lua
sed -i 's/"admin"/"admin", "services"/g; s/admin\//admin\/services\//g' feeds/luci/applications/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
sed -i 's/admin\//admin\/services\//g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/*.htm
sed -i 's|admin\\|admin\\/services\\|g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/container.htm
