from selenium import webdriver
from selenium.webdriver.firefox.options import Options
import time
import bs4 as bs

# options = Options()
# options.add_argument("--headless")
# driver = webdriver.Firefox(options=options)
driver = webdriver.Firefox()

driver.get("https://payments.efundsforschools.com/v3/districts/56042/students/associate?ref=ZnVuZC1sdW5jaA")

time.sleep(2)

lastName = driver.find_elements_by_tag_name("input")[0].send_keys("Scolari")
idNumber = driver.find_elements_by_tag_name("input")[1].send_keys("200276")
