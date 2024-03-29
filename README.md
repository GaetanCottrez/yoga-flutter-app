<div>
  <h1 align="center">Yoga Flutter App</h1>

  <div align="center">
    <a href="https://github.com/GaetanCottrez/yoga-flutter-app/stargazers"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/GaetanCottrez/yoga-flutter-app"></a>
    <a href="https://www.linkedin.com/in/gaetan-cottrez/"><img alt="LinkedIn Profile" src="https://img.shields.io/badge/LinkedIn-0077B5?logo=linkedin&logoColor=white"></a>
    <a href="https://github.com/GaetanCottrez/yoga-flutter-app/blob/master/LICENSE.md"><img alt="License" src="https://img.shields.io/badge/License-MIT-yellow.svg"></a>
  </div>
</div>

<br/>

Yoga Training App is a yoga workout tracking application that helps you track your sessions and
improve your yoga practice.

<i><b>Notice: The application is far from finished. It was created in MVP mode for an end-of-study
project in less than 3 weeks</b></i>

## Imagined Features

- User-friendly interface for easy navigation.
- Yoga workout session tracking.
- Yoga pose timer with visual.
- Ability to create and customize personalized workout sessions.
- Access to a library of yoga poses with detailed descriptions.
- Reminder feature to help you stay consistent with your yoga practice.
- Session search by criteria
- Authentication
- Create account
- Manage profile
- Display complex statistics with charts

## V0 Features

- [X] User-friendly interface for easy navigation.
- [X] Yoga pose timer with visual.
- [X] Access to a library of yoga poses with detailed descriptions.
- [X] Session search by criteria
- [X] Authentication
- [X] Display some statistics

## Tech Stack

- [Flutter](https://flutter.dev) – framework

## Getting Started

### Prerequisites

Here's what you need to be able to run Yoga Flutter App:

- Flutter (version >= 3.16.5)
- Dart (version >= 3.2.3)
- an API that works and runs (the repository of API is [here](https://github.com/AnhVaccari/yoga))

### 1. Clone the repository

```shell
git clone https://github.com/GaetanCottrez/yoga-flutter-app
cd yoga-flutter-app
```

### 2. Install dependencies

```shell
  flutter pub get
```

### 3. Check for outdated dependencies (optionnal)

```shell
  flutter pub outdated
```

### 3. Open the iOS simulator

```shell
  open -a Simulator
```

### 4. Configure the variables

Before running the application, make sure to properly configure the following settings:

- **lib/core/config/base_url_config.dart**: In this file, you can set the base URLs for the
  development and production environments.

  ```dart
  class BaseUrlConfig {
    final String baseUrlDevelopment = 'http://localhost:3000/';
    final String baseUrlProduction = 'https://reqres.in/api/';
  }
  ```

- **lib/core/config/constant_config.dart**: In this file, you can set the constant values used in
  the application. For example, the duration of each yoga pose can be configured as follows:

  ```dart
  class ConstantConfig {
    final int durationPose = 15;
  }
  ```

- **lib/core/config/material_config.dart**: In this file, you can define the colors and padding
  values used in the Material design of your application. Here's an example:

  ```dart
  const Color primary = Color(0xff51bdad);
  const Color secondary = Color(0xff97dad1);
  const Color black = Color(0xff040909);
  const Color white = Color(0xfff8fcfc);
  const Color third = Color(0xff67cdbe);
  const double appPadding = 20.0;
  const double dividerThickness = 2;
  ```

### 5. Run the dev app

```shell
flutter run -t lib/main_development.dart
```

### 6. Run the production app (optionnal)

```shell
flutter run
```

## Screenshot

<img alt="Screenshot 0" src="/screenshot/screenshot0.png" width="300"/>.
<img alt="Screenshot 1" src="/screenshot/screenshot1.png" width="300"/>.
<img alt="Screenshot 2" src="/screenshot/screenshot2.png" width="300"/>.
<img alt="Screenshot 3" src="/screenshot/screenshot3.png" width="300"/>.
<img alt="Screenshot 4" src="/screenshot/screenshot4.png" width="300"/>.
<img alt="Screenshot 5" src="/screenshot/screenshot5.png" width="300"/>.
<img alt="Screenshot 6" src="/screenshot/screenshot6.png" width="300"/>.
<img alt="Screenshot 7" src="/screenshot/screenshot7.png" width="300"/>.

## Contributing

If you'd like to contribute, please fork the repository and make changes as you'd like. Pull
requests are warmly welcome.

### Our Contributors ✨

<a href="https://github.com/GaetanCottrez/yoga-flutter-app/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=GaetanCottrez/yoga-flutter-app" />
</a>

## Inspiration

- [Yoga-Training-App-UI](https://github.com/SayujSujeev/Yoga-Training-App-UI)

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

We hope that this enhanced version of the README will be helpful for sharing your Yoga Flutter App
with other developers and users.

If you have any further questions or need additional assistance, feel free to ask. Happy coding!