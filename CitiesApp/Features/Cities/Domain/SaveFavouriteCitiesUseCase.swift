//
//  SaveFavouriteCitiesUseCase.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation
import Combine

protocol SaveFavouriteCitiesUseCaseProtocol {
  func execute(cities: Set<Int>) -> AnyPublisher<Bool, Error>
}

final class SaveFavouriteCitiesUseCase: SaveFavouriteCitiesUseCaseProtocol {
  private let repository: CityRepositoryProtocol
  
  init(repository: CityRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute(cities: Set<Int>) -> AnyPublisher<Bool, Error> {
    return repository.saveFavouriteCities(cities: cities)
      .eraseToAnyPublisher()
  }
}
