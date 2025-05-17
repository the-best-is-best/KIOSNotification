// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "KIOSNotification",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14),

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
            path: "Sources/KIOSNotification",
//            swiftSettings: [
//               .interoperabilityMode(.Cxx),  // For better Obj-C interop
//               .unsafeFlags([
//                   "-emit-objc-header",
//                   "-emit-objc-header-path",
//                   "./Headers/KIOSNotification-Swift.h"
//               ])
//            ],

        ),
    ]
)
