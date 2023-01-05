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

  let repository: RepositoryType

  init(repository: RepositoryType) {
    self.repository = repository
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

  func update() {

  }

  func fetch() {
    let request = FavoriteLocation.fetchRequest()

    if let result = try? repository.context.fetch(request) {
      self.favorites = result
      return
    }

    let result = repository.fetch(FavoriteLocation.self, predicate: nil, limit: nil)

    switch result {
      case .success(let favorites):
        print(favorites)
//        self.favorites = favorites
      case .failure(let error):
        self.error = error
    }
  }

  func delete(_ location: FavoriteLocation) {
    repository.delete(location)
  }

}
