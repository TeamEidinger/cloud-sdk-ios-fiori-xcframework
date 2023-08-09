// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FioriSwiftUI",
    defaultLocalization: "en",
    platforms: [.iOS(.v15), .watchOS(.v7)],
    products: [
        .library(
            name: "FioriSwiftUI",
            type: .dynamic,
            targets: ["FioriSwiftUI"]
        ),
        .library(
            name: "FioriCharts",
            type: .dynamic,
            targets: ["FioriCharts"]
        ),
        .library(
            name: "FioriThemeManager",
            type: .dynamic,
            targets: ["FioriThemeManagerSources"]
        ),
        .library(
            name: "FioriThemeManagerBinary",
            targets: ["FioriThemeManager"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .target(
            name: "FioriSwiftUI",
            dependencies: [.target(name: "FioriSwiftUICore", condition: .when(platforms: [.iOS]))]
        ),
        .target(
            name: "FioriCharts",
            dependencies: ["FioriThemeManagerSources"],
            exclude: ["TestCases/SF_EnergyBenchmarking.csv"]
        ),
        .target(
            name: "FioriSwiftUICore",
            dependencies: [
                .target(name: "FioriThemeManagerSources", condition: .when(platforms: [.iOS])),
                .target(name: "FioriCharts", condition: .when(platforms: [.iOS]))
            ],
            resources: [.process("FioriSwiftUICore.strings")]
        ),
        .binaryTarget(name: "FioriThemeManager",
                      url: "https://github.com/TeamEidinger/cloud-sdk-ios-fiori-xcframework/releases/download/999.0.0/FioriThemeManager.xcframework.zip",
                      checksum: "a7d11d53b3615ee6ef133e4af80a22ee2a5daf319fdc620a573e64b51ecbd74d"
        ),
        .target(
            name: "FioriThemeManagerSources",
            dependencies: [],
            path: "Sources/FioriThemeManager",
            resources: [
                .process("72-Fonts/Resources"),
                .process("FioriIcons/Resources/FioriIcon.xcassets")
            ]
        ),
        .testTarget(
            name: "FioriThemeManagerTests",
            dependencies: ["FioriThemeManagerSources"],
            path: "Tests/FioriSwiftUITests/FioriThemeManager",
            resources: [
                .process("TestResources")
            ]
        ),
        .testTarget(
            name: "FioriChartsTests",
            dependencies: ["FioriCharts"],
            path: "Tests/FioriSwiftUITests/FioriCharts"
        ),
        .testTarget(
            name: "FioriSwiftUICoreTests",
            dependencies: ["FioriSwiftUICore"],
            path: "Tests/FioriSwiftUITests/FioriSwiftUICore"
        )
    ]
)
