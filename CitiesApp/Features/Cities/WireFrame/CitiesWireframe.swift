//
//  CitiesWireframe.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation
import SwiftUI

final class CitiesWireframe {
  static func getView() -> some View {
    
    let remoteDataManager: CityRemoteDataManagerProtocol = CityRemoteDataManager()
    
    let localDataManager: CityLocalDataManagerProtocol = CityLocalDataManager()
    
    let repository: CityRepositoryProtocol = CityRepository(
      remoteDataManager: remoteDataManager,
      localDataManager: localDataManager
    )
    
    let getCitiesUseCase: GetCitiesUseCaseProtocol = GetCitiesUseCase(repository: repository)
    
    let getFavouriteCitiesUseCase: GetFavouriteCitiesUseCaseProtocol = GetFavouriteCitiesUseCase(repository: repository)
    
    let saveFavouriteCitiesUseCase: SaveFavouriteCitiesUseCaseProtocol = SaveFavouriteCitiesUseCase(repository: repository)
    
    let useCaseWrapper: CitiesUseCasesWrapperProtocol = CitiesUseCasesWrapper(
      getCitiesUseCase: getCitiesUseCase,
      getFavouriteCitiesUseCase: getFavouriteCitiesUseCase,
      saveFavouriteCitiesUseCase: saveFavouriteCitiesUseCase
    )
    
    return CitiesListView(
      viewModel: CitiesListViewModel(
        useCaseWrapper: useCaseWrapper
      )
    )
  }
}
