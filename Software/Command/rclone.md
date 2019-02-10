Google drive
=====
* See also https://rclone.org/drive
* $ rclone config
```
No remotes found - n/r/c/s/q> n
name> gd
Storage> drive
client_id> (Leave empty)
client_secret> (Leave empty)
scope> 1
root_folder_id> (Leave empty)
service_account_file> (Leave empty)
Use auto config? y/n> n
team drive? y/n> n
y) Yes this is OK y/e/d> y
```
* $ rclone ls gd:/Music # List music folder on Gdrive
