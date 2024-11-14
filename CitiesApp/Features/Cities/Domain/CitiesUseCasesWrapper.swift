//
//  CitiesUseCasesWrapper.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation

protocol CitiesUseCasesWrapperProtocol {
  var getCitiesUseCase: GetCitiesUseCaseProtocol { get }
  var getFavouriteCitiesUseCase: GetFavouriteCitiesUseCaseProtocol { get }
  var saveFavouriteCitiesUseCase: SaveFavouriteCitiesUseCaseProtocol { get }
}

final class CitiesUseCasesWrapper: CitiesUseCasesWrapperProtocol {
  let getCitiesUseCase: GetCitiesUseCaseProtocol
  let getFavouriteCitiesUseCase: GetFavouriteCitiesUseCaseProtocol
  let saveFavouriteCitiesUseCase: SaveFavouriteCitiesUseCaseProtocol
  
  init(
    getCitiesUseCase: GetCitiesUseCaseProtocol,
    getFavouriteCitiesUseCase: GetFavouriteCitiesUseCaseProtocol,
    saveFavouriteCitiesUseCase: SaveFavouriteCitiesUseCaseProtocol
  ) {
    self.getCitiesUseCase = getCitiesUseCase
    self.getFavouriteCitiesUseCase = getFavouriteCitiesUseCase
    self.saveFavouriteCitiesUseCase = saveFavouriteCitiesUseCase
  }
}
