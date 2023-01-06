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
  var condition: String
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(favorite.city ?? "saved_location".localized())
          .foregroundColor(Color.white)
        Spacer()
        Text(currentViewModel.current?.weather[0].description.capitalized ?? "")
          .foregroundColor(Color.white)
      }
      Spacer()
      if currentViewModel.current != nil {
        VStack(alignment: .trailing) {
          Text("\((Date.now.date(with: currentViewModel.current?.timezone)))")
            .foregroundColor(Color.white)
          Spacer()
          HStack(alignment: .center, spacing: 4) {
            Text("\((currentViewModel.current?.main.feels_like.roundDouble())!)°")
              .foregroundColor(Color.white)
            Image((currentViewModel.condition)!)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .foregroundColor(Color.white)
              .frame(width: 32, height: 32, alignment: .center)
          }
        }
      }
    }
    .padding(
      EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    )
    .background(Color(currentViewModel.condition ?? condition))
    .border(.white, width: 2)
    .onAppear {
      currentViewModel.fetchCurrent(for: CLLocation(latitude: favorite.latitude, longitude: favorite.longitude))
    }
    .animation(Animation.easeInOut.speed(0.25), value: currentViewModel.condition)
  }
}
