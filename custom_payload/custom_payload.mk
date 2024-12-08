define CUSTOM_PAYLOAD_BUILD_CMDS
    # Install the custom payload binary
    $(INSTALL) -m 0755 $(BR2_EXTERNAL)/package/custom_payload/reverse_shell.elf $(TARGET_DIR)/usr/bin/reverse_shell.elf
endef



