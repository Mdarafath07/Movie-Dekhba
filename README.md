🎬 Movie Dekhba

Movie Dekhba is a modern, fully responsive Flutter movie streaming application designed with a clean and scalable architecture. It delivers a smooth, Netflix-style browsing experience with rich UI, fast search, and seamless authentication.

✨ Features
🔐 Authentication
Email & Password login system
Google Sign-In support
Secure user session handling
🎥 Modern UI/UX
Netflix-inspired interface
Trending hero banner section
Horizontal movie carousels (Popular, Top Rated, Trending)
Fully responsive design for all screen sizes
🎬 Movie Experience
Detailed movie pages with posters, ratings, and descriptions
Cast & related information display
Smooth navigation between screens
🔎 Smart Search
Real-time movie search functionality
Instant results with responsive UI updates
▶️ Watching Experience
In-app web-based playback system
Smooth transition from details to player screen
🧠 Architecture

The project is built using Clean Architecture principles for scalability and maintainability:

core/ → App-wide utilities, theme, and network helpers
api/ → API configuration and endpoints handling
models/ → Data models and parsing logic
repositories/ → Data fetching layer (remote services)
providers/ → State management using Riverpod
screens/ → UI pages and views
⚙️ Setup Instructions
1. Environment Configuration

Create a .env file in the root directory:

API_KEY=your_api_key_here

This key is used to fetch all movie-related data from the backend service.

2. Backend Service Setup
Create an account on the movie data provider platform
Generate your API key from the developer section
Enable necessary access permissions for movie data and search
3. Firebase Setup

This project uses Firebase for authentication:

Create a Firebase project
Add Android & iOS apps
Enable:
Email/Password authentication
Google authentication
Run configuration:
flutterfire configure
4. Run the Project

Install dependencies:

flutter pub get

Generate required files:

flutter pub run build_runner build --delete-conflicting-outputs

Run the app:

flutter run
🚀 Tech Stack
Flutter (UI Framework)
Riverpod (State Management)
Firebase Authentication
REST-based movie data service
Clean Architecture Pattern
🎯 Goal

The goal of Movie Dekhba is to provide a smooth, elegant, and scalable movie browsing experience with a production-level Flutter architecture that is easy to maintain and extend.
