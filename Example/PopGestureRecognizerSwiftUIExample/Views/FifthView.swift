//
//  ThirdView.swift
//  PopGestureRecognizerSwiftUIExample
//
//  Created by amir on 16/05/2025.
//

import SwiftUI
import PopGestureRecognizerSwiftUI

struct FifthView: View {
    var body: some View {
        NavigationLink(destination: FifthView()) {
            Text("Go to FifthView View")
        }
        .navigationTitle("🔴  FifthViewView")
        .swipeBackGestureDisabled()
    }
}

#Preview {
    FifthView()
}
