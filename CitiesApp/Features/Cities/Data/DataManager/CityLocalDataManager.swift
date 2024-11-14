//
//  CityLocalDataManager.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation
import Combine

protocol CityLocalDataManagerProtocol {
  func getFavouriteCities() -> AnyPublisher<Set<Int>, Error>
  func saveFavouriteCities(items: Set<Int>) -> AnyPublisher<Bool, Error>
}

final class CityLocalDataManager: CityLocalDataManagerProtocol {
  private let FAV_KEY = "favourite_cities"
  func getFavouriteCities() -> AnyPublisher<Set<Int>, Error> {
    let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [Int] ?? [Int]()
    return Just(Set(array))
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
  
  func saveFavouriteCities(items: Set<Int>) -> AnyPublisher<Bool, Error> {
    let array = Array(items)
    UserDefaults.standard.setValue(array, forKey: FAV_KEY)
    return Just(true)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}
