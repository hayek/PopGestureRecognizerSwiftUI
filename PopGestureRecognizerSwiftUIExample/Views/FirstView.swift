//
//  FirstView.swift
//  PopGestureRecognizerSwiftUIExample
//
//  Created by amir on 16/05/2025.
//

import SwiftUI
import PopGestureRecognizerSwiftUI

struct FirstView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                NavigationLink(destination: SecondView()) {
                    Text("Go to Second View")
                }
                Spacer()
                SwipeBackStatusCard()
            }
            .navigationTitle("🟢 FirstView")
        }
    }
}

struct SwipeBackStatusCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Swipe Back Indicator Guide")
                .font(.title3)
                .fontWeight(.bold)
            Divider()
                Text("🔴  Swipe back disabled")
                    .font(.headline)
                Text("🟢  Swipe back enabled")
                    .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.quaternarySystemFill))
                .stroke(Color(.tertiarySystemFill))
        )
        .padding()
    }
}



#Preview {
    FirstView()
}
