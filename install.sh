#!/bin/sh
die() {
	echo $1 >&2
	exit 1
}

[ -w '/usr/local/sbin' -a -d '/usr/local/sbin' ] || die "Cannot write to /usr/local/sbin/"
[ -w '/etc/udev/rules.d' -a -d '/etc/udev/rules.d' ] || die "Cannot write to /etc/udev/rules.d/"

if [ -n "$1" ] ;then
	dev_path="$1"
else
	dev_path="$(udevadm info --query=path --name=/dev/sr0 | perl -pe 's!/block/...$!!')"
fi
[ -z "$dev_path" ] && die "Could not find the Ultrabay device"
local_dir="$(dirname "$0")"

install -o root -g root -m 0755 "${local_dir}/ultrabay_eject" /usr/local/sbin/ || die "Could not install script"
install -o root -g root -m 0644 "${local_dir}/50-thinkpad-ultrabay.rules" /etc/udev/rules.d/ || die "Could not install UDEV rules"

sed -e "s#^DEVPATH=''#DEVPATH='$dev_path'#g" -i /usr/local/sbin/ultrabay_eject

udevadm control --reload-rules > /dev/null 2>&1 || echo "Warning: Could not reload UDEV rules, reboot to activate"

