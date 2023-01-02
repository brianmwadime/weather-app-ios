//
//  CurrentView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation
import SwiftUI
import CoreData

struct CurrentView: View {
  var current: Current

  var body: some View {
    ZStack(alignment: .leading) {
      VStack(spacing: 0) {
        Image("sea_\(current.getWeatherCondition())")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(maxWidth: .infinity, maxHeight: 320)
        TemperatureView(main: current.main)
          .background(Color(current.getWeatherCondition()))
      }
      .frame(maxWidth: .infinity, maxHeight: 660)
      VStack {
        VStack(alignment: .center, spacing: 5) {
          Text("\(current.main.temp.roundDouble())°")
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.system(size: 50))
          Text("SUNNY")
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 30))
        }
        .frame(maxWidth: .infinity, alignment: .center)
      }
      .frame(maxWidth: .infinity, alignment: .center)
    }
    .edgesIgnoringSafeArea(.all)
  }
}

#if DEBUG
struct CurrentView_Previews: PreviewProvider {
  static var previews: some View {
    CurrentView(
      current: Current(
        dt: 1553709600,
        coord: nil,
        weather: [],
        main: Current.Main(temp: 25.3, feels_like: 23, temp_min: 20.4, temp_max: 27.3, pressure: 500, humidity: 1012, sea_level: 100, grnd_level: 0),
        rain: nil,
        wind: Current.Wind(speed: 200, deg: 10, gust: 1.2),
        clouds: Current.Clouds(all: 100)))
  }
}
#endif
