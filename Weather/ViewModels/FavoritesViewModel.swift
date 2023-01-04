//
//  FavoritesViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
  @Published var query: String?
  @Published var favorites: [FavoriteLocation] = []
  @Published var error: Error?

  let repository: any RepositoryType

  init(repository: RepositoryType) {
    self.repository = repository
  }

  @discardableResult
  func save(city: String, latitude: Double, longitude: Double) -> FavoriteLocation {
    let favorite = FavoriteLocation(context: repository.context)
    favorite.city = city
    favorite.latitude = latitude
    favorite.longitude = longitude
    repository.create(favorite)
    return favorite
  }

  func update() {

  }

  func fetch() {
    let result = repository.fetch(FavoriteLocation.self, predicate: nil, limit: nil)

    switch result {
      case .success(let favorites):
        self.favorites = favorites
      case .failure(let error):
        self.error = error
    }
  }

  func delete(_ location: FavoriteLocation) {
    repository.delete(location)
  }

}
