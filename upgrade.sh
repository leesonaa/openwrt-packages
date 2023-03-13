#
#!/bin/bash
# © 2022 GitHub, Inc.
#====================================================================
# Copyright (c) 2022 Ing
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/wjz304/openwrt-packages
# File name: upgrade.sh
# Description: OpenWrt packages update script
#====================================================================


function git_clone() {
  rm -rf $(basename $1 .git)
  git clone --depth 1 $1 $(basename $1 .git) || true
  # sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' $(basename $1 .git)/Makefile
  rm -rf $(basename $1 .git)/.svn* $(basename $1 .git)/.git*
}

function git_clone_b() {
  rm -rf $(basename $1 .git)
  git clone --depth 1 -b $2 $1 $(basename $1 .git) || true
  # sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' $(basename $1 .git)/Makefile
  rm -rf $(basename $1 .git)/.svn* $(basename $1 .git)/.git*
}

function svn_co() {
  rm -rf $(basename $1 .git)
  svn co $1 $(basename $1 .git) || true
  # sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' $(basename $1 .git)/Makefile
  rm -rf $(basename $1 .git)/.svn* $(basename $1 .git)/.git*
}


# unraid icons
#svn co https://github.com/xushier/HD-Icons/trunk/border-radius /icons
# circle
#svn_co https://github.com/xushier/HD-Icons/trunk/circle /icons
# png
#svn co https://github.com/walkxcode/dashboard-icons/trunk/png /icons
#svg
#svn co https://github.com/walkxcode/dashboard-icons/trunk/svg /icons


# test docker & dockerman
# svn co/export 需要trunk
#svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-docker
#sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' luci-app-docker/Makefile
#svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-dockerman
#sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' luci-app-dockerman/Makefile
svn_co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-dockerman



# gdy666/lucky
git_clone https://github.com/gdy666/luci-app-lucky
sed -i 's/#LUCI_DEPENDS:=+lucky/LUCI_DEPENDS:=+lucky/g' luci-app-lucky/luci-app-lucky/Makefile

# DDNS-GO
git_clone https://github.com/sirpdboy/luci-app-ddns-go

# 一键自动格式化分区、扩容、自动挂载插件
git_clone https://github.com/sirpdboy/luci-app-partexp


# Argon 主题
git_clone_b https://github.com/jerrykuku/luci-theme-argon 18.06


# Argon 主题配置插件
git_clone https://github.com/jerrykuku/luci-app-argon-config
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argon/' luci-app-argon-config/Makefile
#sed -i 's/\"Argon 主题设置\"/\"主题设置\"/g' luci-app-argon-config/po/zh-cn/argon-config.po

# Argoone 主题
git_clone_b https://github.com/kenzok78/luci-theme-argonne 21.02
git_clone https://github.com/kenzok78/luci-app-argonne-config

# 关机
git_clone https://github.com/esirplayground/luci-app-poweroff


# bypass
#git_clone https://github.com/kiddin9/openwrt-bypass
#sed -i 's/luci-lib-ipkg/luci-base/g' openwrt-bypass/luci-app-bypass/Makefile
#删库了？

# openwrt-passwall 依赖
git_clone https://github.com/xiaorouji/openwrt-passwall

# Passwall  # 依赖 openwrt-passwall
svn_co https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall

# Passwall2  # 依赖 openwrt-passwall
svn_co https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2


# HelloWorld 依赖
git_clone https://github.com/fw876/helloworld


# HelloWorld  # 依赖 helloworld 和 openwrt-passwall
git_clone https://github.com/jerrykuku/lua-maxminddb
git_clone https://github.com/jerrykuku/luci-app-vssr


# OpenClash
git_clone https://github.com/vernesong/OpenClash
rm -rf luci-app-openclash && mv -f OpenClash/luci-app-openclash . && rm -rf OpenClash


# Clash
git_clone https://github.com/frainzy1477/luci-app-clash


