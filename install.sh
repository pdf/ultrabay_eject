#!/bin/sh
die() {
	echo $1 >&2
	exit 1
}

[ -w '/usr/local/sbin' -a -d '/usr/local/sbin' ] || die "Cannot write to /usr/local/sbin/"
[ -w '/etc/udev/rules.d' -a -d '/etc/udev/rules.d' ] || die "Cannot write to /etc/udev/rules.d/"

local_dir="$(dirname "$0")"

install -o root -g root -m 0755 "${local_dir}/ultrabay_eject" /usr/local/sbin/ || die "Could not install script"
install -o root -g root -m 0644 "${local_dir}/50-thinkpad-ultrabay.rules" /etc/udev/rules.d/ || die "Could not install UDEV rules"

udevadm control --reload-rules > /dev/null 2>&1 || echo "Warning: Could not reload UDEV rules, reboot to activate"
