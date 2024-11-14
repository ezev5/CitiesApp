//
//  GetCitiesUseCase.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation
import Combine

protocol GetCitiesUseCaseProtocol {
  func execute() -> AnyPublisher<[City], Error>
}

final class GetCitiesUseCase: GetCitiesUseCaseProtocol {
  private let repository: CityRepositoryProtocol
  
  init(repository: CityRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() -> AnyPublisher<[City], Error> {
    return repository.getCitiesRequest()
      .map({$0.sorted {$0.displayableName < $1.displayableName}})
      .eraseToAnyPublisher()
  }
}
