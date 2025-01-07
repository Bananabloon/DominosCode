import requests

response = requests.get('https://api.mail.tm/domains', verify=True)
print(response.json())
