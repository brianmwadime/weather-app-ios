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
  var favorite: MapAnnotation
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(favorite.name)
          .foregroundColor(Color.white)
        Spacer()
        Text(currentViewModel.weather?.description.capitalized ?? "not_available".localized())
          .foregroundColor(Color.white)
      }
      Spacer()
      VStack(alignment: .trailing) {
        Text(Date.now.format(with: currentViewModel.timeZone))
          .foregroundColor(Color.white)
        Spacer()
        HStack(alignment: .center, spacing: 4) {
          Text("\(currentViewModel.feelsLike?.roundDouble() ?? "not_available".localized())°")
            .foregroundColor(Color.white)
          Image.iconFor(condition: currentViewModel.condition)?
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.white)
            .frame(width: 32, height: 32, alignment: .center)
        }
      }
    }
    .padding(
      EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    )
    .background(Color(currentViewModel.condition))
    .border(.white, width: 2)
    .onAppear {
      currentViewModel.fetchCurrent(
        for: CLLocation(latitude: favorite.coordinate.latitude, longitude: favorite.coordinate.longitude))
    }
    .animation(Animation.easeInOut.speed(0.25), value: currentViewModel.condition)
  }
}
