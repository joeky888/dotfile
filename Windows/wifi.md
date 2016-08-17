Open cmd (with admin)

Setting ssid and password
=====
* Once done, Windows will remember this setting
* $ netsh wlan set hostednetwork mode=allow ssid=name key=00000000

Start sharing
=====
* $ netsh wlan start hostednetwork

Stop sharing
=====
* $ netsh wlan stop hostednetwork