#!/bin/bash

set -ex

# crypto
echo '
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_USB=y
CONFIG_USB_ACM=y
CONFIG_IOSM=y
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
' >> ./target/linux/x86/64/config-6.1

source ./01_customize_packages.sh

exit 0
