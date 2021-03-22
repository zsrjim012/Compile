#!/bin/bash
# https://github.com/281677160/build-openwrt
# common Module by 28677160
# matrix.target=${Modelfile}

DIY_GET_COMMON_SH() {
TYZZZ="package/lean/default-settings/files/zzz-default-settings"
LIZZZ="package/default-settings/files/zzz-default-settings"
}

# 全脚本源码通用diy.sh文件
Diy_all() {
DIY_GET_COMMON_SH
echo "3月21号有新通知（请看公告）"
git clone -b $REPO_BRANCH --single-branch https://github.com/281677160/openwrt-package package/danshui
mv "${PATH1}"/AutoBuild_Tools.sh package/base-files/files/bin
chmod +x package/base-files/files/bin/AutoBuild_Tools.sh
if [[ ${REGULAR_UPDATE} == "true" ]]; then
git clone https://github.com/281677160/luci-app-autoupdate package/luci-app-autoupdate
mv "${PATH1}"/AutoUpdate.sh package/base-files/files/bin
chmod +x package/base-files/files/bin/AutoUpdate.sh
fi
}

# 全脚本源码通用diy2.sh文件
Diy_all2() {
DIY_GET_COMMON_SH
if [ -n "$(ls -A "${Home}/package/danshui/ddnsto" 2>/dev/null)" ]; then
mv package/danshui/ddnsto package/network/services
fi
if [[ `grep -c "# CONFIG_PACKAGE_ddnsto is not set" "${PATH1}/${CONFIG_FILE}"` -eq '0' ]]; then
sed -i '/CONFIG_PACKAGE_ddnsto/d' "${PATH1}/${CONFIG_FILE}" > /dev/null 2>&1
echo -e "\nCONFIG_PACKAGE_ddnsto=y" >> "${PATH1}/${CONFIG_FILE}"
fi
git clone https://github.com/kongfl888/po2lmo
pushd po2lmo
make && sudo make install
popd
rm -rf {LICENSE,README,README.md,CONTRIBUTED.md,README_EN.md}
rm -rf ./*/{LICENSE,README,README.md}
rm -rf ./*/*/{LICENSE,README,README.md}
rm -rf ./*/*/*/{LICENSE,README,README.md}
}


################################################################################################################
# LEDE源码通用diy1.sh文件
################################################################################################################
Diy_lede() {
DIY_GET_COMMON_SH
rm -rf package/lean/{luci-app-netdata,luci-theme-argon,k3screenctrl}
sed -i 's/iptables -t nat/# iptables -t nat/g' ${TYZZZ}
if [[ "${Modelfile}" == "Lede_x86_64" ]]; then
sed -i '/IMAGES_GZIP/d' "${PATH1}/${CONFIG_FILE}" > /dev/null 2>&1
echo -e "\nCONFIG_TARGET_IMAGES_GZIP=y" >> "${PATH1}/${CONFIG_FILE}"
fi

git clone https://github.com/fw876/helloworld package/danshui/luci-app-ssr-plus
git clone https://github.com/xiaorouji/openwrt-passwall package/danshui/luci-app-passwall
git clone https://github.com/jerrykuku/luci-app-vssr package/danshui/luci-app-vssr
git clone https://github.com/vernesong/OpenClash package/danshui/luci-app-openclash
git clone https://github.com/frainzy1477/luci-app-clash package/danshui/luci-app-clash
git clone https://github.com/garypang13/luci-app-bypass package/danshui/luci-app-bypass
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
}
################################################################################################################
# LEDE源码通用diy2.sh文件
Diy_lede2() {
DIY_GET_COMMON_SH
cp -Rf "${Home}"/build/common/LEDE/files "${Home}"
cp -Rf "${Home}"/build/common/LEDE/diy/* "${Home}"
sed -i '/exit 0/i\echo "*/3 * * * * chmod +x /etc/webweb.sh && source /etc/webweb.sh" >> /etc/crontabs/root' ${TYZZZ}
}


################################################################################################################
# LIENOL源码通用diy1.sh文件
################################################################################################################
Diy_lienol() {
DIY_GET_COMMON_SH
rm -rf package/diy/luci-app-adguardhome
rm -rf package/lean/{luci-app-netdata,luci-theme-argon,k3screenctrl}
git clone https://github.com/fw876/helloworld package/danshui/luci-app-ssr-plus
git clone https://github.com/xiaorouji/openwrt-passwall package/danshui/luci-app-passwall
git clone https://github.com/jerrykuku/luci-app-vssr package/danshui/luci-app-vssr
git clone https://github.com/vernesong/OpenClash package/danshui/luci-app-openclash
git clone https://github.com/frainzy1477/luci-app-clash package/danshui/luci-app-clash
git clone https://github.com/garypang13/luci-app-bypass package/danshui/luci-app-bypass
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
}
################################################################################################################
# LIENOL源码通用diy2.sh文件
Diy_lienol2() {
DIY_GET_COMMON_SH
cp -Rf "${Home}"/build/common/LIENOL/files "${Home}"
cp -Rf "${Home}"/build/common/LIENOL/diy/* "${Home}"
rm -rf feeds/packages/net/adguardhome
sed -i '/exit 0/i\echo "*/3 * * * * chmod +x /etc/webweb.sh && source /etc/webweb.sh" >> /etc/crontabs/root' ${LIZZZ}
sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-passwall/g' target/linux/x86/Makefile
}


