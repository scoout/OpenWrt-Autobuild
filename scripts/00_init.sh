#!/usr/bin/env bash

set -ex

__get_openwrt() {
    git clone https://github.com/openwrt/openwrt
}

__get_other_repos() {
    git clone -b master --depth 1 --single-branch https://github.com/coolsnowwolf/lede lede
    git clone -b master --depth 1 --single-branch https://github.com/immortalwrt/immortalwrt immortalwrt
    git clone -b master --depth 1 --single-branch https://github.com/immortalwrt/packages immortalwrt-packages
    git clone -b master --depth 1 --single-branch https://github.com/immortalwrt/luci immortalwrt-luci
}

__clone_modemfeed() {
    git clone https://github.com/koshev-msk/modemfeed.git openwrt/package/modemfeed
}

__init_build_env() {
    # ... (sama seperti yang ada pada skrip Anda sebelumnya)
}

__init_feeds() {
    ./openwrt/scripts/feeds update -a && ./openwrt/scripts/feeds install -a
}

case $1 in
    build_env)      __init_build_env    ;;
    openwrt)        __get_openwrt       ;;
    other-repos)    __get_other_repos   ;;
    clone_modemfeed) __clone_modemfeed   ;;
    feeds)          __init_feeds        ;;
    *)              echo "input error"  ;;
esac

exit 0
