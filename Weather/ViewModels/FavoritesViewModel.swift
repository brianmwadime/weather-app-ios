//
//  FavoritesViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import Foundation
import Combine
import CoreLocation

class FavoritesViewModel: ObservableObject {
  @Published var favorites: [FavoriteLocation] = []
  @Published var error: Error?

  let locationService: LocationService
  let repository: RepositoryType

  init(repository: RepositoryType, locationService: LocationService) {
    self.repository = repository
    self.locationService = locationService
  }

  func getAnnotations() -> [MapAnnotation] {
    guard let location = locationService.lastLocation else {
      return favorites.map { MapAnnotation(
        id: $0.favoriteID,
        name: $0.city,
        coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)) }
    }

    return [MapAnnotation(id: UUID(), name: "my_location".localized(), coordinate: location.coordinate)] +
    favorites.map { MapAnnotation(
      id: $0.favoriteID,
      name: $0.city,
      coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)) }
  }

  @discardableResult
  func save(city: String, latitude: Double, longitude: Double) -> FavoriteLocation? {
    let favorite = FavoriteLocation(context: repository.context)
    favorite.favoriteID = UUID()
    favorite.city = city
    favorite.latitude = latitude
    favorite.longitude = longitude

    do {
      try repository.create(favorite)
      return favorite
    } catch {
      return nil
    }
  }

  func fetch() {
    let result = repository.fetch(FavoriteLocation.self, predicate: nil, limit: nil)

    switch result {
      case .success(let favorites):
        self.favorites = favorites
        self.error = nil
      case .failure(let error):
        self.error = error
    }
  }

  func delete(_ location: FavoriteLocation) {
    do {
      try repository.delete(location)
    } catch {

    }
  }

  func delete(_ favorite: MapAnnotation) {
    let request = FavoriteLocation.fetchRequest()
    request.predicate = NSPredicate(
      format: "%K == %@",
      #keyPath(FavoriteLocation.favoriteID),
      favorite.id as CVarArg
    )

    request.fetchLimit = 1

    if let result = try? repository.context.fetch(request),
       let favoriteLocation = result.first {
      do {
        try repository.delete(favoriteLocation)
      } catch {

      }
    }
  }

  func deleteItems(_ offsets: IndexSet) {
    offsets.map { favorites[$0] }.forEach { toDelete in
      do {
        try repository.delete(toDelete)
      } catch {

      }
    }

    favorites.remove(atOffsets: offsets)
  }

  func removeAll() {
    do {
      try repository.deleteAll(FavoriteLocation.fetchRequest())
    } catch {

    }
  }

  func clearForcast() {
    do {
      try repository.deleteAll(WeatherCurrent.fetchRequest())
      try repository.deleteAll(CurrentWeather.fetchRequest())
      try repository.deleteAll(WeatherForecast.fetchRequest())
      try repository.deleteAll(MainCurrent.fetchRequest())
    } catch {
        #if DEBUG
          print("\(error.localizedDescription)")
        #endif
    }
  }

}
