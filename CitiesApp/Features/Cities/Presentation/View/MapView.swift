//
//  MapView.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 14/11/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
  @Binding var city: City?
  @State var position: MapCameraPosition =
    MapCameraPosition.region(
      MKCoordinateRegion(
        center: CLLocationCoordinate2D(
          latitude: .zero,
          longitude: .zero
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.5,
          longitudeDelta: 0.5
        )
      )
    )
  
  var body: some View {
    Map(position: $position) {
      if let city: City = city {
        Marker(city.displayableName, coordinate: coordinates)
      }
    }
    .onChange(of: city) { _, newValue in
      position = getNewPosition()
    }
    .onAppear {
      position = getNewPosition()
    }
  }
  
  var coordinates: CLLocationCoordinate2D {
    CLLocationCoordinate2D(
      latitude: city?.coordinates.latitude ?? .zero,
      longitude: city?.coordinates.longitude ?? .zero
    )
  }
  
  private func getNewPosition() -> MapCameraPosition {
    MapCameraPosition.region(
      MKCoordinateRegion(
        center: coordinates,
        span: MKCoordinateSpan(
          latitudeDelta: 0.5,
          longitudeDelta: 0.5
        )
      )
    )
  }
}

#if DEBUG
#Preview {
  MapView(city: .constant(City(
    country: "RU",
    name: "Russian Federation",
    id: 2017370,
    coordinates: Coordinates(
      longitude: 11.5,
      latitude: 60.0
    )
  )))
}
#endif
