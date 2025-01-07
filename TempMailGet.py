#https://docs.mail.tm/
#https://api.mail.tm/
#generalnie to narazie nie mam nic, nie instaluje ani python ani pipa zakładam, że użytkownik to już ma,
#tylko, że te jebane kompy tego nie mają

import requests

response = requests.get('https://api.mail.tm/domains', verify=True)
print(response.json())
