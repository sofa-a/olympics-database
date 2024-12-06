import kaggle
import os

def download_database():
    # Authenticate using kaggle.json
    kaggle.api.authenticate()

    # Download a Kaggle dataset
    kaggle.api.dataset_download_files('piterfm/paris-2024-olympic-summer-games', path='./data', unzip=True)

def display_structure():
    print(os.listdir('./data'))


