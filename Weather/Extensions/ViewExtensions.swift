//
//  ViewExtensions.swift
//  Weather
//
//  Created by Brian Mwakima on 1/5/23.
//

import SwiftUI

#if canImport(UIKit)
extension View {

  // Makes it easier to dismiss the keyboard from virtually anywhere in the app.

  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif
