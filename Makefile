# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#


include $(TOPDIR)/rules.mk
PKG_USE_MIPS16:=0 
PKG_NAME:=i2pd
PKG_VERSION:=2.3.0
PKG_REV:=f31c04d92a55ce4d4140c4b6d330802b4ace7e3f
PKG_RELEASE:=1
PKG_BUILD_PARALLEL:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/orignal/i2pd
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/i2pd
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libopenssl +boost_system +boost-filesystem +boost-regex +boost-program_options +boost-date_time +libatomic
	TITLE:=simplified C++ implementation of I2P client
	URL:=$(PKG_SOURCE_URL)
	MAINTAINER:=gxcreator
endef

define Package/i2pd/description
 i2p router for Linux written on C++.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	cd $(PKG_BUILD_DIR); \
	for srcfile in `ls -1 *.cpp *.h`; do \
	    $(SED) 's|cryptopp\/|crypto\+\+\/|g' $$$$srcfile; \
	done;
endef

define Package/i2pd/conffiles
#/opt/etc/i2p.conf
endef

define Package/i2pd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/i2pd $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libi2pd.a $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libi2pdclient.a $(1)/usr/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/usr/lib
endef

$(eval $(call BuildPackage,i2pd))
