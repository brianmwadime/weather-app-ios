//
//  ContentView.swift
//  Weather
//
//  Created by Brian Mwakima on 12/29/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var currentViewModel: CurrentViewModel
    @StateObject var forcastViewModel: ForecastViewModel
//    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
          ZStack {
            if let current = currentViewModel.current {
              Color(current.getWeatherCondition())
                .ignoresSafeArea(.all)
              ScrollView {
                VStack {
                  CurrentView(current: current)
                  Spacer()
                  if let forcast = forcastViewModel.forecast {
                    ForecastListView(forecast: forcast, backgroundColor: current.getWeatherCondition())
                      .background(Color(current.getWeatherCondition()))
                    Spacer()
                  } else {
                    ProgressView()
                  }

                }
                .edgesIgnoringSafeArea(.all)
              }
              .edgesIgnoringSafeArea(.top)
            } else {
              ProgressView()
            }
          }
          .onAppear {
            currentViewModel.fetchCurrent(for: Current.Coordinates(lat: 1.2921, lon: 36.8219))
            forcastViewModel.fetchForecast(for: Current.Coordinates(lat: 1.2921, lon: 36.8219))
          }
        }

    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//      ContentView(viewModel: CurrentViewModel(weatherService: MockSe))
//    }
//}
#endif
