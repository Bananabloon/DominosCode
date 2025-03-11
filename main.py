from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
from TempMailGet import get_mail, check_mail
from CaptchaSolve import captcha_solve
email_data = get_mail()
service = Service(executable_path="C:/Users/Administrator/Desktop/DominosCode/chromedriver.exe")
driver = webdriver.Chrome(service=service)


driver.get("https://www.dominospizza.pl")
time.sleep(3)
consent_button = driver.find_element(By.ID, "onetrust-reject-all-handler")
input_element = driver.find_element(By.ID, 'Email')
check_input = driver.find_element(By.CLASS_NAME, "Checkbox__check")
send_input = driver.find_element(By.CSS_SELECTOR, ".c-Button.c-Button--filled.c-Button--filled-secondary.c-Button--d-block")

consent_button.click()
check_input.click()
input_element.send_keys(email_data[0])
time.sleep(0.3)
send_input.click()








input()
driver.quit()