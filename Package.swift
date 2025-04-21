// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "RectangleConfigToAlfredScripFilterConverter",
    dependencies: [
        .package(url: "https://github.com/shpakovski/MASShortcut.git", revision: "6ddfd5f866f8f9679b5af656604dd33cc2540a48"),
    ],
    targets: [
        .executableTarget(
            name: "RectangleConfigToAlfredScripFilterConverter",
            dependencies: ["MASShortcut"],
            path: "Sources"
        ),
    ]
)
