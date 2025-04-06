// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "KIOSNotification",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14) // Ensure this is correct if you're targeting macOS

    ],
    products: [
        .library(
            name: "KIOSNotification",
            targets: ["KIOSNotification"]
        ),
    ],
    targets: [
        // Define the target that holds your source files
        .target(
            name: "KIOSNotification",
            path: "Sources/KIOSNotification"  // Specify the correct path to your sources
        ),
    ]
)
