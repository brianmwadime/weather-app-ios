//
//  ForecastItemView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import SwiftUI

struct ForecastItemView: View {
  var forcastItem: Current
    var body: some View {
        HStack {
          Text(forcastItem.getdayOfTheWeek())
          .foregroundColor(.white)
          Spacer()
          Image(forcastItem.getWeatherCondition())
            .resizable()
            .aspectRatio(contentMode: .fit)
//            .aspectRatio(UIImage(named: forcastItem.getWeatherCondition())!.size, contentMode: .fit)
            .frame(width: 50, height: 25)
          Spacer()
          Text("\(forcastItem.main.temp.roundDouble())°")
          .foregroundColor(.white)
        }
        .padding([.leading, .trailing])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//      .background(Color.clear)
    }
}

#if DEBUG
struct ForecastItemView_Previews: PreviewProvider {
    static var previews: some View {
      ForecastItemView(forcastItem: Current(
        dt: 1553709600,
        coord: nil,
        weather: [Current.Weather(id: 800, main: "Rain", description: "Rainy day", icon: "01d")],
        main: Current.Main(temp: 25.3, feels_like: 23, temp_min: 20.4, temp_max: 27.3, pressure: 500, humidity: 1012, sea_level: 100, grnd_level: 0),
        rain: nil,
        wind: Current.Wind(speed: 200, deg: 10, gust: 1.2),
        clouds: Current.Clouds(all: 100)))
    }
}
#endif
