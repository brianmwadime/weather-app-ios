//
//  FavoriteCardView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/5/23.
//

import SwiftUI
import CoreLocation

struct FavoriteCardView: View {
  @StateObject var currentViewModel: CurrentViewModel = CurrentViewModel(weatherService: WeatherService(network: DefaultNetworkService()))
//  @State var timer: Timer
  var favorite: FavoriteLocation
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(favorite.city)
          .foregroundColor(Color.white)
        Spacer()
        if currentViewModel.weather != nil {
          Text(currentViewModel.weather!.description.capitalized)
            .foregroundColor(Color.white)
        }
      }
      Spacer()
      VStack(alignment: .trailing) {
        if currentViewModel.date != nil {
          Text(currentViewModel.date!.format(with: currentViewModel.timeZone))
            .foregroundColor(Color.white)
        }
        Spacer()
        HStack(alignment: .center, spacing: 4) {
          Text("\((currentViewModel.feelsLike.roundDouble()))°")
            .foregroundColor(Color.white)
          Image(currentViewModel.condition)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.white)
            .frame(width: 32, height: 32, alignment: .center)
        }
      }
    }
    .padding(
      EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    )
    .background(Color(currentViewModel.condition))
    .border(.white, width: 2)
    .onAppear {
      currentViewModel.fetchCurrent(for: CLLocation(latitude: favorite.latitude, longitude: favorite.longitude))
    }
    .animation(Animation.easeInOut.speed(0.25), value: currentViewModel.condition)
  }
}
