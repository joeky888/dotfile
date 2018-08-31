#!/usr/bin/env python3

# Original tutorial: https://morvanzhou.github.io/tutorials/data-manipulation/scraping/5-01-selenium/

# $ pip3 install selenium

# Download drivers
# Chrome   : https://sites.google.com/a/chromium.org/chromedriver/downloads
# Edge     : https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
# Firefox  : https://github.com/mozilla/geckodriver/releases
# Install driver to $HOME/bin or /usr/bin

import subprocess, sys, os, codecs, time, random
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

desktop=os.path.expanduser('~') + "/Desktop/"
firefox_profile = webdriver.FirefoxProfile()
firefox_profile.set_preference("browser.privatebrowsing.autostart", True)

# chrome_options = Options()
# chrome_options.add_argument("--headless")       # define headless

driver = webdriver.Firefox(firefox_profile=firefox_profile)  # Use chrome driver

screenNum=1

def screenshot():
    global screenNum
    driver.switch_to_default_content()
    driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
    driver.get_screenshot_as_file(desktop + str(screenNum) + ".png")
    screenNum += 1
    driver.switch_to_default_content()

def clickID(sel, sleep=3):
    try:
        driver.find_element_by_id(sel).click()
        time.sleep(sleep)
    except Exception:
        time.sleep(sleep)
        print("retrying... " + sel)
        try:
            # Randomly click on the void spaces
            if bool(random.getrandbits(1)):
                driver.switch_to_default_content()
                driver.find_element_by_id("ga-nav-collapse").click()
            else:
                driver.switch_to_default_content()
                driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
        except:
            pass
        clickID(sel)
        pass

def clickName(sel, sleep=3):
    try:
        driver.find_element_by_name(sel).click()
        time.sleep(sleep)
    except Exception:
        time.sleep(sleep)
        print("retrying... " + sel)
        try:
            # Randomly click on the void spaces
            if bool(random.getrandbits(1)):
                driver.switch_to_default_content()
                driver.find_element_by_id("ga-nav-collapse").click()
            else:
                driver.switch_to_default_content()
                driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
        except:
            pass
        clickName(sel)
        pass

def clickXpath(sel, sleep=3):
    try:
        driver.find_element_by_xpath(sel).click()
        time.sleep(sleep)
    except Exception:
        time.sleep(sleep)
        print("retrying..." + sel)
        try:
            # Randomly click on the void spaces
            if bool(random.getrandbits(1)):
                driver.switch_to_default_content()
                driver.find_element_by_id("ga-nav-collapse").click()
            else:
                driver.switch_to_default_content()
                driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
        except:
            pass
        clickXpath(sel)
        pass

def clickText(sel, sleep=3):
    try:
        driver.find_element_by_link_text(sel).click()
        time.sleep(sleep)
    except Exception:
        time.sleep(sleep)
        print("retrying..." + sel)
        try:
            # Randomly click on the void spaces
            if bool(random.getrandbits(1)):
                driver.switch_to_default_content()
                driver.find_element_by_id("ga-nav-collapse").click()
            else:
                driver.switch_to_default_content()
                driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
        except:
            pass
        clickText(sel)
        pass

driver.maximize_window()

driver.get("https://analytics.google.com/analytics/web")
# driver.get("https://accounts.google.com/signin/v2/identifier?service=analytics&passive=1209600&continue=https%3A%2F%2Fanalytics.google.com%2Fanalytics%2Fweb%2F%23&followup=https%3A%2F%2Fanalytics.google.com%2Fanalytics%2Fweb%2F&flowName=GlifWebSignIn&flowEntry=ServiceLogin")
clickID("identifierId")
driver.find_element_by_id("identifierId").clear()
driver.find_element_by_id("identifierId").send_keys("joeky_zhan@asus.com")


clickID("identifierNext")
# clickXpath("(.//*[normalize-space(text()) and normalize-space(.)='Learn more'])[1]/following::content[1]")
clickName("password")
driver.find_element_by_name("password").clear()

PASS=""
driver.find_element_by_name("password").send_keys(PASS)
clickID("passwordNext")
# clickXpath("(.//*[normalize-space(text()) and normalize-space(.)='joeky_zhan@asus.com'])[1]/following::span[1]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='載入中...'])[1]/following::div[4]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='載入中...'])[1]/following::button[2]")
clickXpath("(.//*[normalize-space(text()) and normalize-space(.)='UA-73282159-35'])[1]/following::span[2]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='資料檢視'])[1]/following::div[6]")
clickText(u"總覽")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
screenshot()
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='載入中...'])[1]/following::div[4]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='總覽'])[2]/following::span[1]")

driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
time.sleep(3)
checkboxes = driver.find_elements_by_css_selector('span.W_CHECKABLE')
checkboxes.pop(0)

for checkbox in checkboxes:
    while True:
        time.sleep(2)
        try:
            checkbox.click()
            break
        except Exception: # Replace Exception with something more specific.
            print("retrying... checkboxes")
            continue

screenshot()
driver.switch_to_default_content()
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='總覽'])[1]/following::span[1]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='資訊主頁'])[1]/following::span[1]")
driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='建立日期'])[1]/following::div[4]")
driver.switch_to_default_content()
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
screenshot()
clickID("ga-nav-collapse")
clickText(u"行為")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='行為'])[1]/following::a[1]")
clickID("ga-nav-collapse")
screenshot()
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='事件總數'])[5]/following::div[1]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='平均價值'])[4]/following::span[2]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='活動標籤'])[1]/following::div[10]")
screenshot()
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | relative=parent | ]]
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='活動標籤'])[1]/following::div[10]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='事件類別:'])[1]/following::div[3]")
clickXpath("(.//*[normalize-space(text()) and normalize-space(.)='Model'])[1]/following::div[1]")
screenshot()
driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='事件類別:'])[1]/following::div[2]")
clickXpath("(.//*[normalize-space(text()) and normalize-space(.)='DSAPI_Result'])[1]/following::div[1]")
screenshot()
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | relative=parent | ]]
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='載入中...'])[1]/following::button[2]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='資源和應用程式'])[1]/following::div[6]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='資料檢視'])[1]/following::div[6]")
# clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='所有行動應用程式資料'])[1]/following::span[1]")
clickText(u"總覽")
clickID("ga-nav-collapse")
screenshot()
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='總覽'])[2]/following::span[1]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
time.sleep(3)
checkboxes = driver.find_elements_by_css_selector('span.W_CHECKABLE')
time.sleep(3)
checkboxes.pop(0)

for checkbox in checkboxes:
    while True:
        time.sleep(2)
        try:
            checkbox.click()
            break
        except Exception: # Replace Exception with something more specific.
            print("retrying... checkboxes")
            continue

screenshot()
clickID("ga-nav-collapse")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
clickText(u"自訂")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='資訊主頁'])[1]/following::span[1]")
driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='建立日期'])[1]/following::div[4]")
driver.switch_to_default_content()
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
screenshot()
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='小時'])[1]/following::div[10]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | relative=parent | ]]
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
screenshot()
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='客戶開發'])[1]/following::span[1]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='總覽'])[2]/following::span[1]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
screenshot()
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='顯示列數：'])[1]/following::select[1]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='顯示列數：'])[1]/following::option[4]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | relative=parent | ]]
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='載入中...'])[1]/following::button[2]")
clickXpath("(.//*[normalize-space(text()) and normalize-space(.)='Robot-userdebug'])[1]/following::div[3]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='資源和應用程式'])[1]/following::div[6]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='所有網站資料'])[1]/following::span[1]")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='即時'])[1]/following::span[1]")
clickText(u"總覽")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
screenshot()
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='總覽'])[1]/following::span[1]")
clickID("ga-nav-collapse")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
# clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='活躍使用者'])[5]/following::span[4]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | relative=parent | ]]
# clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::ga-galaxy-page[1]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
time.sleep(3)
checkboxes = driver.find_elements_by_css_selector('span.W_CHECKABLE')
time.sleep(3)
checkboxes.pop(0)

for checkbox in checkboxes:
    while True:
        time.sleep(2)
        try:
            checkbox.click()
            break
        except Exception: # Replace Exception with something more specific.
            print("retrying... checkboxes")
            continue

screenshot()
# clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='活躍使用者'])[5]/following::span[6]")
# clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='活躍使用者'])[5]/following::span[8]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | relative=parent | ]]
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
clickText(u"自訂")
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='資訊主頁'])[1]/following::span[1]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
driver.switch_to.frame(driver.find_element_by_id("galaxyIframe"))
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='建立日期'])[1]/following::div[4]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | relative=parent | ]]
driver.switch_to_default_content()
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='管理'])[1]/following::md-icon[1]")
# ERROR: Caught exception [ERROR: Unsupported command [selectFrame | index=1 | ]]
clickXpath(u"(.//*[normalize-space(text()) and normalize-space(.)='小時'])[1]/following::div[10]")
screenshot()

# Execute this bash command
# $ find . -name '*' -type f -exec mv {} ./ \; && find . -type d -empty -delete

# Or the Powershell Command
# $ Get-ChildItem -Path . -Recurse -File | Move-Item -Force -Destination . ; Get-ChildItem -Path . -Recurse -Directory | Remove-Item
