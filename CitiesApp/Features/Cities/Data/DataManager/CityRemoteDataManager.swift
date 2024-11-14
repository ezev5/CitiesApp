//
//  CityRemoteDataManager.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation
import Combine

protocol CityRemoteDataManagerProtocol {
  func fetchCities() -> AnyPublisher<[City], Error>
}

final class CityRemoteDataManager: CityRemoteDataManagerProtocol {
  func fetchCities() -> AnyPublisher<[City], Error> {
    guard let url: URL = URL(string: Endpoint.citiesURL) else {
      return Fail(error: CitiesAppError.badURL).eraseToAnyPublisher()
    }
    let request: URLRequest = URLRequest(url: url)
    return NetworkingManager.download(request: request)
      .decode(type: [City].self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
