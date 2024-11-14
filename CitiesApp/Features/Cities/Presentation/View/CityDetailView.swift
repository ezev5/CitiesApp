//
//  CityDetailView.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 12/11/2024.
//

import SwiftUI

struct CityDetailView: View {
  @Binding var isSheetPresented: Bool
  var city: City
  
  var body: some View {
    VStack {
      Text(city.displayableName)
        .font(.title)
      Text("longitude: \(city.coordinates.longitude.removeZerosFromEnd())")
        .font(.subheadline)
      Text("latitude: \(city.coordinates.latitude.removeZerosFromEnd())")
        .font(.subheadline)
      Button("Close") {
        isSheetPresented = false
      }
    }
  }
}

#if DEBUG
#Preview {
  CityDetailView(
    isSheetPresented: .constant(true),
    city: City(
    country: "RU",
    name: "Russian Federation",
    id: 2017370,
    coordinates: Coordinates(
      longitude: 11.5,
      latitude: 60.0
    )
  ))
}
#endif
