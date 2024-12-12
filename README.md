# Rick and Morty Flutter App

A Flutter-based application that displays characters from the Rick and Morty universe, leveraging the Rick and Morty API. This project demonstrates best practices in Flutter development, including API integration, pagination, search, filtering, and error handling.

## Features

1. **API Integration**:
    - Fetches character data from [Rick and Morty API](https://rickandmortyapi.com/api/character).
    - Handles network errors and displays appropriate messages.

2. **Data Model**:
    - Built using Dart's `json_serializable` package for structured and efficient data parsing.

3. **UI Implementation**:
    - **List View**: Displays characters with name, species, status, and image.
    - **Detail View**: Shows detailed character information (name, species, status, gender, origin, location).

4. **Advanced Features**:
    - **Search**: Filters characters by name using a search bar.
    - **Filter**: Enables filtering by status (Alive, Dead, Unknown, None).
    - **Pagination**: Loads more characters as the user scrolls down - NotificationListener.
    - **Error Handling**: Displays user-friendly error messages for network or parsing issues.

## Requirements

- Dart 3.x
- Flutter 3.x
- Internet connection for API calls

## Setup Instructions

1. Clone the Repository:
   ```bash
   git clone https://github.com/hodg300/rick_and_morty_app.git

2. Install Dependencies:
   ```bash
   flutter pub get
3. Run the App:
   ```bash
   flutter run
   
## Unit tests:
    ```bash
       flutter test test/rick_and_morty_provider_test.dart



