# SwipeBackControl for SwiftUI

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2016.0+-lightgrey.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![SPM Compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swift.org/package-manager)

A lightweight SwiftUI library that brings UIKit's interactive pop gesture control to SwiftUI navigation. Easily disable the swipe-back gesture on specific views in your navigation stack.

![image](Image.png)

## 🎯 Problem

SwiftUI's `NavigationStack` and `NavigationView` don't provide a native way to disable the interactive pop gesture (swipe-back) on specific views. This can be problematic when you have:

- Forms with unsaved changes
- Multi-step processes that shouldn't be interrupted
- Custom navigation flows
- Views that need to prevent accidental back navigation

## ✨ Solution

PopGestureRecognizerSwiftUI bridges the gap by accessing the underlying `UINavigationController` and controlling its `interactivePopGestureRecognizer` property through a simple SwiftUI view modifier.

## 📱 Features

- **Simple API**: Just add `.swipeBackGestureDisabled()` to any view
- **Consecutive Support**: Works with multiple consecutive disabled views
- **Smart State Management**: Automatically re-enables gesture when navigating back to enabled views
- **iOS 16+ Compatible**: Built for modern SwiftUI apps
- **Lightweight**: Minimal overhead and dependencies

## 🚀 Installation

### Swift Package Manager

Add PopGestureRecognizerSwiftUI to your project through Xcode:

1. Go to **File → Add Package Dependencies**
2. Enter the repository URL:
   ```
   https://github.com/hayek/PopGestureRecognizerSwiftUI
   ```
3. Select the version and add to your target

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/hayek/PopGestureRecognizerSwiftUI", from: "1.0.0")
]
```

## 📖 Usage

### Basic Usage

Import the library and add the modifier to any view where you want to disable the swipe-back gesture:

```swift
import SwiftUI
import PopGestureRecognizerSwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Go to Protected View", destination: ProtectedView())
            }
            .navigationTitle("Home")
        }
    }
}

struct ProtectedView: View {
    var body: some View {
        Text("Swipe back is disabled on this view!")
            .navigationTitle("Protected")
            .swipeBackGestureDisabled() // 🎯 This disables swipe back
    }
}
```

## 🔍 How It Works

The library works by:

1. **Finding the UINavigationController**: Uses `UIKitNavigationWrapper` to locate the underlying navigation controller
2. **State Tracking**: Maintains navigation state for each view controller using `NavigationStateStore`
3. **Gesture Control**: Disables/enables `interactivePopGestureRecognizer` based on view lifecycle
4. **Smart Cleanup**: Automatically cleans up state when views are deallocated

## 📋 Requirements

- iOS 16.0+
- Swift 6.0+
- Xcode 16.0+

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the need to bring UIKit's navigation control to SwiftUI
- Thanks to the SwiftUI community for identifying this common pain point

## 📞 Support

If you have any questions or need help integrating this library, please:

- Open an issue on GitHub
- Check existing issues for similar problems
- Provide detailed information about your use case

---

**Made with ❤️ for the SwiftUI community**
