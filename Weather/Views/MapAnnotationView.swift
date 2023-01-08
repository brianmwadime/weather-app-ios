//
//  MapAnnotationView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/7/23.
//

import SwiftUI

struct MapAnnotationView: View {

  var label: String

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        Circle()
        Text("50°")
          .font(.system(size: 26, weight: .semibold))
          .foregroundColor(.white)
          .padding(5)
      }

      Image(systemName: "triangle.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 10, height: 10)
        .rotationEffect(Angle(degrees: 180))
        .background(.white)
        .padding(.bottom, 40)
    }
  }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
      MapAnnotationView(label: "50C")
    }
}
