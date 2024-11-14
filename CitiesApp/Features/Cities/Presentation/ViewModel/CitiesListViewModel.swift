//
//  CitiesListViewModel.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation
import Combine
import SwiftUI

protocol CitiesListViewModelProtocol: ObservableObject {
  var searchResult: [City] { get }
  var searchInput: String { get set }
  var favouriteToogle: Bool { get set }
  var isLoading: Bool { get }
  func loadData()
  func didTapFavouriteSwitch()
  func isFavourite(city: City) -> Bool
  func favouriteButtonTapped(_ city: City, _ favourite: Bool)
}

final class CitiesListViewModel: CitiesListViewModelProtocol {
  @Published var searchResult: [City] = []
  @Published var searchInput: String = ""
  @Published var favouriteToogle: Bool = false
  @Published var isLoading: Bool = true
  private var cities: [City] = []
  private var favouriteCities: Set<Int> = Set<Int>()
  private var useCaseWrapper: CitiesUseCasesWrapperProtocol
  private var cancellables: Set<AnyCancellable> = []
  
  init(useCaseWrapper: CitiesUseCasesWrapperProtocol) {
    self.useCaseWrapper = useCaseWrapper
    addSubscribers()
  }
  
  func loadData() {
    let getCityPublisher: AnyPublisher<[City], Error> = useCaseWrapper.getCitiesUseCase.execute()
    let getFavouriteCitiesPublisher: AnyPublisher<Set<Int>, Error> = useCaseWrapper.getFavouriteCitiesUseCase.execute()
    
    Publishers.Zip(getCityPublisher, getFavouriteCitiesPublisher)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            //TODO: handle errors
            print(error)
          case .finished:
            print("dowloaded")
          }
        },
        receiveValue: { [weak self] cities, favouriteCities in
          self?.cities = cities
          self?.searchResult = cities
          self?.favouriteCities = favouriteCities
          self?.isLoading = false
        }
      ).store(in: &cancellables)
  }
  
  func didTapFavouriteSwitch() {
    withAnimation {
      if favouriteToogle {
        searchResult = filterByFavourites(entries: searchResult)
      } else {
        filterCities(by: searchInput)
      }
    }
  }
  
  func isFavourite(city: City) -> Bool {
    return favouriteCities.contains(city.id)
  }

  func favouriteButtonTapped(_ city: City, _ favourite: Bool) {
    if favourite {
      favouriteCities.insert(city.id)
    } else {
      favouriteCities.remove(city.id)
    }
    useCaseWrapper.saveFavouriteCitiesUseCase.execute(cities: favouriteCities)
  }
  
  private func filterByFavourites(entries: [City]) -> [City] {
    return entries.filter({ favouriteCities.contains($0.id) })
  }
  
  private func addSubscribers() {
    $searchInput
      .removeDuplicates()
      .sink { [weak self] text in
        self?.filterCities(by: text.lowercased())
      }.store(in: &self.cancellables)
  }
  
  private func filterCities(by text: String) {
    guard !text.isEmpty else {
      if favouriteToogle {
        searchResult = filterByFavourites(entries: cities)
      } else {
        searchResult = cities
      }
      return
    }
    var cities: [City] = cities
    if favouriteToogle {
      cities = filterByFavourites(entries: cities)
    }
    searchResult = cities.filter({ $0.displayableName.lowercased().hasPrefix(text)})
  }
}
