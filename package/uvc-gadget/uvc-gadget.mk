################################################################################
#
# UVC Gadget (Upstream)
#
################################################################################

UVCGADGET_VERSION = 105134f9a7a3faad9f02a6a5516a8cd8e625fb04
UVCGADGET_SITE = git://github.com/calebccff/uvc-gadget
UVCGADGET_LICENSE = GPL-2.0+
UVCGADGET_LICENSE_FILES = LICENSE
UVCGADGET_DEST_DIR = /opt/uvc-webcam
UVCGADGET_CONF_OPTS = -DCMAKE_TOOLCHAIN_FILE=$(BASE_DIR)/host/usr/share/buildroot/toolchainfile.cmake
UVCGADGET_SITE_METHOD = git
UVCGADGET_INIT_SYSTEMD_TARGET = basic.target.wants

define UVCGADGET_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)$(UVCGADGET_DEST_DIR)
	$(INSTALL) -D -m 0755 $(@D)/uvc-gadget $(TARGET_DIR)$(UVCGADGET_DEST_DIR)
	$(INSTALL) -D -m 0755 $(UVCGADGET_PKGDIR)/multi-gadget.sh $(TARGET_DIR)$(UVCGADGET_DEST_DIR)
	$(INSTALL) -D -m 0755 $(UVCGADGET_PKGDIR)/start-webcam.sh $(TARGET_DIR)$(UVCGADGET_DEST_DIR)
endef

define UVCGADGET_INSTALL_INIT_SYSTEMD
	mkdir -p $(TARGET_DIR)/etc/systemd/system/$(UVCGADGET_INIT_SYSTEMD_TARGET)
	$(INSTALL) -D -m 644 $(UVCGADGET_PKGDIR)/uvc-webcam.service $(TARGET_DIR)/usr/lib/systemd/system/uvc-webcam.service
	$(INSTALL) -D -m 644 $(UVCGADGET_PKGDIR)/usb-gadget-config.service $(TARGET_DIR)/usr/lib/systemd/system/usb-gadget-config.service
	ln -sf /usr/lib/systemd/system/uvc-webcam.service $(TARGET_DIR)/etc/systemd/system/$(UVCGADGET_INIT_SYSTEMD_TARGET)
	ln -sf /usr/lib/systemd/system/usb-gadget-config.service $(TARGET_DIR)/etc/systemd/system/$(UVCGADGET_INIT_SYSTEMD_TARGET)
endef

$(eval $(cmake-package))