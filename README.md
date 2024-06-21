# Weather App - Flutter Project

This is a basic weather app built with Flutter that retrieves and displays weather information for multiple cities stored locally on the device.

## Features

- Fetch and display current weather data for configured cities (temperature, humidity, wind speed, etc.)
- Local storage for managing city information (consider implementing cloud storage for persistence in future versions)
- Clean and user-friendly interface (screenshots provided)

## Getting Started

### Prerequisites

- A Flutter development environment set up ([https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install))

### Running the app

1. Clone this repository.
2. Open the project in your preferred IDE.
3. Install the required dependencies using `flutter pub get`.
4. Get the api key from [Weather Api](https://www.weatherapi.com/)
5. Make .env file and wtite API_KEY=YOUR-API_KEY
6. Run the app on your desired platform using `flutter run`.

## Screenshots
![Splash Screen](https://github.com/adityaraj1702/Weather-App/blob/main/assets/images/splashScreen.png)
- **Splash Screen** - The initial screen displayed when the app launches.
![Home Screen](https://github.com/adityaraj1702/Weather-App/blob/main/assets/images/homeScreen.png)
- **Home Screen** - The main screen displaying weather information for configured cities.
![Detailed Weather Screen](https://github.com/adityaraj1702/Weather-App/blob/main/assets/images/detailedWeather.png)
- **Detailed Weather Screen** - The detailed weather screen displaying all weather information for configured cities.
![ManageCity Screen](https://github.com/adityaraj1702/Weather-App/blob/main/assets/images/managecities.png)
- **ManageCity Screen** - The manage city screen displaying all configured cities and the option to add or delete cities.
![Search City Screen](https://github.com/adityaraj1702/Weather-App/blob/main/assets/images/searchcity.png)
- **Search City Screen** - The search city screen displaying a list of cities based on the search query.
![Account Screen](https://github.com/adityaraj1702/Weather-App/blob/main/assets/images/splashScreen.png)
- **Account Screen** - The account screen displaying the user data that can be edited and is saved in the local storage. Also user can modify the units of measurement.


## Video Demo

A placeholder link to a video demo is included. You'll need to replace it with a link showcasing your app's functionality.

[Link to video demo](https://github.com/adityaraj1702/Weather-App/blob/main/assets/demoVideo/demoVideo.mp4)

## Built
[APK build](https://drive.google.com/drive/folders/1mVww_DiIR6A0XRt-QuJzGj80eGn73vjk?usp=sharing)

## Project Structure

The project is organized with a well-defined directory structure for maintainability:

- `lib`: Contains all the application's source code.
  - `data`: Houses data models and local storage logic.
  - `model`: Holds weather data models.
  - `screens`: Contains the splash screen and home screen widgets.
  - `utils`: Utility functions and constants.
- `pubspec.yaml`: Defines project dependencies and configurations.

## Contributing

I encourage contributions to this project! Feel free to submit pull requests with improvements or new features.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
