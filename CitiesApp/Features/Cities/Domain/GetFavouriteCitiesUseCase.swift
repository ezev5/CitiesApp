//
//  GetFavouriteCitiesUseCase.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation
import Combine

protocol GetFavouriteCitiesUseCaseProtocol {
  func execute() -> AnyPublisher<Set<Int>, Error>
}

final class GetFavouriteCitiesUseCase: GetFavouriteCitiesUseCaseProtocol {
  private let repository: CityRepositoryProtocol
  
  init(repository: CityRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() -> AnyPublisher<Set<Int>, Error> {
    return repository.getFavouriteCities()
      .eraseToAnyPublisher()
  }
}
