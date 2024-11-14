//
//  MockUseCaseWrapper.swift
//  CitiesAppTests
//
//  Created by Ezequiel Nicolas Velez on 13/11/2024.
//

import Combine
import Foundation
@testable import CitiesApp

final class MockUseCaseWrapper: CitiesUseCasesWrapperProtocol {
  var getCitiesUseCase: GetCitiesUseCaseProtocol = MockGetCitiesUseCase()
  var getFavouriteCitiesUseCase: GetFavouriteCitiesUseCaseProtocol = MockGetFavouriteCitiesUseCase()
  var saveFavouriteCitiesUseCase: SaveFavouriteCitiesUseCaseProtocol = MockSaveFavouriteCitiesUseCase()
}

final class MockGetCitiesUseCase: GetCitiesUseCaseProtocol {
  let constants = Constants()
  func execute() -> AnyPublisher<[City], Error> {
    return Just(constants.citiList)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}

final class MockGetFavouriteCitiesUseCase: GetFavouriteCitiesUseCaseProtocol {
  let constants = Constants()
  func execute() -> AnyPublisher<Set<Int>, Error> {
    return Just(constants.favourites)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}

final class MockSaveFavouriteCitiesUseCase: SaveFavouriteCitiesUseCaseProtocol {
  func execute(cities: Set<Int>) -> AnyPublisher<Bool, Error> {
    return Just(true)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}

struct Constants {
  var citiList: [City] = [
    City(
      country: "AR",
      name: "Buenos Aires",
      id: 0001,
      coordinates: Coordinates(longitude: -58.377232, latitude: -34.613152)
    ),
    City(
      country: "US",
      name: "Alabama",
      id: 0002,
      coordinates: Coordinates(longitude: 2.3486, latitude: 48.853401)
    ),
    City(
      country: "US",
      name: "Albuquerque",
      id: 0003,
      coordinates: Coordinates(longitude: 13.41053, latitude: 52.524368)
    ),
    City(
      country: "US",
      name: "Anaheim",
      id: 0004,
      coordinates: Coordinates(longitude: -75.005966, latitude: 40.714272)
    ),
    City(
      country: "Us",
      name: "Arizona",
      id: 0005,
      coordinates: Coordinates(longitude: 12.4839, latitude: 41.894741)
    ),
    City(
      country: "US",
      name: "Sydney",
      id: 0006,
      coordinates: Coordinates(longitude: 78.127502, latitude: 17.469721)
    )
  ]
  
  var favourites: Set<Int> = Set([0010, 0001, 0005])
}
