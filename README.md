# SKYCAST

SKYCAST is a Flutter app that allows users to search for and display current weather information for a given city. The app uses the OpenWeatherMap API to fetch weather data.

## Features

- ✅ Home screen with a search bar to enter a city name
- ✅ Weather details screen to display the weather information
- ✅ Loading indicator while fetching data
- ✅ Displays city name, current temperature (in Celsius), weather condition, an icon representing the weather condition, humidity percentage, and wind speed
- ✅ Error handling for API requests with user-friendly error messages
- ✅ State management using Provider
- ✅ Responsive design for both mobile and tablet devices
- ✅ "Refresh" button to fetch updated weather data
- ✅ Data persistence to save the last searched city

## Install .apk

[![Install with SkyCast](https://img.shields.io/badge/Install%20SkyCast-blue)](https://drive.google.com/file/d/11irKYYLqUczXDWHut-Ash_UyCW3B8Kr2/view?usp=sharing)

## Dev Installation

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
    - Navigate to the `lib/constants` folder and open the file `api_constants.dart` where the API key is stored.
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
<p align="center">
  <img src="https://github.com/helloamj/SkyCast-Frontend/assets/110400753/044a149d-5a4e-43c1-a2ba-1a2836130b4d" width="120"  />
  <img src="https://github.com/helloamj/SkyCast-Frontend/assets/110400753/09d798bc-c52d-4fb3-860b-d26d11feae5e" width="120" /> 
  <img src="https://github.com/helloamj/SkyCast-Frontend/assets/110400753/d921b634-44d2-4d4b-a030-e49dea2d8ab8" width="120" />
</p>
### Weather Details Screen
<p align="center">
  <img src="https://github.com/helloamj/SkyCast-Frontend/assets/110400753/25144a53-f9a5-4f5b-8c72-346ea2e06e89" width="120"  />
  <img src="https://github.com/helloamj/SkyCast-Frontend/assets/110400753/3010c340-7f19-43b0-b3d9-932bec8e8edf" width="240" /> 
</p>

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or feedback, feel free to reach out to me at jainkunal129@gmail.com.

