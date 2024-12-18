# TravelMate App

TravelMate is a cross-platform Flutter app designed for travelers and tourists, offering features like note-taking, photo capturing, GPS tracking, and user-friendly account management.

## Features

- **Authentication**: Signup/login with email and password.  
- **GPS Tracking**: View current location and Points of Interest (POI).  
- **Notes**: Save, view, and delete notes.  
- **Photo Management**: Capture and view photos.  
- **Paywall**: Unlock extra save slots via in-app payments.  
- **User Profile**: View and update profile information.  
- **Localization**: Supports two languages.  

### Additional Features  
- Text-to-speech, toast notifications, permissions handling, and a custom navigation bar.

## Tech Stack

- **Frontend**: Flutter (Dart)  
- **Backend**: Firebase (Authentication, Firestore, Storage)  
- **IDE**: Visual Studio Code  

## App Architecture

- **Screens**: Home, Camera, Notes, Maps, Login, Signup, and Settings.  
- **Services**: Firebase, Camera, Notes, Login, and Location.  
- **Utilities**: Custom themes, constants, and validators.  

## Installation

1. Clone the repository:  
   ```bash
   git clone <repository-url>
   ```  
2. Navigate to the project directory:  
   ```bash
   cd travelmate
   ```  
3. Install dependencies:  
   ```bash
   flutter pub get
   ```  
4. Run the app:  
   ```bash
   flutter run
   ```
