//
//  TemperatureView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import SwiftUI

struct TemperatureView: View {
  var main: Current.Main
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        VStack(alignment: .center) {
          Text("\(main.temp_min.roundDouble())°")
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.system(size: 16))
          Text("min")
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 14))
        }
        Spacer()
        VStack(alignment: .center) {
          Text("\(main.temp.roundDouble())°")
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.system(size: 16))
          Text("Current")
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 14))
        }
        Spacer()
        VStack(alignment: .center) {
          Text("\(main.temp_max.roundDouble())°")
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.system(size: 16))
          Text("max")
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 14))
        }
      }
      .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
      .frame(maxWidth: .infinity)
      Divider()
      .frame(height: 1)
      .background(Color.white)
    }
  }
}

struct CurrentMainView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(main: Current.Main(
          temp: 25.3,
          feels_like: 23,
          temp_min: 20.4,
          temp_max: 27.3,
          pressure: 500,
          humidity: 1012,
          sea_level: 100,
          grnd_level: 0))
    }
}
