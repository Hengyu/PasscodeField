// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PasscodeField",
    platforms: [
        .iOS(.v13),
        .tvOS(.v14),
        .macCatalyst(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(name: "PasscodeField", targets: ["PasscodeField"])
    ],
    targets: [
        .target(name: "PasscodeField", dependencies: []),
        .testTarget(name: "PasscodeFieldTests", dependencies: ["PasscodeField"])
    ]
)
