import requests
import time

def health_check(url):
    try:
        response = requests.get(url, timeout=10)
        if response.status_code == 200:
            print(f"The application at {url} is up!")
        else:
            print(f"Oops! The application at {url} is down. HTTP Status Code: {response.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"Application unavailable! Error: {e}")


def main():
    url = input("Enter the URL of the application to check: ")
    health_check(url)

if __name__ == "__main__":
    main()
