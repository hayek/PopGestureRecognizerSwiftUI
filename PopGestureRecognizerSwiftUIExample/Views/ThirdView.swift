//
//  ThirdView.swift
//  PopGestureRecognizerSwiftUIExample
//
//  Created by amir on 16/05/2025.
//

import SwiftUI
import PopGestureRecognizerSwiftUI

struct ThirdView: View {
    var body: some View {
        NavigationLink(destination: ForthView()) {
            Text("Go to Forth View")
        }
        .navigationTitle("🔴 ThirdView")
        .swipeBackGestureDisabled()
    }
}

#Preview {
    ThirdView()
}
