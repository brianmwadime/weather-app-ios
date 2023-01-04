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
          Text(forcastItem.dayOfTheWeek)
            .font(.system(size: 18))
          .foregroundColor(.white)
          .frame(maxWidth: .infinity, alignment: .leading)

          Image(forcastItem.condition)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.white)
            .frame(width: 32, height: 32, alignment: .center)

          Text("\(forcastItem.main.temp.roundDouble())°")
          .foregroundColor(.white)
          .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding([.leading, .trailing])
    }
}

#if DEBUG
struct ForecastItemView_Previews: PreviewProvider {
    static var previews: some View {
      ForecastItemView(forcastItem: Current(
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
        clouds: Current.Clouds(all: 100)))
    }
}
#endif