# iKoolProxy 滤广告
git_clone https://github.com/yaof2/luci-app-ikoolproxy


# AdGuard Home
git_clone https://github.com/rufengsuixing/luci-app-adguardhome


# SmartDNS # 与 bypass 冲突
#git_clone https://github.com/pymumu/openwrt-smartdns 
#git_clone https://github.com/pymumu/luci-app-smartdns lede
#sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' luci-app-smartdns/Makefile


# 应用商店
git_clone https://github.com/linkease/istore-ui
git_clone https://github.com/linkease/istore && mv -n istore/luci/* ./; rm -rf istore
sed -i 's/luci-lib-ipkg/luci-base/g' luci-app-store/Makefile


# 网络向导
svn_co https://github.com/linkease/nas-packages/trunk/network/services/quickstart
svn_co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-quickstart
sed -i 's/ +luci-app-store//g' luci-app-quickstart/Makefile


# 实时监控
git_clone https://github.com/sirpdboy/luci-app-netdata


# 高级设置
git_clone https://github.com/sirpdboy/luci-app-advanced


# 定时任务
git_clone https://github.com/DevOpenWRT-Router/luci-app-rebootschedule
sed -i '/firstchild/d' luci-app-rebootschedule/luasrc/controller/rebootschedule.lua
sed -i 's/"control"/"system"/g; s/"Timing setting"/"定时任务"/g' luci-app-rebootschedule/luasrc/controller/rebootschedule.lua


# 应用过滤
git_clone https://github.com/destan19/OpenAppFilter


# 网速测试
git_clone https://github.com/sirpdboy/netspeedtest
#sed -i 's/DEPENDS:=\$(GO_ARCH_DEPENDS)$/DEPENDS:=\$(GO_ARCH_DEPENDS) +upx /g' netspeedtest/homebox/Makefile

# 全能推送
git_clone https://github.com/zzsj0928/luci-app-pushbot


# ZeroTier
git_clone https://github.com/rufengsuixing/luci-app-zerotier
sed -i 's/"vpn"/"services"/g; s/"VPN"/"Services"/g' luci-app-zerotier/luasrc/controller/zerotier.lua


# Tailscale
git_clone https://github.com/MoZhonghua/openwrt-tailscale
#git clone -b https://github.com/kuoruan/openwrt-upx.git package/openwrt-upx


# IPv6 端口转发
git_clone https://github.com/big-tooth/luci-app-socatg
#sed -i 's/socat\r/socatg\r/g' luci-app-socatg/Makefile && sed -i 's/socat$/socatg/g' luci-app-socatg/Makefile


# beardropper
git_clone https://github.com/NateLol/luci-app-beardropper


# IP限速
svn_co https://github.com/immortalwrt/luci/trunk/applications/luci-app-eqos
sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' luci-app-eqos/Makefile


# 文件浏览器
git_clone https://github.com/xiaozhuai/luci-app-filebrowser
sed -i 's/"services"/"nas"/g; s/"Services"/"NAS"/g' luci-app-filebrowser/luasrc/controller/filebrowser.lua
cp -rf luci-app-filebrowser/po/zh_Hans/* luci-app-filebrowser/po/zh_cn


# gowebdav
svn_co https://github.com/immortalwrt/packages/trunk/net/gowebdav
sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' gowebdav/Makefile
svn_co https://github.com/immortalwrt/luci/trunk/applications/luci-app-gowebdav
sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' luci-app-gowebdav/Makefile
#sed -i '/"NAS"/d; /page/d' luci-app-gowebdav/luasrc/controller/gowebdav.lua
#sed -i 's/\"nas\"/\"services\"/g' luci-app-gowebdav/luasrc/controller/gowebdav.lua


# vm-tools
# git_clone https://github.com/fangli/openwrt-vm-tools




# clean
rm -rf ./*/.svn*
rm -rf ./*/.git*


#end
exit 0
