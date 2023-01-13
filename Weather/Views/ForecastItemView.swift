//
//  ForecastItemView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import SwiftUI

struct ForecastItemView: View {
  var forcastItem: Current
    var body: some View {
        HStack {
          Text(forcastItem.dayOfTheWeek)
            .font(.system(size: 18))
          .foregroundColor(.white)
          .frame(maxWidth: .infinity, alignment: .leading)

          Image.iconFor(condition: forcastItem.condition)?
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.white)
            .frame(width: 32, height: 32, alignment: .center)

          Text("\(forcastItem.main.temp.roundDouble())°")
          .foregroundColor(.white)
          .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding([.leading, .trailing])
    }
}
