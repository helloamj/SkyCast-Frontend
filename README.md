# SKYCAST

SKYCAST is a Flutter app that allows users to search for and display current weather information for a given city. The app uses the OpenWeatherMap API to fetch weather data.

## Features

✅ Home screen with a search bar to enter a city name
✅ Weather details screen to display the weather information
✅ Loading indicator while fetching data
✅ Displays city name, current temperature (in Celsius), weather condition, an icon representing the weather condition, humidity percentage, and wind speed
✅ Error handling for API requests with user-friendly error messages
✅ State management using Provider
✅ Responsive design for both mobile and tablet devices
✅ "Refresh" button to fetch updated weather data
✅ Data persistence to save the last searched city

## Installation

To run this app on your local machine, follow these steps:

1. **Clone the repository:**

    ```sh
    git clone https://github.com/helloamj/SkyCast-Frontend.git
    cd SkyCast-Frontend
    ```

2. **Install dependencies:**

    Make sure you have Flutter installed on your machine. Then run:

    ```sh
    flutter pub get
    ```

3. **Set up OpenWeatherMap API:**

    - Sign up at [OpenWeatherMap](https://openweathermap.org/) and get your API key.
    - Navigate to the `lib/constants` folder and open the file where the API key is stored.
    - Change the value of the static variable `apiKey` to your API key:

      ```dart
      static const String apiKey = 'YOUR_API_KEY';
      ```


4. **Run the app:**

    Connect your mobile device or start an emulator, and then run:

    ```sh
    flutter run
    ```

## Usage

1. On the home screen, enter the name of the city you want to search for in the search bar.
2. Press the search button to fetch and display the weather information.
3. On the weather details screen, you can refresh the data by pressing the "Refresh" button.

## Screenshots

### Home Screen
![Home Screen](screenshots/home_screen.png)

### Weather Details Screen
![Weather Details Screen](screenshots/weather_details_screen.png)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or feedback, feel free to reach out to me at jainkunal129@gmail.com.

