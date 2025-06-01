//
//  ThirdView.swift
//  PopGestureRecognizerSwiftUIExample
//
//  Created by amir on 16/05/2025.
//

import SwiftUI
import PopGestureRecognizerSwiftUI

struct ForthView: View {
    var body: some View {
        NavigationLink(destination: FifthView()) {
            Text("Go to Fifth View")
        }
        .navigationTitle("🟢 ForthView")
    }
}

#Preview {
    ForthView()
}
