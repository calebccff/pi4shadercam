################################################################################
#
# UVC Gadget (Upstream)
#
################################################################################

UVC_GADGET_VERSION = fa2ffedb1efc7b880b7beaf315b8686456fb8a04
UVC_GADGET_SITE = git://github.com/calebccff/uvc-gadget
UVC_GADGET_LICENSE = GPL-2.0+
UVC_GADGET_LICENSE_FILES = LICENSE
UVC_GADGET_DEST_DIR = /opt/uvc-webcam
UVC_GADGET_LIB_DIR = /usr/lib
UVC_GADGET_CONF_OPTS = -DCMAKE_TOOLCHAIN_FILE=$(BASE_DIR)/host/usr/share/buildroot/toolchainfile.cmake
UVC_GADGET_SITE_METHOD = git
UVC_GADGET_INIT_SYSTEMD_TARGET = basic.target.wants

define UVC_GADGET_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)$(UVC_GADGET_DEST_DIR)
	$(INSTALL) -D -m 0755 $(@D)/uvc-gadget $(TARGET_DIR)$(UVC_GADGET_DEST_DIR)
	$(INSTALL) -D -m 0755 $(@D)/lib/libuvcgadget.so $(TARGET_DIR)$(UVC_GADGET_LIB_DIR)
	$(INSTALL) -D -m 0755 $(UVC_GADGET_PKGDIR)/multi-gadget.sh $(TARGET_DIR)$(UVC_GADGET_DEST_DIR)
	$(INSTALL) -D -m 0755 $(UVC_GADGET_PKGDIR)/start-webcam.sh $(TARGET_DIR)$(UVC_GADGET_DEST_DIR)
endef

define UVC_GADGET_INSTALL_INIT_SYSTEMD
	mkdir -p $(TARGET_DIR)/etc/systemd/system/$(UVC_GADGET_INIT_SYSTEMD_TARGET)
	$(INSTALL) -D -m 644 $(UVC_GADGET_PKGDIR)/uvc-webcam.service $(TARGET_DIR)/usr/lib/systemd/system/uvc-webcam.service
	$(INSTALL) -D -m 644 $(UVC_GADGET_PKGDIR)/usb-gadget-config.service $(TARGET_DIR)/usr/lib/systemd/system/usb-gadget-config.service
	ln -sf /usr/lib/systemd/system/uvc-webcam.service $(TARGET_DIR)/etc/systemd/system/$(UVC_GADGET_INIT_SYSTEMD_TARGET)
	ln -sf /usr/lib/systemd/system/usb-gadget-config.service $(TARGET_DIR)/etc/systemd/system/$(UVC_GADGET_INIT_SYSTEMD_TARGET)
endef

$(eval $(cmake-package))
