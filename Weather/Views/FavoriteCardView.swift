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
          Text(favorite.city ?? "saved_location".localized())
            .foregroundColor(Color.white)
          Spacer()
          Text(currentViewModel.current?.weather[0].description ?? "")
            .foregroundColor(Color.white)
        }
        Spacer()
        if currentViewModel.current != nil {
          VStack(alignment: .trailing) {
            Text("\((currentViewModel.current?.date.date(with: currentViewModel.current?.timezone))!)")
              .foregroundColor(Color.white)
            Spacer()
            HStack(alignment: .center, spacing: 4) {
              Text("\((currentViewModel.current?.main.feels_like.roundDouble())!)°")
                .foregroundColor(Color.white)
              Image((currentViewModel.current?.condition)!)
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
      .background(Color(currentViewModel.current?.condition ?? "sunny"))
      .border(.white, width: 2)
      .onAppear {
        currentViewModel.fetchCurrent(for: CLLocation(latitude: favorite.latitude, longitude: favorite.longitude))
      }
    }
}
