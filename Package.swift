// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PopGestureRecognizerSwiftUI",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "PopGestureRecognizerSwiftUI",
            targets: ["PopGestureRecognizerSwiftUI"]),
    ],
    targets: [
        .target(
            name: "PopGestureRecognizerSwiftUI"),
        .testTarget(
            name: "PopGestureRecognizerSwiftUITests",
            dependencies: ["PopGestureRecognizerSwiftUI"]
        ),
    ]
)
