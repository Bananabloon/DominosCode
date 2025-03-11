import requests
import uuid
import json
import time

def get_mail():
    try:
        # Pobranie dostępnych domen
        domains = requests.get("https://api.mail.tm/domains").json().get("hydra:member", [])
        valid_domain = domains[0]["domain"] if domains else "mail.tm"

        # Tworzenie konta
        unique_email = f"{uuid.uuid4().hex[:8]}@{valid_domain}"
        password = "securepassword123"

        requests.post("https://api.mail.tm/accounts", json={"address": unique_email, "password": password})

        # Logowanie i pobranie tokena
        auth_token = requests.post("https://api.mail.tm/token", json={"address": unique_email, "password": password}).json().get("token")

       
        return unique_email, password, auth_token
        
    except Exception:
        return None, None, None  # Zwracamy None zamiast błędów
    


def check_mail(auth_token):
    while time.time() < 360:  # Sprawdza przez 360 sekund (6 minut)
        # Pobranie wiadomości
        messages = requests.get("https://api.mail.tm/messages", headers={"Authorization": f"Bearer {auth_token}"}).json().get("hydra:member", [])

        if messages:
            return messages  # Zwracamy wiadomości natychmiast po ich otrzymaniu
        
        time.sleep(5)  # Czekamy 5 sekund przed kolejną próbą

    return []  # Jeśli nie było wiadomości w czasie 360 sek., zwracamy pustą listę