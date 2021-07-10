Samba printer
=====
```sh
app-fast -S cups ghostscript gsfonts samba smbclient cifs-utils hplip
yay -S xerox-docucentre-driver # Fuji
sudoedit /etc/samba/smb.conf # This step could be unnecessarily
[global]
	workgroup = WORKGROUP
	security = user
        client min protocol = CORE
        client max protocol = SMB2
        client lanman auth = Yes
        lanman auth = Yes
        client ntlmv2 auth = no


sudo systemctl enable --now cups.service
sudo systemctl enable --now cups.socket
sudo systemctl enable --now cups.path
sudo systemctl enable --now samba.service

nmblookup -S WORKGROUP # List all samba servers `nmblookup -S '*'`
```
* Open link http://localhost:631/admin
  * User/Password is the same as the linux machine
  * Click "Add Printer" -> "Discovered Network Printers"
  * Choose the one the discovered

Troubleshooting
=====
* If the printer is not found on the web interface
* Try
  * Disable ufw settings for samba