################################################################################################################
# 天灵源码通用diy1.sh文件
################################################################################################################
Diy_immortalwrt() {
DIY_GET_COMMON_SH
rm -rf package/lienol/luci-app-timecontrol
rm -rf package/ctcgfw/{luci-app-argon-config,luci-theme-argonv3}
rm -rf package/lean/luci-theme-argon
#if [ -n "$(ls -A "${PATH1}/patches/1806-modify_for_r4s.patch" 2>/dev/null)" ]; then
#curl -fsSL https://raw.githubusercontent.com/1715173329/nanopi-r4s-openwrt/master/patches/1806-modify_for_r4s.patch > "${PATH1}/patches"/1806-modify_for_r4s.patch
#fi
#if [ -n "$(ls -A "${PATH1}/patches/1806-modify_for_r2s.patch" 2>/dev/null)" ]; then
#curl -fsSL https://raw.githubusercontent.com/1715173329/nanopi-r2s-openwrt/master/patches/1806-modify_for_r2s.patch > "${PATH1}/patches"/1806-modify_for_r2s.patch
#fi
git clone https://github.com/garypang13/luci-app-bypass package/danshui/luci-app-bypass
}

################################################################################################################
# 天灵源码通用diy2.sh文件
Diy_immortalwrt2() {
DIY_GET_COMMON_SH
cp -Rf "${Home}"/build/common/PROJECT/files "${Home}"
cp -Rf "${Home}"/build/common/PROJECT/diy/* "${Home}"
sed -i '/exit 0/i\echo "*/3 * * * * chmod +x /etc/webweb.sh && source /etc/webweb.sh" >> /etc/crontabs/root' ${TYZZZ}
sed -i "/exit 0/i\sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release" ${TYZZZ}
if [[ `grep -c "0.105.1" ${Home}/feeds/packages/net/adguardhome/Makefile` -eq '1' ]]; then
	sed -i 's/0.105.1/0.105.2/g' ${Home}/feeds/packages/net/adguardhome/Makefile
fi
}


################################################################################################################
# 判断脚本是否缺少主要文件（如果缺少settings.ini设置文件在检测脚本设置就运行错误了）

Diy_settings() {
DIY_GET_COMMON_SH
rm -rf ${Home}/build/QUEWENJIANerros
if [ -z "$(ls -A "$PATH1/${CONFIG_FILE}" 2>/dev/null)" ]; then
	echo
	echo "编译脚本缺少[${CONFIG_FILE}]名称的配置文件,请在[build/${Modelfile}]文件夹内补齐"
	echo "errors" > ${Home}/build/QUEWENJIANerros
	echo
fi
if [ -z "$(ls -A "$PATH1/${DIY_P1_SH}" 2>/dev/null)" ]; then
	echo
	echo "编译脚本缺少[${DIY_P1_SH}]名称的自定义设置文件,请在[build/${Modelfile}]文件夹内补齐"
	echo "errors" > ${Home}/build/QUEWENJIANerros
	echo
fi
if [ -z "$(ls -A "$PATH1/${DIY_P2_SH}" 2>/dev/null)" ]; then
	echo
	echo "编译脚本缺少[${DIY_P2_SH}]名称的自定义设置文件,请在[build/${Modelfile}]文件夹内补齐"
	echo "errors" > ${Home}/build/QUEWENJIANerros
	echo
fi
if [ -n "$(ls -A "${Home}/build/QUEWENJIANerros" 2>/dev/null)" ]; then
rm -rf ${Home}/build/QUEWENJIANerros
exit 1
fi
}


################################################################################################################
# N1、微加云、贝壳云、我家云、S9xxx 打包程序

Diy_n1() {
DIY_GET_COMMON_SH
cd ../
svn co https://github.com/281677160/N1/trunk reform
cp openwrt/bin/targets/armvirt/*/*.tar.gz reform/openwrt
cd reform
sudo ./gen_openwrt -d -k latest
         
devices=("phicomm-n1" "rk3328" "s9xxx" "vplus")
}


################################################################################################################
# 公告

Diy_notice() {
echo ""
echo "	《公告内容》"
echo " 3月21号新通知： luci-app-autopoweroff 改名成 luci-app-autotimeset 增加定时重启网络,有用这插件的注意了"
echo " 3月13号中午12点正更新：重新排版了信息显示，修复了一小BUG，请大家复制最新的build-openwrt.yml文件内容粘贴到你的build-openwrt.yml上"
echo " 3月11号早上11点增加了所选插件信息,如果使用的是3月9号最新版有需要的请复制最新的build-openwrt.yml文件内容粘贴到你的build-openwrt.yml上"
echo " 请大家使用3月9号最新版仓库编译"
echo " 把定时更新固件升级到5.2版本"
echo " x86-64、phicomm-k3、newifi-d2、phicomm_k2p自动适配固件名字跟后缀,无需设置"
echo " 优化了脚本,最新版修复了AdGuardHome权限问题不能启动"
echo " x86-64跟R2S编译AdGuardHome自动增加核心,免除下载"
echo " 没使用3月9号最新版本的会在加载源那里就出错了，请大家注意"
echo " [Telegram交流群] https://t.me/joinchat/AAAAAE3eOMwEHysw9HMcVQ"
echo " 脚本地址：https://github.com/281677160/build-openwrt"
echo ""
}
