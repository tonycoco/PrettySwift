//
//  ContentView.swift
//  PrettySwift for Xcode
//
//  Created by Tony Coconate on 8/9/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading) {
        Text("Installation")
          .font(.headline)
          .padding(.bottom)

        Text(
          "In System Settings, enable the \"PrettySwift\" Xcode Source Extension."
        )
        .font(.body)
      }
      .frame(width: 200)
      .padding(.leading)

      Image("Screenshot")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
