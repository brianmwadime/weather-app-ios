//
//  LocationsViewModelTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/4/23.
//

import XCTest
import Combine
@testable import Weather
import MapKit

final class LocationsViewModelTests: XCTestCase {

  var sut: LocationsViewModel?
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

  override func setUpWithError() throws {
    sut = LocationsViewModel()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_LocationsViewModel_locations_should_be_empty() {

    let expectation = XCTestExpectation(description: "Should be empty")

    sut?.$locations.sink { currentValue in
      XCTAssertEqual(currentValue.count, 0)
      expectation.fulfill()
    }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_LocationsViewModel_isSearching_should_be_false() {

    let expectation = XCTestExpectation(description: "Should be false")

    sut?.$isSearching.sink { currentValue in
      XCTAssertEqual(currentValue, false)
      expectation.fulfill()
    }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_LocationsViewModel_searchFor_should_be_called() {

    let searchTerm = "Nairobi"

    sut?.search(for: searchTerm)

    XCTAssertEqual(sut?.completer.queryFragment, searchTerm)
  }

  func test_LocationsViewModel_clearResults_should_remove_locations() {
    let searchTerm = "Nairobi"
    let expectation = XCTestExpectation(description: "Should be empty")

    sut?.search(for: searchTerm)

    sut?.$locations.sink { currentValue in
      XCTAssertEqual(currentValue.count, 0)
      expectation.fulfill()
    }.store(in: &cancellables)

    sut?.$isSearching.sink { currentValue in
      XCTAssertEqual(currentValue, false)
      expectation.fulfill()
    }.store(in: &cancellables)

    sut?.clearResults()

    wait(for: [expectation], timeout: 1)
  }
}

/// Location searching viewmodel
///
class LocationsViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
  /// Locations returned from search
  ///
  @Published var locations = [String]()

  /// Status of search
  ///
  @Published var isSearching = false

  /// `MKLocalSearchCompleter` instance
  private(set) var completer: MKLocalSearchCompleter = MKLocalSearchCompleter()

  /// Search for term passed.
  ///
  /// Initialises the `completer` for searching
  /// - Parameters:
  ///  - term: Search term
  ///  - region: `MKCoordinateRegion` to search in
  ///
  func search(for term: String, in region: MKCoordinateRegion? = nil) {
    completer.delegate = self
    completer.region = MKCoordinateRegion(.world)
    completer.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
    completer.queryFragment = term
  }

  /// Returns the MKMapItem for the selection from the first search
  /// - Parameters:
  ///  - term: Search term
  ///  - onComplete: Closure with `MKMapItem` returned
  ///
  func mapItem(for term: String, onComplete: @escaping (MKMapItem) -> Void) {
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = term
    let search = MKLocalSearch(request: searchRequest)

    search.start { response, error in
      if let response = response, let one = response.mapItems.first {
        DispatchQueue.main.async {
          onComplete(one)
        }
      }
      if let error = error {
        print("Error: \(error)")
      }
    }
  }

  /// Clears `locations` and sets `isSearching` to false
  ///
  func clearResults() {
    locations.removeAll()
    isSearching = false
  }

  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    let results = completer.results.filter { result in
      guard result.title.contains(",") || !result.subtitle.isEmpty else { return false }
      guard !result.subtitle.contains("Nearby") else { return false }
      return true
    }
    self.locations = results.map { $0.title + ($0.subtitle.isEmpty ? "" : ", " + $0.subtitle) }
    self.isSearching = true
  }

  func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    print("Completer failed with some error: \(error)")
    isSearching = false
  }
}
