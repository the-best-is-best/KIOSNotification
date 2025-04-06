// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "KIOSNotification",
    platforms: [
        .iOS(.v12),
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
