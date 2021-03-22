#!/bin/bash
ZZZ="package/lean/default-settings/files/zzz-default-settings"
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#

# IPv4 地址
sed -i "/exit 0/i\uci set network.lan.ipaddr='192.168.2.2'" $ZZZ

# 修改默认主题为argon
sed -i "/uci commit luci/i\uci set luci.main.mediaurlbase=/luci-static/argon" $ZZZ

# 修改主机名称为OpenWrt-123
sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-123'" $ZZZ

# 版本号里显示一个自己的名字（把 ${Author} 改成你自己名字就行了，不改的话，默认使用你帐号）
sed -i "s/OpenWrt /Compiled by ${Author} on $(TZ=UTC-8 date "+%Y/%m/%d") @ OpenWrt /g" $ZZZ

# 设置密码为空
sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ

# 修改内核版本为4.19
#sed -i 's/PATCHVER:=5.4/PATCHVER:=4.19/g' target/linux/x86/Makefile
