ultrabay_eject
==============

Eject script for Thinkpad Ultrabay, from [ThinkWiki](http://www.thinkwiki.org/wiki/How_to_hotswap_Ultrabay_devices)

See the above page for in-depth discussion.

Pre-Install
-----------
Connect your Ultrabay optical device, this will allow the installer to 
auto-detect the ultrabay device path.  If you do not have an optical device,
you will have to determine the correct device path manually.

Install
-------
```bash
git clone https://github.com/pdf/ultrabay_eject.git
cd ultrabay_eject
sudo ./install.sh
```

__Note:__ if you need to specify your device path, you may do so by appending 
it to the install line above, ie:
```bash
sudo ./install.sh '/devices/pci0000:00/0000:00:1f.2/ata2/host1/target1:0:0/1:0:0:0'
```

Notes
-----
Tested on Ubuntu 12.04, should work on most modern distros, with most modern 
Thinkpads.
