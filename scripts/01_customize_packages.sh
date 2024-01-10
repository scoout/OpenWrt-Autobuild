#!/bin/bash

# create directory
[[ ! -d package/new ]] && mkdir -p package/new

# diskman
cp -rf ../immortalwrt-luci/applications/luci-app-diskman package/new/

# homeproxy
cp -rf ../immortalwrt-luci/applications/luci-app-homeproxy package/new/
# ftp
cp -rf ../kid-packages/luci-app-vsftpd package/new/

#smartdns
cp -rf ../immortalwrt-luci/applications/luci-app-smartdns package/new/

# passwall
cp -rf ../immortalwrt-luci/applications/luci-app-passwall package/new/
# svn export -q https://github.com/xiaorouji/openwrt-passwall-packages.git package/new/openwrt-passwall-packages
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/new/openwrt-passwall-packages
#badvpn & corkscrew
cp -rf ../badvpn_corkscrew/badvpn package/new/
cp -rf ../badvpn_corkscrew/corkscrew package/new/

# AutoCore
cp -rf ../immortalwrt/package/emortal/autocore package/new/
cp -rf ../immortalwrt/package/utils/mhz package/utils/
rm -rf feeds/luci/modules/luci-base
cp -rf ../immortalwrt-luci/modules/luci-base feeds/luci/modules
rm -rf feeds/luci/modules/luci-mod-status
cp -rf ../immortalwrt-luci/modules/luci-mod-status feeds/luci/modules/

# automount
cp -rf ../lede/package/lean/automount package/new/
cp -rf ../lede/package/lean/ntfs3-mount package/new/

# cpufreq
cp -rf ../immortalwrt-luci/applications/luci-app-cpufreq package/new/

# FullCone nat for nftables
# patch kernel
#cp -f ../lede/target/linux/generic/hack-6.1/952-add-net-conntrack-events-support-multiple-registrant.patch target/linux/generic/hack-6.1/
# https://github.com/coolsnowwolf/lede/issues/11211
#sed -i 's|CONFIG_WERROR=y|# CONFIG_WERROR is not set|g' target/linux/generic/config-6.1
curl -sSL https://github.com/coolsnowwolf/lede/files/11473487/952-add-net-conntrack-events-support-multiple-registrant.patch -o target/linux/generic/hack-6.1/952-add-net-conntrack-events-support-multiple-registrant.patch
cp -f ../lede/target/linux/generic/hack-6.1/982-add-bcm-fullconenat-support.patch target/linux/generic/hack-6.1/
# fullconenat-nft
cp -rf ../immortalwrt/package/network/utils/fullconenat-nft package/network/utils/
# libnftnl
rm -rf ./package/libs/libnftnl
cp -rf ../immortalwrt/package/libs/libnftnl package/libs/
# nftables
rm -rf ./package/network/utils/nftables/
cp -rf ../immortalwrt/package/network/utils/nftables package/network/utils/

# patch luci
patch -d feeds/luci -p1 -i ../../../patches/fullconenat-luci.patch

# mbedtls
rm -rf ./package/libs/mbedtls
cp -rf ../immortalwrt/package/libs/mbedtls package/libs/

# OpenClash
# svn export -q https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/new/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/new/luci-app-openclash

# Realtek RTL8125/8125B/8126A
# svn export -q https://github.com/sbwml/package_kernel_r8125/trunk package/new/r8125

# Realtek RTL8152/8153, RTL8192EU
cp -rf ../immortalwrt/package/kernel/{r8152,rtl8192eu} package/new/

# Release Ram
cp -rf ../immortalwrt-luci/applications/luci-app-ramfree package/new/

# Scheduled Reboot
cp -rf ../immortalwrt-luci/applications/luci-app-autoreboot package/new/

# Zerotier
cp -rf ../immortalwrt-luci/applications/luci-app-zerotier package/new/

# default settings and translation
cp -rf ../default-settings package/new/

# fix include luci.mk
find package/new/ -type f -name Makefile -exec sed -i 's,../../luci.mk,$(TOPDIR)/feeds/luci/luci.mk,g' {} +
