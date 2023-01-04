//
//  ForecastListView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import SwiftUI

struct ForecastListView: View {
  var forecast: Forecast
  var backgroundColor: String

  var body: some View {
    ZStack {
      Color(backgroundColor)
      VStack(spacing: 0) {
        Divider()
          .frame(height: 16)
          .overlay(Color(backgroundColor))
        VStack(spacing: 8.0) {
          ForEach(forecast.fiveDayForcast, id: \.dt) { forcastItem in
            ForecastItemView(forcastItem: forcastItem)
          }
        }
      }
    }
  }
}

#if DEBUG
struct ForecastListView_Previews: PreviewProvider {
    static var previews: some View {
      ForecastListView(
        forecast: Forecast(
        message: 0,
        list: [
          Current(
            dt: 1553709600,
            coord: nil,
            weather: [Current.Weather(id: 800, main: "Rain", description: "Rainy day", icon: "01d")],
            main: Current.Main(
              temp: 25.3,
              feels_like: 23,
              temp_min: 20.4,
              temp_max: 27.3,
              pressure: 500,
              humidity: 1012,
              sea_level: 100,
              grnd_level: 0),
            rain: nil,
            wind: Current.Wind(speed: 200, deg: 10, gust: 1.2),
            clouds: Current.Clouds(all: 100)),
          Current(
            dt: 1553709600,
            coord: nil,
            weather: [Current.Weather(id: 800, main: "Rain", description: "Rainy day", icon: "01d")],
            main: Current.Main(
              temp: 25.3,
              feels_like: 23,
              temp_min: 20.4,
              temp_max: 27.3,
              pressure: 500,
              humidity: 1012,
              sea_level: 100,
              grnd_level: 0),
            rain: nil,
            wind: Current.Wind(speed: 200, deg: 10, gust: 1.2),
            clouds: Current.Clouds(all: 100)),
          Current(
            dt: 1553709600,
            coord: nil,
            weather: [Current.Weather(id: 800, main: "Rain", description: "Rainy day", icon: "01d")],
            main: Current.Main(
              temp: 25.3,
              feels_like: 23,
              temp_min: 20.4,
              temp_max: 27.3,
              pressure: 500,
              humidity: 1012,
              sea_level: 100,
              grnd_level: 0),
            rain: nil,
            wind: Current.Wind(speed: 200, deg: 10, gust: 1.2),
            clouds: Current.Clouds(all: 100)),
          Current(
            dt: 1553709600,
            coord: nil,
            weather: [Current.Weather(id: 800, main: "Rain", description: "Rainy day", icon: "01d")],
            main: Current.Main(
              temp: 25.3,
              feels_like: 23,
              temp_min: 20.4,
              temp_max: 27.3,
              pressure: 500,
              humidity: 1012,
              sea_level: 100,
              grnd_level: 0),
            rain: nil,
            wind: Current.Wind(speed: 200, deg: 10, gust: 1.2),
            clouds: Current.Clouds(all: 100)),
          Current(
            dt: 1553709600,
            coord: nil,
            weather: [Current.Weather(id: 800, main: "Rain", description: "Rainy day", icon: "01d")],
            main: Current.Main(
              temp: 25.3,
              feels_like: 23,
              temp_min: 20.4,
              temp_max: 27.3,
              pressure: 500,
              humidity: 1012,
              sea_level: 100,
              grnd_level: 0),
            rain: nil,
            wind: Current.Wind(speed: 200, deg: 10, gust: 1.2),
            clouds: Current.Clouds(all: 100))
        ]), backgroundColor: ConditionType.Condition.sunny.rawValue)
    }
}
#endif
