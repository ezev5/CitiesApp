//
//  CityRepository.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation
import Combine

protocol CityRepositoryProtocol {
  func getCitiesRequest() -> AnyPublisher<[City], Error>
  func getFavouriteCities() -> AnyPublisher<Set<Int>, Error>
  func saveFavouriteCities(cities: Set<Int>) -> AnyPublisher<Bool, Error>
}

final class CityRepository: CityRepositoryProtocol {
  private let remoteDataManager: CityRemoteDataManagerProtocol
  private let localDataManager: CityLocalDataManagerProtocol
  
  init(
    remoteDataManager: CityRemoteDataManagerProtocol,
    localDataManager: CityLocalDataManagerProtocol
  ) {
    self.remoteDataManager = remoteDataManager
    self.localDataManager = localDataManager
  }
  
  func getCitiesRequest() -> AnyPublisher<[City], Error> {
    return remoteDataManager.fetchCities()
      .eraseToAnyPublisher()
  }
  
  func getFavouriteCities() -> AnyPublisher<Set<Int>, Error> {
    return localDataManager.getFavouriteCities()
      .eraseToAnyPublisher()
  }
  
  func saveFavouriteCities(cities: Set<Int>) -> AnyPublisher<Bool, Error> {
    return localDataManager.saveFavouriteCities(items: cities)
      .eraseToAnyPublisher()
  }
}
