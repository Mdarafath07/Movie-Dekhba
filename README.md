# Movie Dekhba

Movie Dekhba is a modern, fully responsive Flutter movie streaming app built with Clean Architecture, featuring a Netflix-like UI, Riverpod state management, and TMDB API integration.

## Features
- **Authentication**: Firebase Auth (Email/Password & Google Sign-In)
- **Netflix Style UI**: Trending hero banner, popular carousels, responsive design.
- **Movie Details**: Full information, cast, ratings.
- **Search**: Real-time TMDB search.
- **Play System**: WebView integration for watching movies.

## Prerequisites
- Flutter SDK (latest stable)
- Firebase Account
- TMDB API Key

## Setup Guide

### 1. TMDB API Key
1. Go to [TMDB](https://www.themoviedb.org/) and create an account.
2. Navigate to your Account Settings -> API, and request an API key.
3. In the root directory of this project, create a `.env` file:
   ```env
   TMDB_API_KEY=your_actual_tmdb_api_key_here
   ```

### 2. Firebase Setup
Since this project uses Firebase Auth, you need to set it up:
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project named "Movie Dekhba".
3. Run `flutterfire configure` in the root of the project to generate/update your `firebase_options.dart` file.
4. In the Firebase Console, go to **Authentication > Sign-in method**.
5. Enable **Email/Password** and **Google** sign-in providers.

### 3. Running the App
1. Get the dependencies:
   ```bash
   flutter pub get
   ```
2. Generate models (if needed):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Architecture
The app follows Clean Architecture principles:
- `lib/core`: Utilities, Network, Theme
- `lib/api`: API Constants
- `lib/models`: Data structures
- `lib/repositories`: Data fetching (API/Firebase)
- `lib/providers`: Riverpod state
- `lib/screens`: UI screens

Enjoy watching on Movie Dekhba!
