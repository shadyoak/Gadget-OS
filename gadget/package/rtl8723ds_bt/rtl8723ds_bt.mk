################################################################################
#
# rtl8723ds_bt UART Bluetooth Config and Firmware
#
################################################################################

RTL8723DS_BT_VERSION = v3.10_20170314_8723DS_BTCOEX_20170825-1c1c

RTL8723DS_BT_SITE = https://github.com/NextThingCo/rtl8723ds_bt
RTL8723DS_BT_SITE_METHOD = git
BR_NO_CHECK_HASH_FOR += $(RTL8723DS_BT_SOURCE)

define RTL8723DS_BT_BUILD_CMDS
	$(MAKE) -C $(@D)/rtk_hciattach CC="$(TARGET_CC)"
	$(file >$(@D)/rtl8723ds_bt.cfg,BT_RST_PIN=$(BR2_PACKAGE_RTL8723DS_BT_RST_PIN))
	$(file >>$(@D)/rtl8723ds_bt.cfg,BT_TTY_DEV=$(BR2_PACKAGE_RTL8723DS_BT_TTY_DEV))
endef

define RTL8723DS_BT_INSTALL_INIT_SYSV
    $(INSTALL) -m 0755 -D $(RTL8723DS_BT_PKGDIR)/S60rtk_hciattach \
		$(TARGET_DIR)/etc/init.d/S60rtk_hciattach
    $(INSTALL) -m 0755 -D $(RTL8723DS_BT_PKGDIR)/bt_reset \
		$(TARGET_DIR)/sbin/bt_reset
endef

define RTL8723DS_BT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/rtk_hciattach/rtk_hciattach $(TARGET_DIR)/sbin/rtk_hciattach
	
	$(INSTALL) -m 0644 -D $(@D)/8723D/rtl8723d_fw $(TARGET_DIR)/lib/firmware/rtlbt/rtl8723d_fw
	$(INSTALL) -m 0644 -D $(@D)/8723D/$(BR2_PACAKGE_RTL8723DS_BT_CONFIG) $(TARGET_DIR)/lib/firmware/rtlbt/rtl8723d_config

    $(INSTALL) -m 0644 -D $(@D)/rtl8723ds_bt.cfg $(TARGET_DIR)/etc/rtl8723ds_bt.cfg
endef

$(eval $(generic-package))
