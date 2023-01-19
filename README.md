<h1 align="center"><img src="docs/images/logo.png" width="300"><br>for iOS</h1>

<p align="center">
    <a href="#-build-instructions">Build Instructions</a> •
    <a href="#-documentation">Documentation</a> •
    <a href="#-contributing">Contributing</a> •
    <a href="#-automation">Automation</a>
</p>

## Build Instructions

1. Download Xcode

   At the moment _Weather for iOS_ uses Swift 5 and requires Xcode 13 or newer.

2. Install Ruby. We recommend using [rbenv](https://github.com/rbenv/rbenv) to install it. Please refer to the [`.ruby-version` file](.ruby-version) for the required Ruby version.

   We use Ruby to manage the third party dependencies and other tools and automation.

3. Clone project in the folder of your preference

   ```bash
   git clone https://github.com/brianmwadime/weather-app-ios.git
   ```

4. Enter the project directory

   ```bash
   cd weather-app-ios
   ```

5. Install the third party dependencies and tools required to run the project.

   ```bash
   bundle install && bundle exec rake dependencies
   ```

   This command installs the required tools.

6. Open the project by double clicking on `Weather.xcodeproj` file, or launching Xcode and choose File > Open and browse to `Weather.xcodeproj`

## Documentation

- Architecture
  - [Overview](docs/architecture-overview.md)
- Coding Guidelines

  - [Coding Style](docs/style-guide.md)
  - [Naming Conventions](docs/naming-conventions.md)
    - [Protocols](docs/naming-conventions.md#protocols)
    - [String Constants in Nested Enums](docs/naming-conventions.md#string-constants-in-nested-enums)
    - [Test Methods](docs/naming-conventions.md#test-methods)
  - [Choosing Between Structures and Classes](docs/choosing-between-structs-and-classes.md)

  - [Localization](docs/localization.md)

- Features
  - Get weather forecast based on users's current location.
  - Uses [Open Weather](https://openweathermap.org/api) to fetch weather data.
  - Background Image and color changes depending on the type of weather.
  - Ability to manage a list of favourite locations as well as show current weather conditions.
  - Offline mode - App shows cached forecast info when device is offline.
  - A Map view for displaying favourite locations.
  - Uses MapKit's [`MKLocalSearch`](https://developer.apple.com/documentation/mapkit/mklocalsearch) to search and return extra info for provided coordinates.

## Automation

### Hound

The weather-app-ios project uses [HoundCI](http://houndci.com/) to enforce style guidelines.

### Slather

The weather-app-ios project uses [Slather](https://github.com/SlatherOrg/slather) to generate test coverage reports.

### Github Actions

The weather-app-ios project uses [Github Actions](https://github.com/brianmwadime/weather-app-ios) for continuous integration.

<p align="center">
    <br/><br/>
    Made with 💜 by <a href="https://github.com/brianmwadime">Weather iOS</a>.<br/>
</p>
