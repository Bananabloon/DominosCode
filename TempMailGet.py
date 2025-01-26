import requests
import uuid
import json
import time

# Step 1: Get the valid domain and create a unique email address
domain_url = "https://api.mail.tm/domains"
try:
    domain_response = requests.get(domain_url)
    if domain_response.status_code == 200:
        domains = domain_response.json()["hydra:member"]
        if domains:
            valid_domain = domains[0]["domain"]  # Use the first valid domain
        else:
            raise ValueError("No valid domains available.")
    else:
        raise ValueError("Failed to fetch domains.")
except Exception as e:
    print(f"Error fetching domains: {e}")
    exit()

# Generate a unique email address
unique_email = f"{uuid.uuid4().hex[:8]}@{valid_domain}"

# Set a secure password
password = "securepassword123"

# Step 2: Create the account on Mail.tm
create_url = "https://api.mail.tm/accounts"
dataToApi = {
    "address": unique_email,
    "password": password
}
headers = {
    "Content-Type": "application/json",
}

try:
    response = requests.post(create_url, headers=headers, json=dataToApi)
    if response.status_code == 201:
        print("Account created successfully!")
        print("Unique Email Address:", unique_email)
        print("Response:", json.dumps(response.json(), indent=4))
    else:
        print(f"Failed to create account. Status code: {response.status_code}")
        print("Response:", response.text)
        exit()
except requests.exceptions.RequestException as e:
    print(f"An error occurred: {e}")
    exit()

# Step 3: Authenticate and get the auth token
auth_url = "https://api.mail.tm/token"
auth_data = {
    "address": unique_email,
    "password": password
}

try:
    auth_response = requests.post(auth_url, headers=headers, json=auth_data)
    if auth_response.status_code == 200:
        auth_token = auth_response.json()["token"]
        print("Authenticated successfully. Token:", auth_token)
    else:
        raise ValueError(f"Authentication failed. Status code: {auth_response.status_code}")
except requests.exceptions.RequestException as e:
    print(f"An error occurred during authentication: {e}")
    exit()



time.sleep(360)
# Step 5: Fetch the messages from the inbox using the auth token
messages_url = "https://api.mail.tm/messages"
messages_headers = {
    "Authorization": f"Bearer {auth_token}"
}

try:
    messages_response = requests.get(messages_url, headers=messages_headers)
    if messages_response.status_code == 200:
        messages = messages_response.json()
        if messages:
            print("Received messages:", json.dumps(messages, indent=4))
        else:
            print("No messages found.")
    else:
        print(f"Failed to fetch messages. Status code: {messages_response.status_code}")
        print("Response:", messages_response.text)
except requests.exceptions.RequestException as e:
    print(f"An error occurred while fetching messages: {e}")
