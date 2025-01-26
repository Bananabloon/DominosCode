from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time



service = Service(executable_path="C:/Users/Administrator/Desktop/DominosCode/chromedriver.exe")
driver = webdriver.Chrome(service=service)

driver.get("https://www.dominospizza.pl")
time.sleep(4)
consent_button = driver.find_element(By.ID, "onetrust-reject-all-handler")
input_element = driver.find_element(By.ID, 'Email')
check_input = driver.find_element(By.CLASS_NAME, "Checkbox__check")
send_input = driver.find_element(By.CSS_SELECTOR, ".c-Button.c-Button--filled.c-Button--filled-secondary.c-Button--d-block")
consent_button.click()
time.sleep(3)

check_input.click()
time.sleep(1.2)








input()
driver.quit()
