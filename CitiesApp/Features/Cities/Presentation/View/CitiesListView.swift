//
//  CitiesListView.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import SwiftUI

struct CitiesListView<ViewModel: CitiesListViewModelProtocol>: View {
  @StateObject var viewModel: ViewModel
  @State private var orientation = UIDeviceOrientation.unknown
  @State private var city: City?
  @State private var columnVisibility =
  NavigationSplitViewVisibility.automatic
  
  var body: some View {
    if orientation.isLandscape  {
      HStack {
        cityListView
        MapView(city: $city)
      }
    } else {
      cityListView
    }
  }
  
  var cityListView: some View {
    NavigationStack {
      if viewModel.isLoading {
        ProgressView()
          .tint(.accentColor)
      } else {
        if viewModel.searchResult.isEmpty {
          VStack {
            Image(systemName: "magnifyingglass")
              .resizable()
              .scaledToFill()
              .frame(width: 100, height: 100)
            Text("No search results!")
              .font(.title)
          }
        } else {
          Toggle("Favourites", isOn: $viewModel.favouriteToogle)
            .padding(.horizontal, 20)
            .onChange(of: viewModel.favouriteToogle) {
              viewModel.didTapFavouriteSwitch()
            }
          if orientation.isLandscape  {
            landscapeListView
          } else {
            portraitListView
          }
        }
      }
    }
    .searchable(text: $viewModel.searchInput, prompt: "filter")
    .onAppear {
      viewModel.loadData()
    }
    .onRotate { newOrientation in
      orientation = newOrientation
    }
  }
  
  var portraitListView: some View {
    List(viewModel.searchResult, id: \.id) { city in
      NavigationLink(value: city) {
        CitiesListRowView(
          city: city,
          isFavourite: viewModel.isFavourite(city: city),
          action: viewModel.favouriteButtonTapped
        )
      }
    }
    .navigationDestination(for: City.self) { city in
      MapView(city: .constant(city))
    }
  }
  
  var landscapeListView: some View {
    List(viewModel.searchResult, id: \.id, selection: $city) { city in
      NavigationLink(value: city) {
        CitiesListRowView(
          city: city,
          isFavourite: viewModel.isFavourite(city: city),
          action: viewModel.favouriteButtonTapped
        )
      }
    }
  }
}

#if DEBUG
#Preview {
  CitiesWireframe.getView()
}
#endif
