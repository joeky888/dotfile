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

for u in sys.argv[1:]:
    url.append(u)

for idx, u in enumerate(url):

    try:
        driver.get(u)
    except:
        # Ignore long loading
        pass

    while True:
        print("Trying")
        time.sleep(2)
        start = time.clock()
        try:
            # ERROR: Caught exception [ERROR: Unsupported command [selectWindow | win_ser_1 | ]]
            driver.switch_to.frame(driver.find_element_by_css_selector("#playleft > iframe:nth-child(2)"))
#             driver.find_element_by_id("play-btn").click()
#             driver.find_element_by_link_text(u"火影忍者小李外傳E01").click()
            driver.find_element_by_id("wv-play-btn").click()
#             driver.find_element_by_id("player_view").click()
            print('已定位到元素')
            end=time.clock()
            break
        except:
            print("还未定位到元素!")


#     driver.find_element_by_id("play-btn").click()
    # ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=3 | ]]
#     driver.find_element_by_id("play-btn").click()
    # ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
#     driver.find_element_by_xpath("(.//*[normalize-space(text()) and normalize-space(.)='Select'])[2]/following::div[8]").click()
    # ERROR: Caught exception [ERROR: Unsupported command [selectWindow | win_ser_1 | ]]
    # ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
#     driver.find_element_by_xpath("(.//*[normalize-space(text()) and normalize-space(.)='Select'])[2]/following::div[8]").click()

#     driver.find_element_by_id("play-btn").click()
    html = driver.page_source       # get html
#     driver.get_screenshot_as_file("./img/sreenshot1.png")
    print(html)
    driver.close()

# url.append( "https://www.bilibili.com/video/av7931969/?p=1" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=2" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=3" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=4" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=5" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=6" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=7" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=8" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=9" )

# Remove duplicates
# url = list(set(url))

# for idx, u in enumerate(url):
#     processes.append( [subprocess.Popen([ "you-get", u, "-o", str(idx) ]), u, idx] )
#     while len(processes) >= MAX_DOWNLOAD_AT_ONCE:
#         time.sleep(.1)
#         for i, p in enumerate(processes):
#             # if p[0].returncode == None, it means that downloading is not finished
#             if p[0].poll() == 0:
#                 # Succeed
#                 processes.pop(i)
#             elif p[0].returncode != None:
#                 # Failed
#                 processes.pop(i)
#                 Error.append( [subprocess.Popen([ "you-get", p[1], "-o", str(p[2]) ]), p[1], p[2]] )
#                 time.sleep(.1)
#         processes.extend(Error)
#         Error = []

# Execute this bash command
# $ find . -name '*' -type f -exec mv {} ./ \; && find . -type d -empty -delete

# Or the Powershell Command
# $ Get-ChildItem -Path . -Recurse -File | Move-Item -Force -Destination . ; Get-ChildItem -Path . -Recurse -Directory | Remove-Item
