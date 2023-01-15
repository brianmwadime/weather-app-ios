//
//  MapView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/6/23.
//

import SwiftUI
import MapKit

struct MapView: View {
  @ObservedObject var viewModel: FavoritesViewModel
  @EnvironmentObject var locationService: LocationService

  private(set) var span = MKCoordinateSpan(
    latitudeDelta: 0.5,
    longitudeDelta: 0.5)

  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(
      latitude: 1.2921,
      longitude: 36.8219),
    span: MKCoordinateSpan(
      latitudeDelta: 0.5,
      longitudeDelta: 0.5))

  var body: some View {
    Map(coordinateRegion: $region, annotationItems: viewModel.getAnnotations()) { place in
      MapMarker(coordinate: place.coordinate, tint: Color.red)
    }
      .onAppear {

        if let coord = locationService.lastLocation?.coordinate {
          self.region = MKCoordinateRegion(center: coord, span: span)
        }

        viewModel.fetch()
      }
      .ignoresSafeArea(.all)
  }
}
