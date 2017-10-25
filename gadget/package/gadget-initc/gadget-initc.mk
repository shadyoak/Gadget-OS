
################################################################################
#
# gadget-initc
#
################################################################################

GADGET_INITC_VERSION = unstable
GADGET_INITC_SITE = https://github.com/nextthingco/gadgetcli
GADGET_INITC_SITE_METHOD = git

GADGET_INITC_DEPENDENCIES = host-go

GADGET_INITC_GOPATH = "$(@D)/gopath"
GADGET_INITC_MAKE_ENV = $(HOST_GO_TARGET_ENV) \
	GOBIN="$(@D)/bin" \
	GOPATH="$(GADGET_INITC_GOPATH)"\
	$(TARGET_MAKE_ENV)

ifeq ($(BR2_arm),y)
GADGET_INITC_ARTIFACT_DIR=$(@D)/build/linux_arm/gadgetosinit
else ifeq ($(BR2_aarch64),y)
GADGET_INITC_ARTIFACT_DIR=$(@D)/build/linux_arm64/gadgetosinit
endif

define GADGET_INITC_BUILD_CMDS
        $(MAKE) clean
        $(GADGET_INITC_MAKE_ENV) $(MAKE) -C $(@D) get
        $(GADGET_INITC_MAKE_ENV) GIT_COMMIT=$(GADGET_INITC_VERSION) $(MAKE) -C $(@D) gadgetosinit_release
endef

define GADGET_INITC_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(GADGET_INITC_ARTIFACT_DIR) $(TARGET_DIR)/usr/bin/gadget-initc
endef

$(eval $(generic-package))
