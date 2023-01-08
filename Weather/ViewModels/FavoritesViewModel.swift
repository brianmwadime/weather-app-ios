//
//  FavoritesViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import Foundation
import Combine

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
      return favorites.map { MapAnnotation(name: $0.city, coordinate: $0.coordinate) }
    }

    return [MapAnnotation(name: "My Location", coordinate: location.coordinate)] +
    favorites.map { MapAnnotation(name: $0.city, coordinate: $0.coordinate) }
  }

  @discardableResult
  func save(city: String, latitude: Double, longitude: Double) -> FavoriteLocation? {

    let request = FavoriteLocation.fetchRequest()
    request.predicate = NSPredicate(
      format: "%K == %@",
      #keyPath(FavoriteLocation.city),
      city
    )

    request.fetchLimit = 1

    if let result = try? repository.context.fetch(request),
       let favoriteLocation = result.first {
      return favoriteLocation
    }

    let favorite = FavoriteLocation(context: repository.context)
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

  func deleteItems(_ offsets: IndexSet) {
    offsets.map { favorites[$0] }.forEach { toDelete in
      do {
        try repository.delete(toDelete)
      } catch {

      }
    }

    favorites.remove(atOffsets: offsets)
  }

}
