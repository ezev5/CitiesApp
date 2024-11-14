//
//  CitiesListRowView.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import SwiftUI

struct CitiesListRowView: View {
  var city: City
  @State var isFavourite: Bool
  @State private var presentDetailView: Bool = false
  var action: (City, Bool) -> Void
  
    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(city.displayableName)
            .font(.headline)
          Text("lon: \(city.coordinates.longitude.removeZerosFromEnd()) lat: \(city.coordinates.latitude.removeZerosFromEnd())")
            .font(.subheadline)
        }
        Spacer()
        Image(systemName: "info.circle")
          .font(.title)
          .padding(10)
          .foregroundStyle(Color.gray)
          .onTapGesture {
            presentDetailView.toggle()
          }
        Image(systemName: isFavourite ? "heart.fill" : "heart")
          .font(.title)
          .padding(10)
          .foregroundStyle(Color.red)
          .onTapGesture {
            isFavourite.toggle()
            action(city, isFavourite)
          }
      }.sheet(isPresented: $presentDetailView, content: {
        CityDetailView(isSheetPresented: $presentDetailView, city: city)
      })
    }
}

#if DEBUG
#Preview {
  CitiesListRowView(
    city: City(
      country: "RU",
      name: "Russian Federation",
      id: 2017370,
      coordinates: Coordinates(
        longitude: 11.5,
        latitude: 60.0
      )
    ), 
    isFavourite: false,
    action: { item, value in
      print("\(item.displayableName) - \(value)")
    }
  )
}
#endif
