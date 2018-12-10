// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Failable",
    products: [
        .library(name: "Failable", targets: ["Failable"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Failable", dependencies: []),
        .testTarget(name: "FailableTests", dependencies: ["Failable"]),
    ]
)
