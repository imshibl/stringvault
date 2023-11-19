# String Vault - Text Encryption & Decryption App

SecureVault is a Flutter application designed to provide users with an unparalleled level of data security and privacy. Offering a seamless blend of SQFlite, Encrypt, and Provider packages, this app empowers users to encrypt, store, and decrypt sensitive information effortlessly, ensuring confidentiality and peace of mind.

## Features

- **Encrypt and Save:** Users can encrypt a string and store it locally in a secure SQLite database.
  
- **Decrypt and Display:** Users can decrypt the stored encrypted strings and display them on the user interface.

- **List View:** Multiple encrypted strings can be stored, and they are displayed in a list view using a ListView Builder.

- **Copy and Delete:** Each item in the list view has buttons to copy the encrypted value of the string and delete the entry.

## Dependencies

This app utilizes the following Flutter packages:

- **sqflite:** A SQLite plugin for Flutter, providing a local database to store encrypted strings.

- **encrypt:** A library for encryption and decryption, used to secure the stored data.

- **provider:** A state management library for Flutter, separating business logic and UI.

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/imshibl/stringvault
```
2. Navigate to the project directory:
```bash
cd secure_storage_app
```
3. Install dependencies:
```bash
flutter pub get
```
4. Run the app:
```bash
flutter run
```

## Usage
1. Launch the app on your device or emulator.

2. Enter a string in the provided text field.

3. Press the "Encrypt and Save" button to store the encrypted string securely.

4. View the list of stored data in the app.

5. Tap on an item in the list to decrypt and display/copy the original string.

6. Use the delete icon to remove an entry from the list and copy icon to copy the encrypted string.

## Folder Structure

The SecureVault app follows a well-organized folder structure, promoting clarity and maintainability. Here's an overview of each directory:

- **const/:**
  - Holds constants(colours, themes) used throughout the app, providing a centralized location for easy updates.

- **models/:**
  - **data_model.dart:**
    - Defines the data model structure for the app.

- **providers/:**
  - **data_provider.dart:**
    - Utilizes the `provider` package for managing the state related to data handling.
    - Contains methods for encrypting, decrypting, storing, and deleting data.

- **services/:**
  - **database_services.dart:**
    - Manages the SQLite database and provides functions for storing and retrieving encrypted data.

- **utils/:**
  - **snackbar.dart:**
    - Provides utility functions for displaying snackbars, enhancing user feedback.

- **views/:**
  - **home_view.dart:**
    - The main view of the app where users interact with encrypted data.
    - Utilizes `ListView.builder` to dynamically display a list of encrypted data entries.
    - Includes UI elements for encrypting, decrypting, and deleting data.

This organized structure enhances code maintainability, readability, and scalability, allowing for efficient development and future enhancements.


## Contributing
If you have any suggestions, find issues, or want to contribute, please open an issue or submit a pull request.



