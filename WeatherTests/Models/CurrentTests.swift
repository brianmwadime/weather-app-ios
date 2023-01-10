//
//  CurrentTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 12/30/22.
//

import XCTest
import Foundation
@testable import Weather
import CoreData

class CurrentTests: XCTestCase {

  private lazy var current: Current = {
    return try! mapCurrent(from: "current") // swiftlint:disable:this force_try
  }()

  func test_current_has_coords() {
    XCTAssertNotNil(current.coord)
  }

  func test_current_has_dayOfTheWeek() {
    XCTAssertNotNil(current.dayOfTheWeek)
  }

  func test_current_has_condition() {
    XCTAssertNotNil(current.condition)
  }

  func test_currentCoord_has_lat_lon() throws {

    let coord = try XCTUnwrap(current.coord)

    XCTAssertNotNil(coord.lat)
    XCTAssertNotNil(coord.lon)
  }

  func test_currentCoord_has_double_lat_lon() throws {
    let coord = try XCTUnwrap(current.coord)

    XCTAssertEqual(coord.lat, 44.34)
    XCTAssertEqual(coord.lon, 10.99)

  }

  func test_current_has_weather_array() {
    XCTAssert((current.weather as Any) is [Current.Weather])
  }

  func test_currentWeatherArray_has_weather_items() {

    for weather in current.weather {
      XCTAssertNotNil(weather.id)
      XCTAssertNotNil(weather.main)
      XCTAssertNotNil(weather.description)
      XCTAssertNotNil(weather.icon)
    }
  }

  func test_current_has_main() {
    XCTAssertNotNil(current.main)
  }

  func test_currentMain_has_props() {
    XCTAssertNotNil(current.main.temp)
    XCTAssertNotNil(current.main.feels_like)
    XCTAssertNotNil(current.main.temp_min)
    XCTAssertNotNil(current.main.temp_max)
    XCTAssertNotNil(current.main.pressure)
    XCTAssertNotNil(current.main.humidity)
    XCTAssertNotNil(current.main.sea_level)
    XCTAssertNotNil(current.main.grnd_level)
  }

  func test_current_has_wind() {
    XCTAssertNotNil(current.wind)
  }

  func test_currentWind_has_props() {
    XCTAssertNotNil(current.wind.speed)
    XCTAssertNotNil(current.wind.deg)
    XCTAssertNotNil(current.wind.gust)
  }

  func test_current_has_rain() {
    XCTAssertNotNil(current.rain)
  }

  func test_currentRain_has_props() throws {
    let rain = try XCTUnwrap(current.rain)
    XCTAssertNotNil(rain.last1h)
    XCTAssertNil(rain.last3h)
  }

  func test_current_has_clouds() {
    XCTAssertNotNil(current.clouds)
  }

  func test_currentClouds_has_props() {
    XCTAssertNotNil(current.clouds.all)
  }

  func test_current_has_date_n_timezone() {
    XCTAssertNotNil(current.date)
    XCTAssertNotNil(current.timezone)
  }

  func test_current_return_FavoriteCurrent() {
    let context = getCoreDataContext()

    let dataObject = current.toNSManagedObject(in: context)

    XCTAssertNotNil(dataObject)
    XCTAssert((dataObject as Any) is CurrentWeather)
  }
}

extension Current: NSManagedObjectConvertible {
//  typealias ObjectType = CurrentWeather

  func toNSManagedObject(in context: NSManagedObjectContext) -> CurrentWeather? {
//    let entityDescription = CurrentWeather.entity()
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "Current", in: context) else {
      NSLog("Can't create entity Current")
      return nil
    }

    let object = CurrentWeather(entity: entityDescription, insertInto: context)

    if let timezone = timezone {
      object.timezone = timezone
    }

    guard let weatherDescription = NSEntityDescription.entity(forEntityName: "Weather", in: context) else {
      NSLog("Can't create entity Weather")
      return nil
    }

    for weather in self.weather {

      let weatherEntity = WeatherCurrent(entity: weatherDescription, insertInto: context)
      weatherEntity.main = weather.main
      weatherEntity.icon = weather.icon
      weatherEntity.main_description = weather.description
      weatherEntity.current = object
      object.addToWeather(weatherEntity)
    }

    object.dt = dt

    return object
  }
}

protocol NSManagedObjectConvertible {

  associatedtype ObjectType

  func toNSManagedObject(in context: NSManagedObjectContext) -> ObjectType?
}

private extension CurrentTests {

  func getCoreDataContext() -> NSManagedObjectContext {
    var sut: CoreDataRepository!
    sut = CoreDataRepository()
    sut.persistentContainer = {
      let container = NSPersistentContainer(name: "Weather")

      // create a persistent store description that informs the persistent container that it should write data to /dev/null
      // while using the default SQLite storage mechanism Writing to /dev/null effectively uses an in-memory store,
      // except you get all the features that you also get from the SQLite store that your app uses
      let description = NSPersistentStoreDescription()
      description.url = URL(fileURLWithPath: "/dev/null")
      container.persistentStoreDescriptions = [description]

      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Failed to load stores: \(error), \(error.userInfo)")
        }
      })
      return container
    }()

    return sut.context
  }

  func mapCurrent(from filename: String) throws -> Current {
    let response = Loader.contentsOf(filename)!

    let decoder = JSONDecoder()

    return try decoder.decode(Current.self, from: response)
  }

}
