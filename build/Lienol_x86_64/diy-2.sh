#!/bin/bash
ZZZ="package/default-settings/files/zzz-default-settings"
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#

# IPv4 地址
sed -i "/exit 0/i\uci set network.lan.ipaddr='192.168.2.2'" $ZZZ
# IPv4 子网掩码
sed -i "/exit 0/i\uci set network.lan.netmask='255.255.255.0'" $ZZZ
# IPv4 网关
sed -i "/exit 0/i\uci set network.lan.gateway='192.168.2.1'" $ZZZ
# IPv4 广播
sed -i "/exit 0/i\uci set network.lan.broadcast='192.168.2.255'" $ZZZ
# DNS 多个要空格分开
sed -i "/exit 0/i\uci set network.lan.dns='223.5.5.5 114.114.114.114'" $ZZZ
# 取消LAN口内置IPV6使用
sed -i "/exit 0/i\uci set network.lan.delegate='0'" $ZZZ
# 以上修改没全部删除,勿删除此处
sed -i "/exit 0/i\uci commit network" $ZZZ

# 修改默认主题为argon
sed -i "/uci commit luci/i\uci set luci.main.mediaurlbase=/luci-static/argon" $ZZZ

# 修改主机名称为OpenWrt-123
sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-123'" $ZZZ

# 版本号里显示一个自己的名字（把 ${Author} 改成你自己名字就行了，不改的话，默认使用你帐号）
sed -i "s/OpenWrt /Compiled by ${Author} on $(TZ=UTC-8 date "+%Y/%m/%d") @ OpenWrt /g" $ZZZ

# 修改内核版本为4.19
#sed -i 's/KERNEL_PATCHVER:=4.14/KERNEL_PATCHVER:=4.19/g' target/linux/x86/Makefile
