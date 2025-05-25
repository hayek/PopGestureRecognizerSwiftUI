//
//  SecondView.swift
//  PopGestureRecognizerSwiftUIExample
//
//  Created by amir on 16/05/2025.
//

import SwiftUI
import PopGestureRecognizerSwiftUI

struct SecondView: View {
    var body: some View {
        NavigationLink(destination: ThirdView()) {
            Text("Go to Third View")
        }
        .navigationTitle("🔴 SecondView")
        .swipeBackGestureDisabled()
    }
}

#Preview {
    SecondView()
}
