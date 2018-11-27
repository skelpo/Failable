// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Validation",
    products: [
        .library(name: "Validation", targets: ["Validation"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Validation", dependencies: []),
        .testTarget(name: "ValidationTests", dependencies: ["Validation"]),
    ]
)