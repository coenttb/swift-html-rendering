// swift-tools-version: 6.2

import PackageDescription

extension String {
    static let htmlRenderable: Self = "HTML Renderable"
    static let htmlAttributesRendering: Self = "HTML Attributes Rendering"
    static let htmlElementsRendering: Self = "HTML Elements Rendering"
    static let htmlRendering: Self = "HTML Rendering"
    static let htmlRenderableTestSupport: Self = "HTML Rendering TestSupport"
}

extension Target.Dependency {
    static var htmlRenderable: Self { .target(name: .htmlRenderable) }
    static var htmlAttributesRendering: Self { .target(name: .htmlAttributesRendering) }
    static var htmlElementsRendering: Self { .target(name: .htmlElementsRendering) }
    static var htmlRenderableTestSupport: Self { .target(name: .htmlRenderableTestSupport) }
}

extension Target.Dependency {
    static var renderable: Self {
        .product(name: "Rendering", package: "swift-renderable")
    }
    static var asyncRenderable: Self {
        .product(name: "RenderingAsync", package: "swift-renderable")
    }
    static var renderableTestSupport: Self {
        .product(name: "Rendering TestSupport", package: "swift-renderable")
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
    static var w3cCSSShared: Self {
        .product(name: "W3C CSS Shared", package: "swift-w3c-css")
    }
}

let package = Package(
    name: "swift-html-rendering",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .macCatalyst(.v26),
    ],
    products: [
        .library(name: .htmlRenderable, targets: [.htmlRenderable]),
        .library(name: .htmlAttributesRendering, targets: [.htmlAttributesRendering]),
        .library(name: .htmlElementsRendering, targets: [.htmlElementsRendering]),
        .library(name: .htmlRendering, targets: [.htmlRendering]),
        .library(name: .htmlRenderableTestSupport, targets: [.htmlRenderableTestSupport]),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-renderable", from: "3.2.0"),
        .package(url: "https://github.com/apple/swift-async-algorithms.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.2"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.18.3"),
        .package(url: "https://github.com/swift-standards/swift-incits-4-1986", from: "0.4.0"),
        .package(url: "https://github.com/swift-standards/swift-standards", from: "0.16.1"),
        .package(url: "https://github.com/swift-standards/swift-iso-9899", from: "0.1.0"),
        .package(url: "https://github.com/swift-standards/swift-html-standard", from: "0.1.6"),
        .package(url: "https://github.com/swift-standards/swift-w3c-css", from: "0.2.1"),
    ],
    targets: [
        .target(
            name: .htmlRenderable,
            dependencies: [
                .renderable,
                .asyncRenderable,
                .asyncAlgorithms,
                .product(name: "OrderedCollections", package: "swift-collections"),
                .incits4_1986,
                .standards,
                .iso9899,
                .w3cCSSShared,
                .htmlStandard,
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
