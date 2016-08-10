#!/usr/bin/env python3

# $ ./Download.py

import subprocess, sys, os, codecs

Error_List = []

Error_List.append("http://embed.2d-gate.org/?action=embed&p_autostart=0&title=%E9%A6%99%E8%95%89%E5%96%B5+%5BDHR%401280x720%40%E7%B9%81%5D%5B01-05%5D&url=fDUBgT91VbSmCOLralu9gpu9GpiUBjKtQKm6v_Xw3rT7DPgpgA6F38vlxjeYoRVWtgOXJZc3hne9GLKLcbKdgXTq-M7zoqYGSDzUU4m0unk")
Error_List.append("http://embed.2d-gate.org/?action=embed&p_autostart=0&title=%E9%A6%99%E8%95%89%E5%96%B5+%5BDHR%401280x720%40%E7%B9%81%5D%5B01-05%5D&url=MLCyrtWv5ULk21DKwtQocp3PxIVbQGTL66hi6N8FSitL7KJ2AfDpKDRHQ2euAdbLQqlsrydFqmlZoNhMw1bMpoL4xZu9jjWMDTuzbiRiJ90")
Error_List.append("http://embed.2d-gate.org/?action=embed&p_autostart=0&title=%E9%A6%99%E8%95%89%E5%96%B5+%5BDHR%401280x720%40%E7%B9%81%5D%5B01-05%5D&url=bPzJxalonSHe7OBpouFBhjppS5gfptSkp9DdXe6a-is_hVYVEXntlfcb0CX2TYZdBZZjp8yo00QBAH_CubqGI-VmSq3516KMvTY2aVu27J0")
Error_List.append("http://embed.2d-gate.org/?action=embed&p_autostart=0&title=%E9%A6%99%E8%95%89%E5%96%B5+%5BDHR%401280x720%40%E7%B9%81%5D%5B01-05%5D&url=4jsmANtRQR0xwkiWLPkx3QR2fQBnxBl4YXIuxuX8odzHGJQlQp2TVOEIkAouTTpREC6J2jY6qYidUbKukzpgL06arX3pZhyu9f7oEBmBKrM")
Error_List.append("http://embed.2d-gate.org/?action=embed&p_autostart=0&title=%E9%A6%99%E8%95%89%E5%96%B5+%5BDHR%401280x720%40%E7%B9%81%5D%5B01-05%5D&url=aRgcxTT0KVHDPoUpy-SbuYr3H7tn3DZOc8fYWDHLwEzQGBesy_0dC3PDjdtGHTW98mOqh3_tpHEBGBFWxYo3_DGHVFPi5WJ2b4B-Xp_Z4Tg")

# Retry
i = 1
for url in Error_List:
    url = "\"" + url + "\""
    if os.system("youtube-dl --proxy 140.118.31.62:3128 --playlist-items 3 -o " + "%02d" % i + ".mp4 " + url) != 0:
        print("Download Error: " + url)
    i += 1
