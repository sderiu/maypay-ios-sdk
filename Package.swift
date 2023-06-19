// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Maypay",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Maypay",
            targets: ["Maypay", "MaypaySwiftUI", "MaypayUIKit"]
        ),
        .library(
            name: "MaypaySwiftUI",
            targets: ["MaypaySwiftUI"]
        ),
        .library(
            name: "MaypayUIKit",
            targets: ["MaypayUIKit"]
        )
    ],
    targets: [
        .target(
            name: "Maypay",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .target(
            name: "MaypaySwiftUI",
            dependencies: ["Maypay"]
        ),
        .target(
            name: "MaypayUIKit",
            dependencies: ["Maypay"]
        ),
        .testTarget(
            name: "MaypayTests",
            dependencies: ["Maypay", "MaypaySwiftUI", "MaypayUIKit"]
        )
    ]
)
