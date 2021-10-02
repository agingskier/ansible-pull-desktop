---
branch: master

ansible_cron_minute: "*/5"
ssh_port: 22
ssh_users: "ansible bpic"

# platform-specific
ansible_python_interpreter: /usr/bin/python3
microcode_amd_install: false
microcode_intel_install: true

# app defaults
gui_editor: gvim
terminal_emulator: terminator
# web_browser: flatpak run org.mozilla.firefox (where used?)

#
# application selection
#
# audacity: false
# authy: false
# autofs: false
# chromium: false
# darktable: false
firefox: true
# foliate: false
games: true
# glimpse: false
hypervisor: true
keepassxc: true
libreoffice: true
# lutris: false   (requires wine)
# mattermost: false
# minecraft: false
multipass: true
# packer: false
signal: true
# spotify: false
steam: true
# syncthing: false
# terraform: false
# thunderbird: false
# todoist: false
ulauncher: false
vagrant: true
virtualbox: true
# vivaldi: false
vlc: true
# xonotic: false

# desktop environment selection
gnome: true
mate: false
