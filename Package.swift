// swift-tools-version:6.2

import PackageDescription

extension String {
    static let htmlRenderable: Self = "HTML Renderable"
    static let htmlAttributesRendering: Self = "HTML Attributes Rendering"
    static let htmlElementsRendering: Self = "HTML Elements Rendering"
    static let htmlRendering: Self = "HTML Rendering"
    static let htmlRenderableTestSupport: Self = "HTML Renderable TestSupport"
}

extension Target.Dependency {
    static var htmlRenderable: Self { .target(name: .htmlRenderable) }
    static var htmlAttributesRendering: Self { .target(name: .htmlAttributesRendering) }
    static var htmlElementsRendering: Self { .target(name: .htmlElementsRendering) }
    static var htmlRenderableTestSupport: Self { .target(name: .htmlRenderableTestSupport) }
}

extension Target.Dependency {
    static var renderable: Self {
        .product(name: "Renderable", package: "swift-renderable")
    }
    static var renderableTestSupport: Self {
        .product(name: "Renderable TestSupport", package: "swift-renderable")
    }
    static var inlineSnapshotTesting: Self {
        .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing")
    }
    static var incits4_1986: Self {
        .product(name: "INCITS 4 1986", package: "swift-incits-4-1986")
    }
    static var iso9899: Self {
        .product(name: "ISO 9899", package: "swift-iso-9899")
    }
    static var standards: Self {
        .product(name: "Standards", package: "swift-standards")
    }
    static var asyncAlgorithms: Self {
        .product(name: "AsyncAlgorithms", package: "swift-async-algorithms")
    }
    static var htmlStandard: Self {
        .product(name: "HTML Standard", package: "swift-html-standard")
    }
    static var htmlStandardAttributes: Self {
        .product(name: "HTML Standard Attributes", package: "swift-html-standard")
    }
    static var htmlStandardElements: Self {
        .product(name: "HTML Standard Elements", package: "swift-html-standard")
    }
}

let package = Package(
    name: "swift-html-rendering",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v11),
        .macCatalyst(.v18),
    ],
    products: [
        .library(name: .htmlRenderable, targets: [.htmlRenderable]),
        .library(name: .htmlAttributesRendering, targets: [.htmlAttributesRendering]),
        .library(name: .htmlElementsRendering, targets: [.htmlElementsRendering]),
        .library(name: .htmlRendering, targets: [.htmlRendering]),
        .library(name: .htmlRenderableTestSupport, targets: [.htmlRenderableTestSupport]),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-renderable.git", from: "3.0.0"),
        .package(url: "https://github.com/apple/swift-async-algorithms.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.2"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.18.3"),
        .package(url: "https://github.com/swift-standards/swift-incits-4-1986", from: "0.4.0"),
        .package(url: "https://github.com/swift-standards/swift-standards", from: "0.8.0"),
        .package(url: "https://github.com/swift-standards/swift-iso-9899", from: "0.1.0"),
        .package(url: "https://github.com/swift-standards/swift-html-standard", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: .htmlRenderable,
            dependencies: [
                .renderable,
                .asyncAlgorithms,
                .product(name: "OrderedCollections", package: "swift-collections"),
                .incits4_1986,
                .standards,
                .iso9899
            ]
        ),
        .target(
            name: .htmlAttributesRendering,
            dependencies: [
                .htmlStandard,
                .htmlRenderable,
                .htmlStandardAttributes,
            ]
        ),
        .target(
            name: .htmlElementsRendering,
            dependencies: [
                .htmlStandard,
                .htmlAttributesRendering,
                .htmlStandardElements,
            ]
        ),
        .target(
            name: .htmlRendering,
            dependencies: [
                .htmlStandard,
                .htmlAttributesRendering,
                .htmlElementsRendering,
            ]
        ),
        .target(
            name: .htmlRenderableTestSupport,
            dependencies: [
                .htmlRenderable,
                .renderableTestSupport,
                .inlineSnapshotTesting,
            ]
        ),
        .testTarget(
            name: .htmlRenderable.tests,
            dependencies: [
                .htmlRenderable,
                .htmlRenderableTestSupport
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
}

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings = existing + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportsByDefault")
    ]
}
