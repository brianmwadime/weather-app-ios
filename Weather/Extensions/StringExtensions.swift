//
//  StringExtensions.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import Foundation

extension String {

  /// Localization helper function
  ///
  /// Put the key into the Localizable.strings file - per
  /// language - and then use the key in the source code. For example:
  ///     let title = "hey_there".localized()
  /// In the Localized.strings file:
  ///     "hey_there" = "Hello World";

  /// - Note: many SwiftUI components will take the key as their argument so you do not
  /// always need to use this function.

  func localized() -> String {
    NSLocalizedString(self, comment: self)
  }
}
