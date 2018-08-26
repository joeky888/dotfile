#!/usr/bin/env python3

# Original tutorial: https://morvanzhou.github.io/tutorials/data-manipulation/scraping/5-01-selenium/

# $ pip3 install selenium

# Download drivers
# Chrome   : https://sites.google.com/a/chromium.org/chromedriver/downloads
# Edge     : https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
# Firefox  : https://github.com/mozilla/geckodriver/releases
# Install driver to $HOME/bin or /usr/bin

import sys, os
from os.path import dirname
sys.path.append(os.path.expanduser('~'))

import subprocess, sys, os, codecs, time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

firefox_profile = webdriver.FirefoxProfile()
firefox_profile.set_preference("browser.privatebrowsing.autostart", True)
firefox_profile.set_preference("http.response.timeout", 5)
firefox_profile.set_preference("dom.max_script_run_time", 5)
# chrome_options = Options()
# chrome_options.add_argument("--headless")       # define headless

driver = webdriver.Firefox(firefox_profile=firefox_profile)  # Use chrome driver
# driver = webdriver.Chrome(chrome_options=chrome_options)  # Use chrome driver
driver.set_page_load_timeout(10)

Error = []
MAX_DOWNLOAD_AT_ONCE = 16
processes = []
url = []

url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-1-flv.html")
url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-2-flv.html")
url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-3-flv.html")
url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-4-flv.html")
url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-5-flv.html")
url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-6-flv.html")
url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-7-flv.html")
url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-8-flv.html")
url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-9-flv.html")
url.append("http://www.99kubo.tv/vod-play-id-45451-sid-2-pid-10-flv.html")

# for u in sys.argv[1:]:
#     url.append(u)

DOWNLOADER="youtube-dl"
DOWNLOADER_ARGS='--no-check-certificate --external-downloader aria2c --external-downloader-args "-c -s16 -k1M -x16 -j16"'

for idx, u in enumerate(url):

    try:
        driver.get(u)
    except:
        pass

    while True:
#         print("Trying")
        time.sleep(2)
        try:
            # ERROR: Caught exception [ERROR: Unsupported command [selectWindow | win_ser_1 | ]]
            driver.switch_to.frame(driver.find_element_by_css_selector("#playleft > iframe:not(#buffer)"))
            break
        except:
            pass

    vid = driver.find_element_by_css_selector('video#my-video_html5_api').get_attribute('src')
    cmd = DOWNLOADER + " " + DOWNLOADER_ARGS + " '" + vid + "' -o " + str(idx+1) + ".flv"
    print(cmd)
    os.system(cmd)

driver.close()
