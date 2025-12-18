// ====================
// Package.swift
// ====================
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


// ====================
// Sources/HTML Attributes Rendering/Abbr.swift
// ====================
//
//  ColSpan.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the colspan attribute on an element
    @discardableResult
    package func abbr(
        _ value: Abbr?
    ) -> HTML._Attributes<Self> {
        self.attribute(Abbr.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Accept.swift
// ====================
///
/// Accept.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Add an accept attribute to specify which file types are allowed
    @discardableResult
    package func accept(
        _ value: Accept?
    ) -> HTML._Attributes<Self> {
        self.attribute(Accept.attribute, value?.description)
    }

    /// Add an accept attribute with multiple file types
    @discardableResult
    package func accept(
        _ fileTypes: Accept.FileType?...
    ) -> HTML._Attributes<Self> {
        self.accept(Accept(fileTypes.compactMap { $0 }))
    }

    /// Add an accept attribute with multiple file types
    @discardableResult
    package func accept(
        _ fileTypes: [Accept.FileType?]
    ) -> HTML._Attributes<Self> {
        self.accept(Accept(fileTypes.compactMap { $0 }))
    }
}


// ====================
// Sources/HTML Attributes Rendering/AcceptCharset.swift
// ====================
//
//  AcceptCharset.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the accept-charset attribute on an element
    @discardableResult
    package func acceptCharset(
        _ value: AcceptCharset?
    ) -> HTML._Attributes<Self> {
        self.attribute(AcceptCharset.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Action.swift
// ====================
///
/// Action.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Add an action attribute to specify the URL for form submission
    @discardableResult
    public func action(
        _ value: Action?
    ) -> HTML._Attributes<Self> {
        self.attribute(Action.attribute, value?.description)
    }
}

// extension HTML.View {
//    /// Add an action attribute with a URL object
//    @discardableResult
//    public func action(
//        _ url: URL
//    ) -> HTML._Attributes<Self> {
//        self.action(.init(url))
//    }
// }


// ====================
// Sources/HTML Attributes Rendering/Allow.swift
// ====================
//
//  File.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 11/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the allow attribute on an element
    @discardableResult
    package func allow(
        _ value: Allow?
    ) -> HTML._Attributes<Self> {
        self.attribute("allow", value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Allowfullscreen.swift
// ====================
//
//  Allowfullscreen.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the allowfullscreen attribute on an element
    @discardableResult
    package func allowfullscreen(
        _ value: Allowfullscreen?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Alt.swift
// ====================
///
/// Alt.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the alt attribute on an element
    @discardableResult
    package func alt(
        _ value: Alt?
    ) -> HTML._Attributes<Self> {
        self.attribute(Alt.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/As.swift
// ====================
//
//  As.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the as attribute on an element
    @discardableResult
    package func `as`(
        _ value: As?
    ) -> HTML._Attributes<Self> {
        self.attribute(As.attribute, value?.rawValue)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Async.swift
// ====================
//
//  Async.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the async attribute on an element
    @discardableResult
    package func async(
        _ value: Async?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/AttributionSrc.swift
// ====================
//
//  AttributionSrc.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the attributionsrc attribute on an element
    @discardableResult
    package func attributionSrc(
        _ value: AttributionSrc?
    ) -> HTML._Attributes<Self> {
        self.attribute(AttributionSrc.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Autocomplete.swift
// ====================
///
/// Autocomplete.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func autocomplete(
        _ value: Autocomplete?
    ) -> HTML._Attributes<Self> {
        self.attribute(Autocomplete.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Autoplay.swift
// ====================
//
//  Autoplay.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the autoplay attribute on an element
    @discardableResult
    package func autoplay(
        _ value: Autoplay?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Behavior.swift
// ====================
//
//  Behavior.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the behavior attribute on an element
    @discardableResult
    package func behavior(
        _ value: Behavior?
    ) -> HTML._Attributes<Self> {
        self.attribute(Behavior.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Blocking.swift
// ====================
//
//  Blocking.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the blocking attribute on an element
    @discardableResult
    package func blocking(
        _ value: Blocking?
    ) -> HTML._Attributes<Self> {
        self.attribute(Blocking.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ButtonType.swift
// ====================
//
//  ButtonType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the type attribute on a button element
    @discardableResult
    package func type(
        _ value: ButtonType?
    ) -> HTML._Attributes<Self> {
        self.attribute(ButtonType.attribute, value?.rawValue)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Capture.swift
// ====================
///
/// Capture.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func capture(
        _ value: Capture?
    ) -> HTML._Attributes<Self> {
        self.attribute(Capture.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/CharSet.swift
// ====================
//
//  CharSet.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the charset attribute on an element
    @discardableResult
    package func charset(
        _ value: CharSet?
    ) -> HTML._Attributes<Self> {
        self.attribute("charset", value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Checked.swift
// ====================
///
/// Checked.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Adds the checked attribute to the element
    package var checked: HTML._Attributes<Self> {
        self.attribute(Checked.attribute)
    }

    /// Conditionally adds the checked attribute to the element
    @HTML.Builder
    package func checked(_ value: Checked?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Cite.swift
// ====================
//
//  Cite.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the cite attribute on an element
    @discardableResult
    package func cite(
        _ value: HTML_Standard_Attributes.Cite?
    ) -> HTML._Attributes<Self> {
        self.attribute(Cite.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ColSpan.swift
// ====================
//
//  ColSpan.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the colspan attribute on an element
    @discardableResult
    package func colspan(
        _ value: ColSpan?
    ) -> HTML._Attributes<Self> {
        self.attribute(ColSpan.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Color.swift
// ====================
//
//  Color.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the color attribute on an element
    @discardableResult
    package func color(
        _ value: Color?
    ) -> HTML._Attributes<Self> {
        self.attribute(Color.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Cols.swift
// ====================
//
//  Cols.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the cols attribute on an element
    @discardableResult
    package func cols(
        _ value: Cols?
    ) -> HTML._Attributes<Self> {
        self.attribute(Cols.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Compact.swift
// ====================
//
//  Compact.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the compact attribute on an element
    @discardableResult
    package func compact(
        _ value: Compact?
    ) -> HTML._Attributes<Self> {
        self.attribute(Compact.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Content.swift
// ====================
//
//  Content.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the content attribute on an element
    @discardableResult
    package func content(
        _ value: HTML_Standard_Attributes.Content?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML_Standard_Attributes.Content.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Controls.swift
// ====================
//
//  Controls.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the controls attribute on an element
    @discardableResult
    package func controls(
        _ value: Controls?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ControlsList.swift
// ====================
//
//  ControlsList.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the controlslist attribute on an element
    @discardableResult
    package func controlsList(
        _ value: ControlsList?
    ) -> HTML._Attributes<Self> {
        self.attribute(ControlsList.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Crossorigin.swift
// ====================
///
/// Crossorigin.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func crossorigin(
        _ value: Crossorigin?
    ) -> HTML._Attributes<Self> {
        self.attribute(Crossorigin.attribute, value?.description)
    }

    //    @discardableResult
    //    package func crossorigin(
    //        _ policy: CrosPolicy
    //    ) -> HTML._Attributes<Self> {
    //        self.crossorigin(Crossorigin(policy))
    //    }
}


// ====================
// Sources/HTML Attributes Rendering/DateTime.swift
// ====================
//
//  DateTime.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the datetime attribute on an element
    @discardableResult
    package func dateTime(
        _ value: DateTime?
    ) -> HTML._Attributes<Self> {
        self.attribute(DateTime.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Default.swift
// ====================
//
//  Default.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the default attribute on an element
    @discardableResult
    package func `default`(
        _ value: Default?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Defer.swift
// ====================
//
//  Defer.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the defer attribute on an element
    @discardableResult
    package func `defer`(
        _ value: Defer?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Direction.swift
// ====================
//
//  Direction.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the direction attribute on an element
    @discardableResult
    package func direction(
        _ value: WHATWG_HTML_GlobalAttributes.Direction?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG_HTML_GlobalAttributes.Direction.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Dirname.swift
// ====================
///
/// Dirname.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    package func dirname(
        _ value: Dirname?
    ) -> HTML._Attributes<Self> {
        self.attribute(Dirname.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/DisablePictureInPicture.swift
// ====================
//
//  DisablePictureInPicture.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the disablepictureinpicture attribute on an element
    @discardableResult
    package func disablePictureInPicture(
        _ value: DisablePictureInPicture?
    ) -> HTML._Attributes<Self> {
        self.attribute(DisablePictureInPicture.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/DisableRemotePlayback.swift
// ====================
//
//  DisableRemotePlayback.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the disableremoteplayback attribute on an element
    @discardableResult
    package func disableRemotePlayback(
        _ value: DisableRemotePlayback?
    ) -> HTML._Attributes<Self> {
        self.attribute(DisableRemotePlayback.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Disabled.swift
// ====================
///
/// Disabled.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Adds the disabled attribute to the element
    package var disabled: HTML._Attributes<Self> {
        self.attribute(Disabled.attribute)
    }

    /// Conditionally adds the disabled attribute to the element
    @HTML.Builder
    package func disabled(_ value: Disabled?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Download.swift
// ====================
//
//  File.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the disableremoteplayback attribute on an element
    @discardableResult
    package func download(
        _ value: Download?
    ) -> HTML._Attributes<Self> {
        self.attribute(Download.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Elementtiming.swift
// ====================
///
/// Elementtiming.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func elementtiming(
        _ value: Elementtiming?
    ) -> HTML._Attributes<Self> {
        self.attribute(Elementtiming.attribute, value?.description)
    }

    /// Adds element timing with a categorized identifier
    @discardableResult
    package func elementtiming(
        category: Elementtiming.Category,
        name: String,
        separator: String = "-"
    ) -> HTML._Attributes<Self> {
        self.elementtiming(Elementtiming(category: category, name: name, separator: separator))
    }
}


// ====================
// Sources/HTML Attributes Rendering/EncType.swift
// ====================
///
/// EncType.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Add an EncType attribute to specify the form data encoding type
    @discardableResult
    package func EncType(
        _ value: EncType?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG_HTML_FormAttributes.EncType.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Face.swift
// ====================
//
//  Face.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the face attribute on an element
    @discardableResult
    package func face(
        _ value: Face?
    ) -> HTML._Attributes<Self> {
        self.attribute(Face.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/FetchPriority.swift
// ====================
//
//  Fetchpriority.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the fetchpriority attribute on an element
    @discardableResult
    package func fetchPriority(
        _ value: FetchPriority?
    ) -> HTML._Attributes<Self> {
        self.attribute(FetchPriority.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/File.swift
// ====================
//
//  File.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 11/04/2025.
//


// ====================
// Sources/HTML Attributes Rendering/FontSize.swift
// ====================
//
//  FontSize.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the size attribute on a font element
    @discardableResult
    package func size(
        _ value: FontSize?
    ) -> HTML._Attributes<Self> {
        self.attribute(FontSize.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/For.swift
// ====================
///
/// For.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the for attribute on an element
    @discardableResult
    package func `for`(
        _ value: For?
    ) -> HTML._Attributes<Self> {
        self.attribute(For.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Form.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes


// ====================
// Sources/HTML Attributes Rendering/FormAction.swift
// ====================
//
//  FormAction.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the formaction attribute on an element
    @discardableResult
    package func formAction(
        _ value: FormAction?
    ) -> HTML._Attributes<Self> {
        self.attribute(FormAction.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/FormEncType.swift
// ====================
//
//  formenctype.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the formenctype attribute on an element
    @discardableResult
    package func formEncType(
        _ value: FormEncType?
    ) -> HTML._Attributes<Self> {
        self.attribute(FormEncType.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/FormMethod.swift
// ====================
//
//  FormMethod.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the formmethod attribute on an element
    @discardableResult
    package func formMethod(
        _ value: FormMethod?
    ) -> HTML._Attributes<Self> {
        self.attribute(FormMethod.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/FormNovalidate.swift
// ====================
//
//  FormNovalidate.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the formnovalidate attribute on an element
    @discardableResult
    package func formNovalidate(
        _ value: FormNovalidate?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/FormTarget.swift
// ====================
//
//  FormTarget.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the formtarget attribute on an element
    @discardableResult
    package func formTarget(
        _ value: FormTarget?
    ) -> HTML._Attributes<Self> {
        self.attribute(FormTarget.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/FrameBorder.swift
// ====================
///
/// FrameBorder.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func frameBorder(
        _ value: FrameBorder?
    ) -> HTML._Attributes<Self> {
        self.attribute(FrameBorder.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Autocapitalize.swift
// ====================
///
/// Autocapitalize.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func autocapitalize(
        _ value: Autocapitalize?
    ) -> HTML._Attributes<Self> {
        self.attribute(Autocapitalize.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Autocorrect.swift
// ====================
///
/// Autocorrect.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func autocorrect(
        _ value: Autocorrect?
    ) -> HTML._Attributes<Self> {
        self.attribute(Autocorrect.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Autofocus.swift
// ====================
///
/// Autofocus.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    public var autofocus: HTML._Attributes<Self> {
        self.attribute(Autofocus.attribute)
    }
}

extension HTML.View {
    @discardableResult
    public func autofocus(
        _ value: Autofocus?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Class.swift
// ====================
///
/// Class.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func `class`(
        _ value: Class?
    ) -> HTML._Attributes<Self> {
        self.attribute(Class.attribute, value?.description)
    }
}

// extension HTML.View {
//    @discardableResult
//    public func `class`(
//        _ value: [Class?]
//    ) -> HTML._Attributes<Self> {
//        self.attribute(Class.attribute, Class(value.compactMap{ $0 }.map(\.description)).description)
//    }
//
//    @discardableResult
//    public func `class`(
//        _ value: Class?...
//    ) -> HTML._Attributes<Self> {
//        self.attribute(Class.attribute, Class(value.compactMap{ $0 }.map(\.description)).description)
//    }
// }


// ====================
// Sources/HTML Attributes Rendering/Global/Contenteditable.swift
// ====================
///
/// Contenteditable.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func contenteditable(
        _ value: Contenteditable
    ) -> HTML._Attributes<Self> {
        self.attribute(Contenteditable.attribute, value.description)
    }

    public var contenteditable: HTML._Attributes<Self> {
        self.contenteditable(.true)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/DataAttribute.swift
// ====================
///
/// DataAttribute.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    @discardableResult
    public func data(
        _ name: some CustomStringConvertible,
        _ value: some CustomStringConvertible
    ) -> HTML._Attributes<Self> {
        let attribute = DataAttribute(name: name, value: value)
        return self.attribute(attribute.attributeName, attribute.description)
    }

    @discardableResult
    public func data(
        _ value: DataAttribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(value?.attributeName ?? "", value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Dir.swift
// ====================
///
/// Dir.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the text direction for an HTML element
    @discardableResult
    public func dir(
        _ value: Dir
    ) -> HTML._Attributes<Self> {
        self.attribute(Dir.attribute, value.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Draggable.swift
// ====================
///
/// Draggable.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets whether an element is draggable
    @discardableResult
    public func draggable(
        _ value: Draggable
    ) -> HTML._Attributes<Self> {
        self.attribute(Draggable.attribute, value.description)
    }

    /// Shorthand to set draggable="true"
    public var draggable: HTML._Attributes<Self> {
        self.draggable(.true)
    }
}
//


// ====================
// Sources/HTML Attributes Rendering/Global/Enterkeyhint.swift
// ====================
///
/// Enterkeyhint.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the Enter key label/action hint for virtual keyboards
    @discardableResult
    public func enterkeyhint(
        _ value: Enterkeyhint
    ) -> HTML._Attributes<Self> {
        self.attribute(Enterkeyhint.attribute, value.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Exportparts.swift
// ====================
///
/// Exportparts.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the exportparts attribute with part names to export
    @discardableResult
    public func exportparts(
        _ parts: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(Exportparts.attribute, parts.joined(separator: ", "))
    }

    /// Sets the exportparts attribute with part names to export as variadic parameters
    @discardableResult
    public func exportparts(
        _ parts: String...
    ) -> HTML._Attributes<Self> {
        self.exportparts(parts)
    }

    /// Sets the exportparts attribute with explicit part mappings
    @discardableResult
    public func exportparts(
        _ mappings: [Exportparts.PartMapping]
    ) -> HTML._Attributes<Self> {
        let value = mappings.map { mapping in
            if mapping.originalName == mapping.exposedName {
                return mapping.originalName
            } else {
                return "\(mapping.originalName):\(mapping.exposedName)"
            }
        }.joined(separator: ", ")

        return self.attribute(Exportparts.attribute, value)
    }

    /// Sets the exportparts attribute using an Exportparts struct
    @discardableResult
    public func exportparts(
        _ attribute: Exportparts
    ) -> HTML._Attributes<Self> {
        self.attribute(Exportparts.attribute, attribute.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Hidden.swift
// ====================
///
/// Hidden.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the hidden attribute with a specific value
    @discardableResult
    public func hidden(
        _ hidden: Hidden
    ) -> HTML._Attributes<Self> {
        self.attribute(Hidden.attribute)
    }

    /// Sets the hidden attribute without a value (equivalent to hidden="")
    @discardableResult
    public func hidden() -> HTML._Attributes<Self> {
        self.attribute(Hidden.attribute)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Id.swift
// ====================
///
/// Id.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the ID attribute for an HTML element
    @discardableResult
    public func id(
        _ id: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Id.attribute, id)
    }

    /// Sets the ID attribute using an Id struct
    @discardableResult
    public func id(
        _ id: Id?
    ) -> HTML._Attributes<Self> {
        self.attribute(Id.attribute, id?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Inert.swift
// ====================
///
/// Inert.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the inert attribute, making the element and all its descendants non-interactive
    public var inert: HTML._Attributes<Self> {
        self.attribute(Inert.attribute)
    }

    /// Conditionally adds the disabled attribute to the element
    @HTML.Builder
    package func inert(_ value: Inert?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Inputmode.swift
// ====================
///
/// Inputmode.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the inputmode attribute to hint at what type of virtual keyboard to display
    @discardableResult
    public func inputmode(
        _ mode: Inputmode?
    ) -> HTML._Attributes<Self> {
        self.attribute(Inputmode.attribute, mode?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Is.swift
// ====================
///
/// Is.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the is attribute to extend a standard HTML element with custom behavior
    @discardableResult
    public func `is`(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Is.attribute, Is(value).description)
    }

    /// Sets the is attribute using an Is struct
    @discardableResult
    public func `is`(
        _ value: Is
    ) -> HTML._Attributes<Self> {
        self.attribute(Is.attribute, value.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Itemid.swift
// ====================
///
/// Itemid.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the itemid attribute with a global identifier
    @discardableResult
    public func itemid(
        _ identifier: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemid.attribute, Itemid(identifier).description)
    }

    /// Sets the itemid attribute using an Itemid struct
    @discardableResult
    public func itemid(
        _ value: Itemid
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemid.attribute, value.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Itemprop.swift
// ====================
///
/// Itemprop.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the itemprop attribute with a property name
    @discardableResult
    public func itemprop(
        _ propertyName: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemprop.attribute, propertyName)
    }

    /// Sets the itemprop attribute with multiple property names
    @discardableResult
    public func itemprop(
        _ propertyNames: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemprop.attribute, propertyNames.joined(separator: " "))
    }

    /// Sets the itemprop attribute with multiple property names as variadic parameters
    @discardableResult
    public func itemprop(
        _ propertyNames: String...
    ) -> HTML._Attributes<Self> {
        self.itemprop(propertyNames)
    }

    /// Sets the itemprop attribute using an Itemprop struct
    @discardableResult
    public func itemprop(
        _ attribute: Itemprop
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemprop.attribute, attribute.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Itemref.swift
// ====================
///
/// Itemref.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the itemref attribute with a single element ID
    @discardableResult
    public func itemref(
        _ id: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemref.attribute, id)
    }

    /// Sets the itemref attribute with multiple element IDs
    @discardableResult
    public func itemref(
        _ ids: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemref.attribute, ids.joined(separator: " "))
    }

    /// Sets the itemref attribute with multiple element IDs as variadic parameters
    @discardableResult
    public func itemref(
        _ ids: String...
    ) -> HTML._Attributes<Self> {
        self.itemref(ids)
    }

    /// Sets the itemref attribute using an Itemref struct
    @discardableResult
    public func itemref(
        _ attribute: Itemref
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemref.attribute, attribute.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Itemscope.swift
// ====================
///
/// Itemscope.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the itemscope attribute, creating a new microdata item
    public var itemscope: HTML._Attributes<Self> {
        self.attribute(Itemscope.attribute)
    }

    /// Sets the itemscope attribute using an Itemscope enum value
    @discardableResult
    public func itemscope(
        _ value: Itemscope?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Itemtype.swift
// ====================
///
/// Itemtype.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the itemtype attribute with a vocabulary URL
    @discardableResult
    public func itemtype(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemtype.attribute, value)
    }

    /// Sets the itemtype attribute with multiple vocabulary URLs
    @discardableResult
    public func itemtype(
        _ values: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemtype.attribute, values.joined(separator: " "))
    }

    /// Sets the itemtype attribute with multiple vocabulary URLs as variadic parameters
    @discardableResult
    public func itemtype(
        _ values: String...
    ) -> HTML._Attributes<Self> {
        self.itemtype(values)
    }

    /// Sets the itemtype attribute using an Itemtype struct
    @discardableResult
    public func itemtype(
        _ attribute: Itemtype
    ) -> HTML._Attributes<Self> {
        self.attribute(Itemtype.attribute, attribute.description)
    }

    /// Sets the itemtype attribute with a schema.org type
    @discardableResult
    public func itemtype(
        schemaOrg type: String
    ) -> HTML._Attributes<Self> {
        self.itemtype(Itemtype(schemaOrg: type))
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Lang.swift
// ====================
///
/// Lang.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the lang attribute with a language tag
    @discardableResult
    public func lang(
        _ language: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Lang.attribute, language)
    }

    /// Sets the lang attribute with separate components
    @discardableResult
    public func lang(
        language: String,
        script: String? = nil,
        region: String? = nil
    ) -> HTML._Attributes<Self> {
        self.lang(Lang(language: language, script: script, region: region))
    }

    /// Sets the lang attribute using a Lang struct
    @discardableResult
    public func lang(
        _ attribute: Lang
    ) -> HTML._Attributes<Self> {
        self.attribute(Lang.attribute, attribute.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Nonce.swift
// ====================
///
/// Nonce.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the nonce attribute using a Nonce struct
    @discardableResult
    public func nonce(
        _ attribute: Nonce?
    ) -> HTML._Attributes<Self> {
        self.attribute(Nonce.attribute, attribute?.description)
    }
}

// extension HTML.View {
//    /// Sets the nonce attribute with a newly generated secure nonce
//    @discardableResult
//    public func nonce() -> HTML._Attributes<Self> {
//        self.nonce(Nonce.generate())
//    }
// }


// ====================
// Sources/HTML Attributes Rendering/Global/Part.swift
// ====================
///
/// Part.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the part attribute with a single part name
    @discardableResult
    public func part(
        _ partName: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Part.attribute, partName)
    }

    /// Sets the part attribute with multiple part names
    @discardableResult
    public func part(
        _ partNames: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(Part.attribute, partNames.joined(separator: " "))
    }

    /// Sets the part attribute with multiple part names as variadic parameters
    @discardableResult
    public func part(
        _ partNames: String...
    ) -> HTML._Attributes<Self> {
        self.part(partNames)
    }

    /// Sets the part attribute using a Part struct
    @discardableResult
    public func part(
        _ attribute: Part
    ) -> HTML._Attributes<Self> {
        self.attribute(Part.attribute, attribute.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Popover.swift
// ====================
///
/// Popover.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the popover attribute as a boolean (equivalent to popover="auto")
    @discardableResult
    public func popover() -> HTML._Attributes<Self> {
        self.attribute(Popover.attribute, "")
    }

    /// Sets the popover attribute with a specific type
    @discardableResult
    public func popover(
        _ type: Popover
    ) -> HTML._Attributes<Self> {
        self.attribute(Popover.attribute, type.description)
    }

    /// Sets the popover attribute with a value
    @discardableResult
    public func popover(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Popover.attribute, value)
    }
}

extension HTML.View {
    /// Sets the popovertarget attribute with the ID of the target popover
    @discardableResult
    public func popovertarget(
        _ id: String
    ) -> HTML._Attributes<Self> {
        self.attribute(PopoverTarget.attribute, id)
    }

    /// Sets the popovertarget attribute using a PopoverTarget struct
    @discardableResult
    public func popovertarget(
        _ attribute: PopoverTarget?
    ) -> HTML._Attributes<Self> {
        self.attribute(PopoverTarget.attribute, attribute?.description)
    }
}

extension HTML.View {
    /// Sets the popovertargetaction attribute with an action
    @discardableResult
    public func popovertargetaction(
        _ action: PopoverTargetAction?
    ) -> HTML._Attributes<Self> {
        self.attribute(PopoverTargetAction.attribute, action?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Slot.swift
// ====================
///
/// Slot.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the slot attribute with a slot name
    @discardableResult
    public func slot(
        _ name: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Slot.attribute, name)
    }

    /// Sets the slot attribute using a Slot struct
    @discardableResult
    public func slot(
        _ attribute: Slot
    ) -> HTML._Attributes<Self> {
        self.attribute(Slot.attribute, attribute.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Spellcheck.swift
// ====================
///
/// Spellcheck.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the spellcheck attribute using a Spellcheck enum value
    @discardableResult
    package func spellcheck(
        _ attribute: Spellcheck?
    ) -> HTML._Attributes<Self> {
        self.attribute(Spellcheck.attribute, attribute?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Style.swift
// ====================
///
/// Style.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the style attribute with CSS declarations as a string
    @discardableResult
    public func style(
        _ css: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Style.attribute, css)
    }

    /// Sets the style attribute with CSS declarations as key-value pairs
    @discardableResult
    public func style(
        _ declarations: [String: String]
    ) -> HTML._Attributes<Self> {
        let formattedDeclarations = declarations.map { key, value in
            "\(key): \(value)"
        }.joined(separator: "; ")

        return self.attribute(Style.attribute, formattedDeclarations)
    }

    /// Sets the style attribute using a Style struct
    @discardableResult
    public func style(
        _ attribute: WHATWG_HTML_GlobalAttributes.Style
    ) -> HTML._Attributes<Self> {
        self.attribute(Style.attribute, attribute.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Tabindex.swift
// ====================
///
/// Tabindex.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the tabindex attribute with an integer value
    @discardableResult
    public func tabindex(
        _ value: Int
    ) -> HTML._Attributes<Self> {
        self.attribute(Tabindex.attribute, String(value))
    }

    /// Sets the tabindex attribute using a Tabindex struct
    @discardableResult
    public func tabindex(
        _ attribute: Tabindex
    ) -> HTML._Attributes<Self> {
        self.attribute(Tabindex.attribute, attribute.description)
    }

    /// Makes the element not focusable via keyboard but focusable programmatically
    @discardableResult
    public func notTabbable() -> HTML._Attributes<Self> {
        self.tabindex(Tabindex.notTabbable)
    }

    /// Makes the element focusable in the natural document order
    @discardableResult
    public func tabbableInDocumentOrder() -> HTML._Attributes<Self> {
        self.tabindex(Tabindex.inDocumentOrder)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Title.swift
// ====================
///
/// Title.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the title attribute with text
    @discardableResult
    public func title(
        _ value: String
    ) -> HTML._Attributes<Self> {
        self.attribute(Title.attribute, value)
    }

    /// Sets the title attribute with multiline text
    @discardableResult
    public func title(
        lines: [String]
    ) -> HTML._Attributes<Self> {
        self.attribute(Title.attribute, lines.joined(separator: "\n"))
    }

    /// Sets the title attribute with multiline text as variadic parameters
    @discardableResult
    public func title(
        lines: String...
    ) -> HTML._Attributes<Self> {
        self.title(lines: lines)
    }

    /// Sets the title attribute using a Title struct
    @discardableResult
    public func title(
        _ attribute: HTML_Standard_Attributes.Title?
    ) -> HTML._Attributes<Self> {
        self.attribute(Title.attribute, attribute?.description)
    }

    /// Sets an empty title to prevent inheriting from ancestors
    @discardableResult
    public func noTitle() -> HTML._Attributes<Self> {
        self.title(Title.empty)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Translate.swift
// ====================
///
/// Translate.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the translate attribute using a Translate enum value
    @discardableResult
    public func translate(
        _ attribute: Translate
    ) -> HTML._Attributes<Self> {
        self.attribute(Translate.attribute, attribute.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Virtualkeyboardpolicy.swift
// ====================
///
/// Virtualkeyboardpolicy.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the virtualkeyboardpolicy attribute with a policy value
    @discardableResult
    public func virtualkeyboardpolicy(
        _ policy: Virtualkeyboardpolicy
    ) -> HTML._Attributes<Self> {
        self.attribute(Virtualkeyboardpolicy.attribute, policy.description)
    }

    /// Sets the virtualkeyboardpolicy attribute to auto
    @discardableResult
    public func autoKeyboard() -> HTML._Attributes<Self> {
        self.virtualkeyboardpolicy(.auto)
    }

    /// Sets the virtualkeyboardpolicy attribute to manual
    @discardableResult
    public func manualKeyboard() -> HTML._Attributes<Self> {
        self.virtualkeyboardpolicy(.manual)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Global/Writingsuggestions.swift
// ====================
///
/// Writingsuggestions.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the writingsuggestions attribute with a boolean value
    @discardableResult
    public func writingsuggestions(
        _ enabled: Bool
    ) -> HTML._Attributes<Self> {
        self.attribute(Writingsuggestions.attribute, enabled ? "true" : "false")
    }

    /// Sets the writingsuggestions attribute using a Writingsuggestions enum value
    @discardableResult
    public func writingsuggestions(
        _ attribute: Writingsuggestions
    ) -> HTML._Attributes<Self> {
        self.attribute(Writingsuggestions.attribute, attribute.description)
    }

    /// Enables browser-provided writing suggestions
    @discardableResult
    public func enableWritingSuggestions() -> HTML._Attributes<Self> {
        self.writingsuggestions(Writingsuggestions.true)
    }

    /// Disables browser-provided writing suggestions
    @discardableResult
    public func disableWritingSuggestions() -> HTML._Attributes<Self> {
        self.writingsuggestions(Writingsuggestions.false)
    }
}


// ====================
// Sources/HTML Attributes Rendering/HTTPEquiv.swift
// ====================
//
//  Headers.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the httpEquiv attribute on an element
    @discardableResult
    package func httpEquiv(
        _ value: HttpEquiv?
    ) -> HTML._Attributes<Self> {
        self.attribute("http-equiv", value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Headers.swift
// ====================
//
//  Headers.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the headers attribute on an element
    @discardableResult
    package func headers(
        _ value: Headers?
    ) -> HTML._Attributes<Self> {
        self.attribute(Headers.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Height.swift
// ====================
///
/// Height.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the height attribute on an element
    @discardableResult
    package func height(
        _ value: Height?
    ) -> HTML._Attributes<Self> {
        self.attribute(Height.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/High.swift
// ====================
//
//  High.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the high attribute on an element
    @discardableResult
    package func high(
        _ value: High?
    ) -> HTML._Attributes<Self> {
        self.attribute(High.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Href.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Add an href attribute to specify a hyperlink destination
    @discardableResult
    public func href(
        _ value: Href?
    ) -> HTML._Attributes<Self> {
        self.attribute(Href.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Hreflang.swift
// ====================
//
//  Hreflang.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the hreflang attribute on an element
    @discardableResult
    package func hreflang(
        _ value: Hreflang?
    ) -> HTML._Attributes<Self> {
        self.attribute(Hreflang.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ImageSrcSet.swift
// ====================
//
//  ImageSrcSet.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the srcset attribute on an image element
    @discardableResult
    package func srcset(
        _ value: ImageSrcSet?
    ) -> HTML._Attributes<Self> {
        self.attribute(ImageSrcSet.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Imagesizes.swift
// ====================
//
//  Imagesizes.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the sizes attribute on an image element
    @discardableResult
    package func sizes(
        _ value: ImageSizes?
    ) -> HTML._Attributes<Self> {
        self.attribute(ImageSizes.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Integrity.swift
// ====================
//
//  Integrity.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the integrity attribute on an element
    @discardableResult
    package func integrity(
        _ value: Integrity?
    ) -> HTML._Attributes<Self> {
        self.attribute(Integrity.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Internal/_HTMLAttributes.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    @HTML.Builder
    package func attribute(
        _ value: String,
        _ condition: @autoclosure () -> Bool?
    ) -> some HTML.View {
        let conditionResult = condition()
        if conditionResult == true {
            self.attribute(value, "")
        } else {
            self.attribute("", String?.none)
        }
    }

    @HTML.Builder
    package func attribute<Attribute: HTML.BooleanAttribute>(
        boolean value: Attribute?
    ) -> some HTML.View {
        self.attribute(Attribute.attribute, value == true)
    }
}

extension HTML._Attributes {
    package func attribute(
        _ name: String,
        _ value: (some CustomStringConvertible)? = ""
    ) -> HTML._Attributes<Content> {
        self.attribute(name, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Internal/exports.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

@_exported public import HTML_Renderable
@_exported public import HTML_Standard_Attributes


// ====================
// Sources/HTML Attributes Rendering/IsMap.swift
// ====================
//
//  IsMap.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the ismap attribute on an element
    @discardableResult
    package func isMap(
        _ value: Ismap?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Kind.swift
// ====================
//
//  Kind.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the kind attribute on an element
    @discardableResult
    package func kind(
        _ value: Kind?
    ) -> HTML._Attributes<Self> {
        self.attribute(Kind.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Label.swift
// ====================
//
//  Label.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the disablepictureinpicture attribute on an element
    @discardableResult
    @_disfavoredOverload
    package func label(
        _ value: HTML_Standard_Attributes.Label?
    ) -> HTML._Attributes<Self> {
        self.attribute(Label.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/LinkType.swift
// ====================
//
//  LinkType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the type attribute on a link element
    @discardableResult
    package func type(
        _ value: LinkType?
    ) -> HTML._Attributes<Self> {
        self.attribute(LinkType.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/List.swift
// ====================
///
/// List.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the list attribute on an element
    @discardableResult
    package func list(
        _ value: List?
    ) -> HTML._Attributes<Self> {
        self.attribute(List.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ListType.swift
// ====================
//
//  ListType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the type attribute on a list element
    @discardableResult
    package func type(
        _ value: ListType?
    ) -> HTML._Attributes<Self> {
        self.attribute(ListType.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Loading.swift
// ====================
//
//  Loading.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the loading attribute on an element
    @discardableResult
    package func loading(
        _ value: Loading?
    ) -> HTML._Attributes<Self> {
        self.attribute(Loading.attribute, value?.rawValue)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Loop.swift
// ====================
//
//  Loop.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the loop attribute on an element
    @discardableResult
    package func loop(
        _ value: Loop?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Low.swift
// ====================
//
//  Low.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the low attribute on an element
    @discardableResult
    package func low(
        _ value: Low?
    ) -> HTML._Attributes<Self> {
        self.attribute(Low.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/MarginHeight.swift
// ====================
///
/// MarginHeight.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func marginHeight(
        _ value: MarginHeight?
    ) -> HTML._Attributes<Self> {
        self.attribute(MarginHeight.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/MarginWidth.swift
// ====================
///
/// MarginWidth.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func marginWidth(
        _ value: MarginWidth?
    ) -> HTML._Attributes<Self> {
        self.attribute(MarginWidth.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Max.swift
// ====================
///
/// Max.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the max attribute on an element
    @discardableResult
    package func max(
        _ value: Max?
    ) -> HTML._Attributes<Self> {
        self.attribute(Max.attribute, value?.description)
    }

    //    /// Sets the max attribute with a date value and format
    //    @discardableResult
    //    package func max(
    //        date: Date,
    //        format: Max.DateFormat = .fullDate
    //    ) -> HTML._Attributes<Self> {
    //        self.max(Max(date: date, format: format))
    //    }
}


// ====================
// Sources/HTML Attributes Rendering/Maxlength.swift
// ====================
///
/// Maxlength.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the maxlength attribute on an element
    @discardableResult
    package func maxlength(
        _ value: Maxlength?
    ) -> HTML._Attributes<Self> {
        self.attribute(Maxlength.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Media.swift
// ====================
//
//  Media.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the media attribute on an element
    @discardableResult
    package func media(
        _ value: Media?
    ) -> HTML._Attributes<Self> {
        self.attribute(Media.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Method.swift
// ====================
///
/// Method.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Add a method attribute to specify the HTTP method for form submission
    @discardableResult
    package func method(
        _ value: Method?
    ) -> HTML._Attributes<Self> {
        self.attribute(Method.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Min.swift
// ====================
///
/// Min.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the min attribute on an element
    @discardableResult
    package func min(
        _ value: Min?
    ) -> HTML._Attributes<Self> {
        self.attribute(Min.attribute, value?.description)
    }
}

// extension HTML.View {
//    /// Sets the min attribute with a date value and format
//    @discardableResult
//    package func min(
//        date: Date,
//        format: Min.DateFormat = .fullDate
//    ) -> HTML._Attributes<Self> {
//        self.min(Min(date: date, format: format))
//    }
// }


// ====================
// Sources/HTML Attributes Rendering/Minlength.swift
// ====================
///
/// Minlength.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the minlength attribute on an element
    @discardableResult
    package func minlength(
        _ value: Minlength?
    ) -> HTML._Attributes<Self> {
        self.attribute(Minlength.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Multiple.swift
// ====================
///
/// Multiple.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Adds the multiple attribute to the element
    package var multiple: HTML._Attributes<Self> {
        self.attribute(Multiple.attribute)
    }

    /// Conditionally adds the multiple attribute to the element
    @HTML.Builder
    package func multiple(_ value: Multiple?) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Muted.swift
// ====================
//
//  Muted.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the muted attribute on an element
    @discardableResult
    package func muted(
        _ value: Muted?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Name.swift
// ====================
///
/// Name.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the name attribute on an element
    @discardableResult
    package func name(
        _ value: Name?
    ) -> HTML._Attributes<Self> {
        self.attribute(Name.attribute, value?.description)
    }
}

extension HTML.View {
    /// Sets the name attribute on an element
    @discardableResult
    package func name(
        _ value: MetaName?
    ) -> HTML._Attributes<Self> {
        self.attribute(MetaName.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/NoResize.swift
// ====================
//
//  NoResize.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the noresize attribute on an element
    @discardableResult
    package func noResize(
        _ value: NoResize?
    ) -> HTML._Attributes<Self> {
        self.attribute(NoResize.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Nomodule.swift
// ====================
//
//  Nomodule.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the nomodule attribute on an element
    @discardableResult
    package func nomodule(
        _ value: Nomodule?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Novalidate.swift
// ====================
///
/// Novalidate.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Add the novalidate attribute to disable browser validation for a form
    package var novalidate: HTML._Attributes<Self> {
        self.attribute(Novalidate.attribute)
    }

    /// Conditionally adds the required attribute to the element
    @HTML.Builder
    package func novalidate(
        _ value: Novalidate?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ObjectData.swift
// ====================
//
//  ObjectData.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the data attribute on an object element
    @discardableResult
    package func data(
        _ value: ObjectData?
    ) -> HTML._Attributes<Self> {
        self.attribute(ObjectData.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ObjectForm.swift
// ====================
//
//  ObjectForm.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the form attribute on an object element
    @discardableResult
    package func form(
        _ value: HTML_Standard_Attributes.Form.ID?
    ) -> HTML._Attributes<Self> {
        self.attribute("form", value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ObjectType.swift
// ====================
//
//  ObjectType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the type attribute on an object element
    @discardableResult
    package func type(
        _ value: ObjectType?
    ) -> HTML._Attributes<Self> {
        self.attribute(ObjectType.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Open.swift
// ====================
//
//  Open.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the open attribute on an element
    @discardableResult
    package func open(
        _ value: Open?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Optimum.swift
// ====================
//
//  Optimum.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the optimum attribute on an element
    @discardableResult
    package func optimum(
        _ value: Optimum?
    ) -> HTML._Attributes<Self> {
        self.attribute(Optimum.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Pattern.swift
// ====================
///
/// Pattern.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the pattern attribute on an element
    @discardableResult
    package func pattern(
        _ value: Pattern?
    ) -> HTML._Attributes<Self> {
        self.attribute(Pattern.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Ping.swift
// ====================
//
//  Ping.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the ping attribute on an element
    @discardableResult
    package func ping(
        _ value: Ping?
    ) -> HTML._Attributes<Self> {
        self.attribute(Ping.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Placeholder.swift
// ====================
///
/// Placeholder.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the placeholder attribute on an element
    @discardableResult
    package func placeholder(
        _ value: Placeholder?
    ) -> HTML._Attributes<Self> {
        self.attribute(Placeholder.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Playsinline.swift
// ====================
//
//  Playsinline.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the playsinline attribute on an element
    @discardableResult
    package func playsinline(
        _ value: Playsinline?
    ) -> HTML._Attributes<Self> {
        self.attribute(Playsinline.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/PopoverTarget.swift
// ====================
//
//  PopoverTarget.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the popovertarget attribute on an element
    @discardableResult
    package func popoverTarget(
        _ value: PopoverTarget?
    ) -> HTML._Attributes<Self> {
        self.attribute(PopoverTarget.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/PopoverTargetAction.swift
// ====================
//
//  PopoverTargetAction.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the popovertargetaction attribute on an element
    @discardableResult
    package func popoverTargetAction(
        _ value: PopoverTargetAction?
    ) -> HTML._Attributes<Self> {
        self.attribute(PopoverTargetAction.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Poster.swift
// ====================
//
//  Poster.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the poster attribute on an element
    @discardableResult
    package func poster(
        _ value: Poster?
    ) -> HTML._Attributes<Self> {
        self.attribute(Poster.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Preload.swift
// ====================
//
//  Preload.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the preload attribute on an element
    @discardableResult
    package func preload(
        _ value: Preload?
    ) -> HTML._Attributes<Self> {
        self.attribute(Preload.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Readonly.swift
// ====================
///
/// Readonly.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Adds the readonly attribute to the element
    package var readonly: HTML._Attributes<Self> {
        self.attribute(Readonly.attribute)
    }

    /// Conditionally adds the readonly attribute to the element
    @HTML.Builder
    package func readonly(
        _ value: Readonly?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ReferrerPolicy.swift
// ====================
//
//  ReferrerPolicy.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the referrerpolicy attribute on an element
    @discardableResult
    package func referrerPolicy(
        _ value: ReferrerPolicy?
    ) -> HTML._Attributes<Self> {
        self.attribute(ReferrerPolicy.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Rel.swift
// ====================
///
/// Rel.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the rel attribute on an element
    @discardableResult
    package func rel(
        _ value: Rel?
    ) -> HTML._Attributes<Self> {
        self.attribute(Rel.attribute, value?.description)
    }
}

// extension HTML.View {
//    /// Sets the rel attribute with multiple link type values
//    @discardableResult
//    package func rel(
//        _ values: Rel.LinkType...
//    ) -> HTML._Attributes<Self> {
//        self.rel(Rel(values))
//    }
// }


// ====================
// Sources/HTML Attributes Rendering/Required.swift
// ====================
///
/// Required.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Adds the required attribute to the element
    package var required: HTML._Attributes<Self> {
        self.attribute(Required.attribute)
    }

    /// Conditionally adds the required attribute to the element
    @HTML.Builder
    package func required(
        _ value: Required?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Reversed.swift
// ====================
//
//  Reversed.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the reversed attribute on an element
    @discardableResult
    package func reversed(
        _ value: Reversed?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/RowSpan.swift
// ====================
//
//  RowSpan.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the rowspan attribute on an element
    @discardableResult
    package func rowspan(
        _ value: RowSpan?
    ) -> HTML._Attributes<Self> {
        self.attribute(RowSpan.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Rows.swift
// ====================
//
//  Rows.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the rows attribute on an element
    @discardableResult
    package func rows(
        _ value: Rows?
    ) -> HTML._Attributes<Self> {
        self.attribute(Rows.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Scope.swift
// ====================
//
//  Scope.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the scope attribute on an element
    @discardableResult
    package func scope(
        _ value: Scope?
    ) -> HTML._Attributes<Self> {
        self.attribute(Scope.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ScriptType.swift
// ====================
//
//  ScriptType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the type attribute on a script element
    @discardableResult
    package func type(
        _ value: ScriptType?
    ) -> HTML._Attributes<Self> {
        self.attribute(ScriptType.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Scrolling.swift
// ====================
//
//  Scope.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the scope attribute on an element
    @discardableResult
    package func scrolling(
        _ value: Scrolling?
    ) -> HTML._Attributes<Self> {
        self.attribute(Scrolling.attribute, value?.rawValue)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Selected.swift
// ====================
//
//  Selected.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the selected attribute on an element
    @discardableResult
    package func selected(
        _ value: Selected?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ShadowRootClonable.swift
// ====================
//
//  ShadowRootClonable.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the shadowrootclonable attribute on an element
    @discardableResult
    package func shadowRootClonable(
        _ value: ShadowRootClonable?
    ) -> HTML._Attributes<Self> {
        self.attribute(ShadowRootClonable.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ShadowRootDelegatesFocus.swift
// ====================
//
//  ShadowRootDelegatesFocus.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the shadowrootdelegatesfocus attribute on an element
    @discardableResult
    package func shadowRootDelegatesFocus(
        _ value: ShadowRootDelegatesFocus?
    ) -> HTML._Attributes<Self> {
        self.attribute(ShadowRootDelegatesFocus.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/ShadowRootMode.swift
// ====================
//
//  ShadowRootMode.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the shadowrootmode attribute on an element
    @discardableResult
    package func shadowRootMode(
        _ value: ShadowRootMode?
    ) -> HTML._Attributes<Self> {
        self.attribute(ShadowRootMode.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Size.swift
// ====================
///
/// Size.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the size attribute on an element
    @discardableResult
    package func size(
        _ value: Size?
    ) -> HTML._Attributes<Self> {
        self.attribute(Size.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Sizes.swift
// ====================
//
//  Sizes.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the sizes attribute on an element
    @discardableResult
    package func sizes(
        _ value: Sizes?
    ) -> HTML._Attributes<Self> {
        self.attribute(Sizes.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/SourceType.swift
// ====================
//
//  ScriptType.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the type attribute on a script element
    @discardableResult
    package func type(
        _ value: SourceType?
    ) -> HTML._Attributes<Self> {
        self.attribute(SourceType.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Span.swift
// ====================
//
//  Span.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes
import WHATWG_HTML_TableAttributes

extension HTML.View {

    /// Sets the span attribute on an element
    @discardableResult
    package func span(
        _ value: WHATWG_HTML_TableAttributes.Span?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG_HTML_TableAttributes.Span.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Src.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the step attribute on an element
    @discardableResult
    package func src(
        _ value: Src?
    ) -> HTML._Attributes<Self> {
        self.attribute(Src.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/SrcLang.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the step attribute on an element
    @discardableResult
    package func srcLang(
        _ value: SrcLang?
    ) -> HTML._Attributes<Self> {
        self.attribute(SrcLang.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Start.swift
// ====================
//
//  Start.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the start attribute on an element
    @discardableResult
    package func start(
        _ value: Start?
    ) -> HTML._Attributes<Self> {
        self.attribute(Start.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Step.swift
// ====================
///
/// Step.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the step attribute on an element
    @discardableResult
    package func step(
        _ value: Step?
    ) -> HTML._Attributes<Self> {
        self.attribute(Step.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Target.swift
// ====================
///
/// Target.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Add a target attribute to a form to specify where to display the response
    @discardableResult
    package func target(
        _ value: Target?
    ) -> HTML._Attributes<Self> {
        self.attribute(Target.attribute, value?.description)
    }
}

extension HTML.View {
    /// Add a target attribute to a form to specify where to display the response
    @discardableResult
    package func target(
        _ value: FormTarget?
    ) -> HTML._Attributes<Self> {
        self.attribute(FormTarget.attribute, value?.description)
    }
}

extension HTML.View {
    /// Add a target attribute to a form to specify where to display the response
    @discardableResult
    package func target(
        form value: Target?
    ) -> HTML._Attributes<Self> {
        self.attribute(Target.attribute, value?.description)
    }
}

extension HTML.View {
    /// Add a target attribute to specify where to display the linked URL
    @discardableResult
    public func target(
        anchor value: Target?
    ) -> HTML._Attributes<Self> {
        self.attribute(Target.attribute, value?.description)
    }

    /// Open the link in a new tab or window
    @discardableResult
    @HTML.Builder
    public func openInNewTab(
        withOpener: Bool = false
    ) -> some HTML.View {
        let result = self.target(anchor: .blank)

        if withOpener {
            result
        } else {
            result.rel(.noopener)
        }
    }

    /// Open the link in the parent browsing context
    @discardableResult
    public func openInParent() -> HTML._Attributes<Self> {
        self.target(anchor: .parent)
    }

    /// Open the link in the top-level browsing context
    @discardableResult
    public func openInTop() -> HTML._Attributes<Self> {
        self.target(anchor: .top)
    }
}


// ====================
// Sources/HTML Attributes Rendering/TextareaWrap.swift
// ====================
//
//  File 2.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes


// ====================
// Sources/HTML Attributes Rendering/Truespeed.swift
// ====================
//
//  File 2.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Adds the truespeed attribute to the element
    package var truespeed: HTML._Attributes<Self> {
        self.attribute(Truespeed.attribute)
    }

    /// Conditionally adds the truespeed attribute to the element
    @HTML.Builder
    package func truespeed(
        _ value: Truespeed?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Usemap.swift
// ====================
//
//  File 2.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the usemap attribute on an element
    @discardableResult
    package func usemap(
        _ value: Usemap?
    ) -> HTML._Attributes<Self> {
        self.attribute(Usemap.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Value.swift
// ====================
///
/// Value.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {
    /// Sets the value attribute on an element
    @discardableResult
    package func value<Element: CustomStringConvertible>(
        _ value: Value<Element>?
    ) -> HTML._Attributes<Self> {
        self.attribute(Value<Element>.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Width.swift
// ====================
///
/// Width.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 04/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the width attribute on an element
    @discardableResult
    package func width(
        _ value: Width?
    ) -> HTML._Attributes<Self> {
        self.attribute(Width.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Wrap.swift
// ====================
//
//  Wrap.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the wrap attribute on an element
    @discardableResult
    package func wrap(
        _ value: TextareaWrap?
    ) -> HTML._Attributes<Self> {
        self.attribute(TextareaWrap.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Attributes Rendering/Xmlns.swift
// ====================
//
//  File 3.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Renderable
import HTML_Standard_Attributes

extension HTML.View {

    /// Sets the xmlns attribute on an element
    @discardableResult
    package func xmlns(
        _ value: Xmlns?
    ) -> HTML._Attributes<Self> {
        self.attribute(Xmlns.attribute, value?.description)
    }
}


// ====================
// Sources/HTML Elements Rendering/Internal/HTMLElementNoAttributes.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

protocol HTMLElementNoAttributes: HTML.Element.`Protocol` {}

extension HTMLElementNoAttributes {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/Internal/HTMLVoidElement.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

// extension HTMLVoidElement where Self: HTML_Standard_Elements.HTMLElement & HTML.View {
//    public var body: HTML.Element.Tag<HTML.Empty> {
//        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
//    }
// }

// WORKAROUND because Input and BR fail to compile when called as BR(). With this function BR()() works
// TODO: Re-enable when HTML.VoidElement protocol is available
// extension HTML.VoidElement where Self: HTML_Standard_Elements.HTML.Element & HTML.View {
//     public func callAsFunction() -> some HTML.View {
//         self
//     }
// }


// ====================
// Sources/HTML Elements Rendering/Internal/exports.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

@_exported public import HTML_Attributes_Rendering
@_exported public import HTML_Standard_Elements


// ====================
// Sources/HTML Elements Rendering/a Anchor.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension WHATWG_HTML_TextSemantics.Anchor {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .attributionSrc(self.attributionsrc)
            .download(self.download)
            .href(self.href)
            .hreflang(self.hreflang)
            .ping(self.ping)
            .referrerPolicy(self.referrerpolicy)
            .rel(self.rel)
            .target(self.target)
    }
}


// ====================
// Sources/HTML Elements Rendering/abbr Abbreviation.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Abbreviation {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/address Contact Address.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

// extension Address: HTMLElementNoAttributes {}

extension HTML_Standard_Elements.Address {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/area Image Map Area.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import WHATWG_HTML_Embedded

extension WHATWG_HTML_Embedded.Area: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
            //        NEED TO FIX AREA domain model
            //            .shape(self.shape)
            //            .coords(self.coords)
            .alt(self.alt)
            .href(self.href)
            .download(download)
            .ping(ping)
            .referrerPolicy(referrerpolicy)
            .rel(rel)
            .target(target)
    }
}


// ====================
// Sources/HTML Elements Rendering/article Article Contents.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Article {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/aside Aside.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Aside {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/audio Embed Audio.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Audio {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .src(self.src)
            .controls(self.controls)
            .autoplay(self.autoplay)
            .loop(self.loop)
            .muted(self.muted)
            //            .preload(self.preload)
            .crossorigin(self.crossorigin)
            //            .controlslist(self.controlslist)
            .disableRemotePlayback(self.disableremoteplayback)
    }
}


// ====================
// Sources/HTML Elements Rendering/b Bring Attention To.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.B {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/base Document Base URL.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Base {
    @HTML.Builder
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        let element = HTML.Element.Tag(for: Self.self) { content() }
        switch self.configuration {
        case .href(let href):
            element.href(href)
        case .target(let target):
            element.target(target)
        case .both(let href, let target):
            element
                .href(href)
                .target(target)
        }
    }
}


// ====================
// Sources/HTML Elements Rendering/bdi Bidirectional Isolate.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.BidirectionalIsolate {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/bdo Bidirectional Text Override.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.BidirectionalTextOverride {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .dir(self.dir)
    }
}


// ====================
// Sources/HTML Elements Rendering/big Bigger Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Big {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/blockquote Block Quotation.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.BlockQuote {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .cite(self.cite)
    }
}


// ====================
// Sources/HTML Elements Rendering/body Document Body.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Body {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/br Line Break.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.BR: HTML.View {
    public var body: HTML.Element.Tag<HTML.Empty> {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
    }
}


// ====================
// Sources/HTML Elements Rendering/button Button.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Button {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .type(self.type)
            .disabled(self.disabled)
            .form(self.form)
            .name(self.name)
            .value(self.value)
            .autofocus(self.autofocus)
            .formAction(self.formaction)
            .formEncType(self.formenctype)
            .formMethod(self.formmethod)
            .formNovalidate(self.formnovalidate)
            .formTarget(self.formtarget)
            .popovertarget(self.popovertarget)
            .popovertargetaction(self.popovertargetaction)
    }
}


// ====================
// Sources/HTML Elements Rendering/canvas Graphics Canvas.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Canvas {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .width(self.width)
            .height(self.height)
    }
}


// ====================
// Sources/HTML Elements Rendering/caption Table Caption.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Caption {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/center Centered Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Center {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/cite Citation.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Cite {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/code Inline Code.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Code {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/col Table Column.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.TableColumn {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .span(self.span)
            .width(self.width)
    }
}


// ====================
// Sources/HTML Elements Rendering/colgroup Table Column Group.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.TableColumnGroup {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .span(self.span)
    }
}


// ====================
// Sources/HTML Elements Rendering/data Data.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Data {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .value(self.value)
    }
}


// ====================
// Sources/HTML Elements Rendering/datalist HTML Data List.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.DataList {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/dd Description Details.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.DescriptionDetails {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/del Deleted Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Del {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .cite(self.cite)
            .dateTime(self.datetime)
    }
}


// ====================
// Sources/HTML Elements Rendering/details Details disclosure.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Details {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .open(self.open)
            .name(self.name)
    }
}


// ====================
// Sources/HTML Elements Rendering/dfn Definition.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Definition {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .title(self.title)
    }
}


// ====================
// Sources/HTML Elements Rendering/dialog Dialog.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Dialog {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .open(self.open)
    }
}


// ====================
// Sources/HTML Elements Rendering/dir Directory.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Directory {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .compact(self.compact)
    }
}


// ====================
// Sources/HTML Elements Rendering/div Content Division.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.ContentDivision {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/dl Description List.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.DescriptionList {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/dt Description Term.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.DescriptionTerm {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/em Emphasis.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Emphasis {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/embed Embed External Content.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Embed {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .src(self.src)
            .type(self.type)
            .height(self.height)
            .width(self.width)
    }
}


// ====================
// Sources/HTML Elements Rendering/fencedframe Fenced Frame.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.FencedFrame {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .allow(self.allow)
            .height(self.height)
            .width(self.width)
    }
}


// ====================
// Sources/HTML Elements Rendering/fieldset Field Set.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.FieldSet {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .disabled(self.disabled)
            .form(self.form)
            .name(self.name)
    }
}


// ====================
// Sources/HTML Elements Rendering/figcaption Figure Caption.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.FigureCaption {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/figure Figure with Optional Caption.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Figure {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/font Font.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Font {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .color(self.color)
            .face(self.face)
            .size(self.size)
    }
}


// ====================
// Sources/HTML Elements Rendering/footer Footer.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Footer {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/form Form.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Form {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .accept(self.accept)
            .acceptCharset(self.acceptCharset)
            .autocapitalize(self.autocapitalize)
            .autocomplete(self.autocomplete)
            .name(self.name)
            .rel(self.rel)
            .action(self.action)
            .EncType(self.enctype)
            .method(self.method)
            .novalidate(self.novalidate)
            .target(self.target)
    }
}


// ====================
// Sources/HTML Elements Rendering/frame Frame.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Frame {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .src(self.src)
            .name(self.name)
            .noResize(self.noresize)
            .scrolling(self.scrolling)
            .marginHeight(self.marginheight)
            .marginWidth(self.marginwidth)
            .frameBorder(self.frameborder)
    }
}


// ====================
// Sources/HTML Elements Rendering/frameset Frameset.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Frameset {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .cols(self.cols)
            .rows(self.rows)
    }
}


// ====================
// Sources/HTML Elements Rendering/h1-h6 HTML Section Heading.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.H1 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H2 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H3 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H4 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H5 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H6 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/head Document Metadata (Header).swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Head {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/header Header.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Header {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/hgroup Heading Group.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.HeadingGroup {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/hr Thematic Break (Horizontal Rule).swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.ThematicBreak: HTML.View {
    public var body: HTML.Element.Tag<HTML.Empty> {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
    }
}


// ====================
// Sources/HTML Elements Rendering/html HTML Document Root element.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.HtmlRoot {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .xmlns(self.xmlns)
    }
}


// ====================
// Sources/HTML Elements Rendering/i Idiomatic Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.IdiomaticText {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/iframe Inline Frame.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.InlineFrame {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .src(self.src)
            .attribute("srcdoc", self.srcdoc)
            .name(self.name)
            .attribute("sandbox", self.sandbox)
            .allowfullscreen(self.allowfullscreen)
            .allow(self.allow)
            .width(self.width)
            .height(self.height)
            .loading(self.loading)
            .referrerPolicy(self.referrerpolicy)
    }
}


// ====================
// Sources/HTML Elements Rendering/img Image Embed.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Image: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self)
            .src(self.src)
            .alt(self.alt)
            .loading(self.loading)
    }
}


// ====================
// Sources/HTML Elements Rendering/input Input.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 04/04/2025.
//
//

import HTML_Attributes_Rendering
public import HTML_Standard
import HTML_Standard_Elements

extension HTML_Standard.Input: HTML.View {}

extension HTML_Standard.Input {
    @HTML.Builder
    public var body: some HTML.View {
        let input = HTML.Element.Tag(for: Self.self) { HTML.Empty() }
            .name(name)
            .disabled(self.disabled)
            .attribute("type", self.type.label)

        switch type {
        case .button(let button):
            input
                .value(button.value)
        case .checkbox(let checkbox):
            input
                .value(checkbox.value)
                .checked(checkbox.checked)
                .required(checkbox.required)
        case .color(let color):
            input
                .value(color.value)
        case .date(let date):
            input
                .value(date.value)
                .min(date.min)
                .max(date.max)
                .step(date.step)
                .required(date.required)
        case .datetimeLocal(let datetimeLocal):
            input
                .value(datetimeLocal.value)
                .min(datetimeLocal.min)
                .max(datetimeLocal.max)
                .step(datetimeLocal.step)
                .required(datetimeLocal.required)
        case .email(let email):
            input
                .value(email.value)
                .maxlength(email.maxlength)
                .minlength(email.minlength)
                .multiple(email.multiple)
                .required(email.required)
                .pattern(email.pattern)
                .placeholder(email.placeholder)
                .readonly(email.readonly)
                .size(email.size)
        case .file(let file):
            input
                .accept(file.accept)
                .capture(file.capture)
                .multiple(file.multiple)
                .required(file.required)
        case .hidden(let hidden):
            input
                .value(hidden.value)
        case .image(let image):
            input
                .alt(image.alt)
                .height(image.height)
                .width(image.width)
                .required(image.required)
                .src(image.src)
                .formAction(image.form.action)
                .formEncType(image.form.enctype)
                .formMethod(image.form.method)
                .formNovalidate(image.form.novalidate)
                .formTarget(image.form.target)
        case .month(let month):
            input
                .value(month.value)
                .list(month.list)
                .min(month.min)
                .max(month.max)
                .readonly(month.readonly)
                .step(month.step)
                .required(month.required)
        case .number(let number):
            input
                .value(number.value)
                .min(number.min)
                .max(number.max)
                .placeholder(number.placeholder)
                .readonly(number.readonly)
                .step(number.step)
                .required(number.required)
        case .password(let password):
            input
                .value(password.value)
                .maxlength(password.maxlength)
                .minlength(password.minlength)
                .pattern(password.pattern)
                .placeholder(password.placeholder)
                .readonly(password.readonly)
                .size(password.size)
                .autocomplete(password.autocomplete)
                .required(password.required)
        case .radio(let radio):
            input
                .value(radio.value)
                .checked(radio.checked)
                .required(radio.required)
        case .range(let range):
            input
                .value(range.value)
                .min(range.min)
                .max(range.max)
                .step(range.step)
                .list(range.list)
        case .reset(let reset):
            input
                .value(reset.value)
                .required(reset.required)
        case .search(let search):
            input
                .value(search.value)
                .list(search.list)
                .maxlength(search.maxlength)
                .minlength(search.minlength)
                .pattern(search.pattern)
                .placeholder(search.placeholder)
                .readonly(search.readonly)
                .size(search.size)
                .spellcheck(search.spellcheck)
                .required(search.required)
        case .submit(let submit):
            input
                .formAction(submit.formaction)
                .formEncType(submit.formenctype)
                .formMethod(submit.formmethod)
                .formNovalidate(submit.formnovalidate)
                .formTarget(submit.formtarget)
                .value(submit.value)
                .required(submit.required)
        case .tel(let tel):
            input
                .value(tel.value)
                .list(tel.list)
                .maxlength(tel.maxlength)
                .minlength(tel.minlength)
                .pattern(tel.pattern)
                .placeholder(tel.placeholder)
                .readonly(tel.readonly)
                .size(tel.size)
                .required(tel.required)
        case .text(let text):
            input
                .value(text.value)
                .list(text.list)
                .maxlength(text.maxlength)
                .minlength(text.minlength)
                .pattern(text.pattern)
                .placeholder(text.placeholder)
                .readonly(text.readonly)
                .size(text.size)
                .spellcheck(text.spellcheck)
                .required(text.required)
        case .time(let time):
            input
                .value(time.value)
                .list(time.list)
                .min(time.min)
                .max(time.max)
                .readonly(time.readonly)
                .step(time.step)
                .required(time.required)
        case .url(let url):
            input
                .value(url.value)
                .list(url.list)
                .maxlength(url.maxlength)
                .minlength(url.minlength)
                .pattern(url.pattern)
                .placeholder(url.placeholder)
                .readonly(url.readonly)
                .size(url.size)
                .spellcheck(url.spellcheck)
                .required(url.required)
        case .week(let week):
            input
                .value(week.value)
                .list(week.list)
                .min(week.min)
                .max(week.max)
                .readonly(week.readonly)
                .step(week.step)
                .required(week.required)
        case .datetime:
            input
        }
    }
}


// ====================
// Sources/HTML Elements Rendering/ins Inserted Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.InsertedText {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .cite(self.cite)
            .dateTime(self.datetime)
    }
}


// ====================
// Sources/HTML Elements Rendering/kbd Keyboard Input.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.KeyboardInput {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/label Label.swift
// ====================
/////
///// Label.swift
///// swift-html
/////
///// Represents the HTML label element for form controls.
/////
///// Created by Coen ten Thije Boonkkamp on 04/04/2025.
/////
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Label {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .for(self.for)
    }
}


// ====================
// Sources/HTML Elements Rendering/legend Field Set Legend.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Legend {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/li List Item.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.ListItem {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .value(self.value)
    }
}


// ====================
// Sources/HTML Elements Rendering/link External Resource Link.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Link: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
            .`as`(self.`as`)
            .blocking(self.blocking)
            .crossorigin(self.crossorigin)
            .disabled(self.disabled)
            .fetchPriority(self.fetchpriority)
            .href(self.href)
            .hreflang(self.hreflang)
            .sizes(self.imagesizes)
            .srcset(self.imagesrcset)
            .integrity(self.integrity)
            .media(self.media)
            .referrerPolicy(self.referrerpolicy)
            .rel(self.rel)
            .sizes(self.sizes)
            .title(self.title)
            .type(self.type)
    }
}


// ====================
// Sources/HTML Elements Rendering/main Main.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Main {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/map Image Map.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Map {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .name(self.name)
    }
}


// ====================
// Sources/HTML Elements Rendering/mark Mark Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Mark {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/marquee Marquee.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Marquee {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .behavior(self.behavior)
            //            .bgcolor(self.bgcolor)
            .attribute("bgcolor", self.bgcolor)
            .direction(self.direction)
            .height(self.height)
            .attribute("hspace", self.hspace)
            .loop(self.loop)
            .attribute("scrollamount", self.scrollamount)
            .attribute("scrolldelay", self.scrolldelay)
            .attribute(boolean: self.truespeed)
            .attribute("vspace", self.vspace)
            .width(self.width)
    }
}


// ====================
// Sources/HTML Elements Rendering/menu Menu.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Menu {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/meta Metadata.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Meta: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
            .charset(self.charset)
            .content(self.content)
            .httpEquiv(self.httpEquiv)
            .media(self.media)
            .name(self.name)
    }
}


// ====================
// Sources/HTML Elements Rendering/meter Meter.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Meter {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .value(self.value)
            .min(self.min)
            .max(self.max)
            .low(self.low)
            .high(self.high)
            .optimum(self.optimum)
            .form(self.form)
    }
}


// ====================
// Sources/HTML Elements Rendering/nav Navigation Section.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.NavigationSection {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/nobr Non-Breaking Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.NoBr {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/noembed Embed Fallback.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension WHATWG_HTML_Obsolete.EmbedFallback {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/noframes Frame Fallback.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension WHATWG_HTML_Obsolete.FrameFallback {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/noscript Noscript.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Noscript {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/object External Object.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.ExternalObject {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .data(self.data)
            .type(self.type)
            .form(self.form)
            .name(self.name)
            .height(self.height)
            .width(self.width)
            .usemap(self.usemap)
    }
}


// ====================
// Sources/HTML Elements Rendering/ol Ordered List.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.OrderedList {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .reversed(self.reversed)
            .start(self.start)
            .type(self.type)
    }
}


// ====================
// Sources/HTML Elements Rendering/optgroup Option Group.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.OptionGroup {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .disabled(self.disabled)
            .label(self.label)
    }
}


// ====================
// Sources/HTML Elements Rendering/option Option.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Option: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self)
            .disabled(self.disabled)
            .label(self.label)
            .selected(self.selected)
            .value(self.value)
    }

    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .disabled(self.disabled)
            .label(self.label)
            .selected(self.selected)
            .value(self.value)
    }
}


// ====================
// Sources/HTML Elements Rendering/output Output.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Output {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .`for`(self.`for`)
            .form(self.form)
            .name(self.name)
    }
}


// ====================
// Sources/HTML Elements Rendering/p Paragraph.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Paragraph {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/param Object Parameter.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension WHATWG_HTML_Obsolete.Param: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
            .name(self.name)
            .value(self.value)
    }
}


// ====================
// Sources/HTML Elements Rendering/picture Picture.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Picture {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/plaintext Plain Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension WHATWG_HTML_Obsolete.PlainText {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/pre Preformatted Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.PreformattedText {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/progress Progress Indicator.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.ProgressIndicator {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .max(self.max)
            .value(self.value)
    }
}


// ====================
// Sources/HTML Elements Rendering/q Inline Quotation.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.InlineQuotation {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .cite(self.cite)
    }
}


// ====================
// Sources/HTML Elements Rendering/rb Ruby Base.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.RubyBase {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/rp Ruby Fallback Parenthesis.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.RubyParenthesis {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/rt Ruby Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.RubyText {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/rtc Ruby Text Container.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.RubyTextContainer {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/ruby Ruby Annotation.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Ruby {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/s Strikethrough.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Strikethrough {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/samp Sample Output.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Samp {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/script Script.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Script {
    public func callAsFunction(
        _ script: () -> String = { "" }
    ) -> some HTML.View {

        let script = script()
        var escaped = ""
        escaped.unicodeScalars.reserveCapacity(script.unicodeScalars.count)

        for index in script.unicodeScalars.indices {
            let scalar = script.unicodeScalars[index]
            if scalar == "<",
                script.unicodeScalars[index...].starts(with: "<!--".unicodeScalars)
                    || script.unicodeScalars[index...].starts(with: "<script".unicodeScalars)
                    || script.unicodeScalars[index...].starts(with: "</script".unicodeScalars) {
                escaped.unicodeScalars.append(contentsOf: #"\x3C"#.unicodeScalars)
            } else {
                escaped.unicodeScalars.append(scalar)
            }
        }

        return HTML.Element.Tag(for: Self.self) {
            if script.isEmpty { HTML.Empty() } else { HTML.Raw(escaped) }
        }
        .src(self.src)
        .`async`(self.`async`)
        .`defer`(self.`defer`)
        .type(self.type)
        .integrity(self.integrity)
        .referrerPolicy(self.referrerpolicy)
        .nomodule(self.nomodule)
        .fetchPriority(self.fetchpriority)
        .blocking(self.blocking)
        .crossorigin(self.crossorigin)
        .nonce(self.nonce)
        .attributionSrc(self.attributionsrc)
    }
}

extension HTML_Standard_Elements.Script: HTML.View {
    public var body: some HTML.View {
        Script(
            src: self.src,
            async: self.async,
            defer: self.defer,
            type: self.type,
            integrity: self.integrity,
            referrerpolicy: self.referrerpolicy,
            nomodule: self.nomodule,
            fetchpriority: self.fetchpriority,
            blocking: self.blocking,
            crossorigin: self.crossorigin,
            nonce: self.nonce,
            attributionsrc: self.attributionsrc
        ).callAsFunction {
            ""
        }
    }
}


// ====================
// Sources/HTML Elements Rendering/search Search.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Search {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/section Generic Section.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Section {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/select Selected Option Display.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Select {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .multiple(self.multiple)
            .name(self.name)
            .required(self.required)
            .size(self.size)
            .disabled(self.disabled)
            .form(self.form)
            .autofocus(self.autofocus)
    }
}


// ====================
// Sources/HTML Elements Rendering/slot Web Component Slot.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.WebComponentSlot {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .name(self.name)
    }
}


// ====================
// Sources/HTML Elements Rendering/small Side Comment.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Small {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/source Media or Image Source.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Source: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
            .type(self.type)
            .src(self.src)
            .srcset(self.srcset)
            .sizes(self.sizes)
            .media(self.media)
            .height(self.height)
            .width(self.width)
    }
}


// ====================
// Sources/HTML Elements Rendering/span Content Span.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.ContentSpan {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/strike Strike.swift
// ====================
//
//  File 2.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Strike {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/strong Strong Importance.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.StrongImportance {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/style Style Information.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Style {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .media(media)
            .blocking(blocking)
            .nonce(nonce)
            .title(title)
    }
}


// ====================
// Sources/HTML Elements Rendering/sub Subscript.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Subscript {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/summary Disclosure Summary.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.DisclosureSummary {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/sup Superscript.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Superscript {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/table Table.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Table {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/tbody Table Body.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.TableBody {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/td Table Data Cell.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.TableDataCell {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .colspan(self.colspan)
            .headers(self.headers)
            .rowspan(self.rowspan)
    }
}


// ====================
// Sources/HTML Elements Rendering/template Content Template.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.ContentTemplate {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .shadowRootMode(shadowrootmode)
            .shadowRootClonable(shadowrootclonable)
            .shadowRootDelegatesFocus(shadowrootdelegatesfocus)
    }
}


// ====================
// Sources/HTML Elements Rendering/textarea Textarea.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Textarea {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View = { HTML.Empty() }
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .autocapitalize(self.autocapitalize)
            .autocomplete(self.autocomplete)
            .autocorrect(self.autocorrect)
            .autofocus(self.autofocus)
            .cols(self.cols)
            .dirname(self.dirname)
            .disabled(self.disabled)
            .form(self.form)
            .maxlength(self.maxlength)
            .minlength(self.minlength)
            .name(self.name)
            .placeholder(self.placeholder)
            .readonly(self.readonly)
            .required(self.required)
            .rows(self.rows)
            .spellcheck(self.spellcheck)
            .wrap(self.wrap)
    }
}


// ====================
// Sources/HTML Elements Rendering/tfoot Table Foot.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.TableFoot {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/th Table Header.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.TableHeader {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .abbr(self.abbr)
            .colspan(self.colspan)
            .headers(self.headers)
            .rowspan(self.rowspan)
            .scope(self.scope)
    }
}


// ====================
// Sources/HTML Elements Rendering/thead Table Head.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.TableHead {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/time (Date) Time.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension WHATWG_HTML_TextSemantics.Time {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .dateTime(self.datetime)
    }
}


// ====================
// Sources/HTML Elements Rendering/title Document Title.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Title {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/tr Table Row.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.TableRow {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/track Embed Text Track.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Track: HTML.View {
    public var body: some HTML.View {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
            .default(self.default)
            .kind(self.kind)
            .label(self.label)
            .src(self.src)
            .srcLang(self.srclang)
    }
}


// ====================
// Sources/HTML Elements Rendering/tt Teletype Text.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.TeletypeText {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/u Unarticulated Annotation (Underline).swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.UnarticulatedAnnotation {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/ul Unordered List.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.UnorderedList {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/var Variable.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Variable {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element.Tag<Content> {
        HTML.Element.Tag(for: Self.self) { content() }
    }
}


// ====================
// Sources/HTML Elements Rendering/video Video Embed.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Video {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element.Tag(for: Self.self) { content() }
            .src(self.src)
            .controls(self.controls)
            .autoplay(self.autoplay)
            .poster(self.poster)
            .loop(self.loop)
            .muted(self.muted)
            .width(self.width)
            .height(self.height)
            .preload(self.preload)
            .playsinline(self.playsinline)
            .crossorigin(self.crossorigin)
            .controlsList(self.controlslist)
            .disablePictureInPicture(self.disablepictureinpicture)
            .disableRemotePlayback(self.disableremoteplayback)
    }
}


// ====================
// Sources/HTML Elements Rendering/wbr Line Break Opportunity.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.LineBreakOpportunity: HTML.View {
    public var body: HTML.Element.Tag<HTML.Empty> {
        HTML.Element.Tag(for: Self.self) { HTML.Empty() }
    }
}


// ====================
// Sources/HTML Elements Rendering/xmp xmp.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

// extension xmp {
//    public func callAsFunction(
//        @HTML.Builder _ content: () -> some HTML.View
//    ) -> some HTML.View {
//        HTML.Element.Tag(for: Self.self) { content() }
//    }
// }


// ====================
// Sources/HTML Renderable/AsyncChannel+HTML.swift
// ====================
//
//  AsyncChannel+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

import Rendering
public import WHATWG_HTML_Shared
public import RenderingAsync

extension AsyncChannel<ArraySlice<UInt8>> {
    /// Stream HTML with true progressive rendering and backpressure.
    ///
    /// This is the canonical way to stream HTML when you need bounded memory.
    /// The producer suspends when the consumer is slow, ensuring memory
    /// usage is bounded to O(chunkSize) throughout the entire process.
    ///
    /// This is an HTML-specific convenience that wraps the generic
    /// `AsyncChannel(rendering:chunkSize:)` from `RenderingAsync`,
    /// adding `@HTML.Builder` syntax and `HTML.Context` configuration.
    ///
    /// ## When to Use
    ///
    /// Use `AsyncChannel` when:
    /// - Streaming large documents to HTTP clients
    /// - Memory usage must be bounded regardless of document size
    /// - You want true backpressure (producer waits for slow consumers)
    ///
    /// Use `[UInt8](html)` instead when:
    /// - You need the complete document (e.g., PDF generation)
    /// - The document is small
    /// - Simplicity is preferred over streaming
    ///
    /// ## Canonical Usage
    ///
    /// ```swift
    /// for await chunk in AsyncChannel { myView } {
    ///     await response.write(chunk)
    /// }
    /// ```
    ///
    /// ## Memory Characteristics
    ///
    /// | Pattern | Memory |
    /// |---------|--------|
    /// | `[UInt8](html)` | O(doc size) |
    /// | `AsyncChannel { html }` | **O(chunkSize)** |
    ///
    /// - Parameters:
    ///   - chunkSize: Size of each yielded chunk in bytes. Default is 4096.
    ///   - configuration: Rendering configuration. Uses default if nil.
    ///   - view: The HTML content to stream.
    ///
    /// - SeeAlso: `AsyncChannel(rendering:chunkSize:)` in `RenderingAsync` for
    ///   the generic implementation and detailed explanation of the concurrent
    ///   producer/consumer pattern.
    public convenience init<View: HTML.View & AsyncRenderable & Sendable>(
        chunkSize: Int = 4096,
        configuration: HTML.Context.Configuration? = nil,
        @HTML.Builder _ view: () -> View
    ) {
        self.init()
        let view = view()
        let config = configuration ?? .current
        let channel = self

        // Task.detached is required here for concurrent producer/consumer.
        // See AsyncChannel(rendering:chunkSize:) in RenderingAsync for detailed explanation.
        Task.detached {
            let sink = Rendering.Async.Sink.Buffered(channel: channel, chunkSize: chunkSize)
            var context = HTML.Context(config)
            await View._renderAsync(view, into: sink, context: &context)
            await sink.finish()
        }
    }
}

extension AsyncChannel<ArraySlice<UInt8>> {
    /// Stream an HTML document with true progressive rendering and backpressure.
    ///
    /// This is an HTML-specific convenience that wraps the generic
    /// `AsyncChannel(rendering:chunkSize:)` from `RenderingAsync`,
    /// adding `@HTML.Builder` syntax and `HTML.Context` configuration.
    ///
    /// ## Canonical Usage
    ///
    /// ```swift
    /// let document = HTML.Document { div { "Hello" } }
    /// for await chunk in AsyncChannel { document } {
    ///     await response.write(chunk)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - chunkSize: Size of each yielded chunk in bytes. Default is 4096.
    ///   - configuration: Rendering configuration. Uses default if nil.
    ///   - document: The HTML document to stream.
    ///
    /// - SeeAlso: `AsyncChannel(rendering:chunkSize:)` in `RenderingAsync` for
    ///   the generic implementation and detailed explanation of the concurrent
    ///   producer/consumer pattern.
    public convenience init<Document: HTML.DocumentProtocol & AsyncRenderable & Sendable>(
        chunkSize: Int = 4096,
        configuration: HTML.Context.Configuration? = nil,
        @HTML.Builder _ document: () -> Document
    ) {
        self.init()
        let document = document()
        let config = configuration ?? .current
        let channel = self

        // Task.detached is required here for concurrent producer/consumer.
        // See AsyncChannel(rendering:chunkSize:) in RenderingAsync for detailed explanation.
        Task.detached {
            let sink = Rendering.Async.Sink.Buffered(channel: channel, chunkSize: chunkSize)
            var context = HTML.Context(config)
            await Document._renderAsync(document, into: sink, context: &context)
            await sink.finish()
        }
    }
}


// ====================
// Sources/HTML Renderable/Collection<UInt8>+HTML.swift
// ====================
//
//  RangeReplaceableCollection+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

import Rendering
public import WHATWG_HTML_Shared

extension Collection<UInt8> {
    public static var html: HTML.Type {
        HTML.self
    }
}


// ====================
// Sources/HTML Renderable/ForEach+HTML.swift
// ====================
//
//  ForEach+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 17/12/2025.
//

public import Rendering
public import HTML_Standard

// Extend the ForEach type from Rendering module to conform to HTML.View
// Note: ForEach is a top-level type exported from the Rendering module.
// Users can access it as ForEach<Content> directly.
extension ForEach: HTML.View where Content: HTML.View {}


// ====================
// Sources/HTML Renderable/HTML.AnyView.swift
// ====================
//
//  HTML.AnyView.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// Type-erased wrapper for any HTML content.
    ///
    /// `HTML.AnyView` allows you to work with heterogeneous HTML types
    /// by erasing their specific type while preserving their rendering behavior.
    ///
    /// Example:
    /// ```swift
    /// func makeContent(condition: Bool) -> HTML.AnyView {
    ///     if condition {
    ///         HTML.AnyView(div { "Hello" })
    ///     } else {
    ///         HTML.AnyView(span { "World" })
    ///     }
    /// }
    /// ```
    public struct AnyView: HTML.View, @unchecked Sendable {
        public let base: any HTML.View
        private let renderFunction: (inout ContiguousArray<UInt8>, inout HTML.Context) -> Void

        public init<T: HTML.View>(_ base: T) {
            self.base = base
            self.renderFunction = { buffer, context in
                T._render(base, into: &buffer, context: &context)
            }
        }

        /// Creates a type-erased HTML wrapper from an existential HTML.View.
        ///
        /// This initializer handles the case where you already have an `any HTML.View`
        /// and need to wrap it in `AnyView` to apply modifiers.
        public init(_ base: any HTML.View) {
            // If it's already an AnyView, unwrap to avoid double-wrapping
            if let anyView = base as? HTML.AnyView {
                self = anyView
            } else {
                self.base = base
                self.renderFunction = { buffer, context in
                    func render<T: HTML.View>(_ html: T) {
                        T._render(html, into: &buffer, context: &context)
                    }
                    render(base)
                }
            }
        }

        public static func _render<Buffer: RangeReplaceableCollection>(
            _ html: HTML.AnyView,
            into buffer: inout Buffer,
            context: inout HTML.Context
        ) where Buffer.Element == UInt8 {
            var contiguousBuffer = ContiguousArray<UInt8>()
            html.renderFunction(&contiguousBuffer, &context)
            buffer.append(contentsOf: contiguousBuffer)
        }

        public var body: Never { fatalError("body should not be called") }
    }
}

extension HTML.AnyView {
    /// Creates a type-erased HTML wrapper from a builder closure.
    ///
    /// - Parameter closure: A closure that returns any HTML content.
    public init(
        @HTML.Builder _ closure: () -> any HTML.View
    ) {
        self.init(closure())
    }
}

// Keep AnyRenderable conformance for interoperability
extension AnyRenderable: @retroactive Renderable where Context == HTML.Context {
    public typealias Content = Never
    public typealias Output = UInt8

    public var body: Never { fatalError("body should not be called") }
}

extension AnyRenderable: HTML.View where Context == HTML.Context {}
public typealias AnyHTML = HTML.AnyView


// ====================
// Sources/HTML Renderable/HTML.AtRule.Media.swift
// ====================
//
//  HTML.AtRule.Media.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 16/04/2025.
//

import Rendering
public import WHATWG_HTML_Shared

extension HTML.AtRule {
    public typealias Media = HTML.AtRule
}


// ====================
// Sources/HTML Renderable/HTML.AtRule.swift
// ====================
//
//  HTML.AtRule.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 16/04/2025.
//

import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// Represents a CSS media query for conditional styling.
    ///
    /// `HTML.AtRule` allows you to apply styles conditionally based on
    /// device characteristics or user preferences.
    ///
    /// Example:
    /// ```swift
    /// div { "Dark mode text" }
    ///     .inlineStyle("color", "white", media: .dark)
    /// ```
    ///
    /// You can use the predefined media queries or create custom ones.
    public struct AtRule: RawRepresentable, Hashable, Sendable {
        /// Creates a media query with the specified CSS media query string.
        ///
        /// - Parameter rawValue: The CSS media query string.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The CSS media query string.
        public var rawValue: String
    }
}


// ====================
// Sources/HTML Renderable/HTML.Builder.swift
// ====================
//
//  Builder+HTML.swift
//
//
//  Created by Point-Free, Inc
//

public import Rendering
public import WHATWG_HTML_Shared

public typealias BuilderRaw = Builder

extension Builder {
    /// Creates an empty HTML component when no content is provided.
    ///
    /// - Returns: An empty HTML component.
    public static func buildBlock() -> Empty {
        Empty()
    }

    //    /// Converts a text expression to HTML text.
    //    ///
    //    /// - Parameter expression: The HTML text to convert.
    //    /// - Returns: The same HTML text.
    //    public static func buildExpression(_ expression: HTML.Text) -> HTML.Text {
    //        expression
    //    }
}

extension HTML {
    public typealias Builder = BuilderRaw
}


// ====================
// Sources/HTML Renderable/HTML.Context.Configuration.swift
// ====================
//
//  HTML.Context.Configuration.swift
//  swift-html-rendering
//
//  Configuration and error types for HTML rendering.
//

import INCITS_4_1986
import Rendering
public import WHATWG_HTML_Shared

extension HTML.Context {

    /// Configuration options for HTML rendering.
    ///
    /// This struct provides options to control how HTML is rendered,
    /// including pretty-printing options and special handling for
    /// specific contexts like email.
    ///
    /// ## Task-Local Configuration
    ///
    /// Use the `current` task-local to configure rendering without passing
    /// configuration explicitly:
    ///
    /// ```swift
    /// HTML.Context.Configuration.$current.withValue(.pretty) {
    ///     let html = ContiguousArray(document)
    /// }
    /// ```
    public struct Configuration: Sendable {

        /// Whether to add `!important` to all CSS rules.
        public let forceImportant: Bool

        /// The bytes to use for indentation.
        ///
        /// Stored as bytes to avoid UTF-8 conversion overhead during rendering.
        public let indentation: [UInt8]

        /// The bytes to use for newlines.
        ///
        /// Stored as bytes to avoid UTF-8 conversion overhead during rendering.
        public let newline: [UInt8]

        /// Reserved capacity for the byte buffer (in bytes).
        ///
        /// Pre-allocating capacity avoids multiple reallocations during rendering.
        /// Set to 0 for no reservation (default), or estimate your typical document size.
        ///
        /// ## Typical Sizes
        /// - Small documents (< 1KB): 512 bytes
        /// - Medium documents (1-10KB): 4096 bytes
        /// - Large documents (> 10KB): 16384 bytes
        public let reservedCapacity: Int

        /// Creates a custom HTML rendering configuration.
        ///
        /// - Parameters:
        ///   - forceImportant: Whether to add `!important` to all CSS rules.
        ///   - indentation: The bytes to use for indentation.
        ///   - newline: The bytes to use for newlines.
        ///   - reservedCapacity: Reserved capacity for the byte buffer in bytes.
        public init(
            forceImportant: Bool,
            indentation: [UInt8],
            newline: [UInt8],
            reservedCapacity: Int
        ) {
            self.forceImportant = forceImportant
            self.indentation = indentation
            self.newline = newline
            self.reservedCapacity = reservedCapacity
        }
    }
}

extension HTML.Context.Configuration {

    /// Default configuration with no indentation or newlines.
    ///
    /// Pre-allocates 1KB to handle most simple documents without reallocation.
    public static let `default` = Self(
        forceImportant: false,
        indentation: [],
        newline: [],
        reservedCapacity: 1024
    )

    /// Pretty-printing configuration with 2-space indentation and newlines.
    ///
    /// Pre-allocates 2KB to accommodate additional whitespace from formatting.
    public static let pretty = Self(
        forceImportant: false,
        indentation: [.ascii.space, .ascii.space],
        newline: [.ascii.lf],
        reservedCapacity: 2048
    )

    /// Configuration optimized for email HTML with forced important styles.
    ///
    /// Pre-allocates 2KB as email HTML tends to be verbose with inline styles.
    public static let email = Self(
        forceImportant: true,
        indentation: [.ascii.space],
        newline: [.ascii.lf],
        reservedCapacity: 2048
    )

    /// Performance-optimized configuration for typical documents (~4KB).
    ///
    /// Pre-allocates 4096 bytes to avoid reallocations for most documents.
    /// Use this when rendering performance is critical.
    public static let optimized = Self(
        forceImportant: false,
        indentation: [],
        newline: [],
        reservedCapacity: 4096
    )
}

extension HTML.Context.Configuration {
    /// Task-local configuration for HTML rendering.
    ///
    /// This enables configuration without explicit parameter passing.
    /// Use `$current.withValue(.pretty) { ... }` to set configuration
    /// for a scope.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Default (minified)
    /// let minified = ContiguousArray(html)
    ///
    /// // Pretty-printed
    /// HTML.Context.Configuration.$current.withValue(.pretty) {
    ///     let pretty = ContiguousArray(html)
    /// }
    /// ```
    @TaskLocal public static var current: Self = .default
}

extension HTML.Context.Configuration {
    /// An error type representing HTML rendering failures.
    ///
    /// This error is thrown when there's a problem rendering HTML content
    /// or when the rendered bytes cannot be converted to a string.
    public struct Error: Swift.Error {
        /// A description of what went wrong during HTML rendering.
        public let message: String
    }
}


// ====================
// Sources/HTML Renderable/HTML.Context.swift
// ====================
//
//  HTML.Context.swift
//  swift-html-rendering
//
//  Rendering context for HTML streaming.
//  Holds state (attributes, styles, indentation) separate from the output buffer.
//

import INCITS_4_1986
public import OrderedCollections
import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// Rendering context for HTML streaming.
    ///
    /// `HTML.Context` holds the state needed during HTML rendering, separate from the output buffer.
    /// This separation enables streaming rendering where the buffer can be any `RangeReplaceableCollection<UInt8>`.
    ///
    /// ## Design Philosophy
    ///
    /// The rendering state is decoupled from the output destination:
    /// - **Context**: Attributes, styles, indentation, rendering configuration
    /// - **Buffer**: Where bytes are written (generic, caller-controlled)
    ///
    /// This enables the same rendering logic to write to `[UInt8]`, `ContiguousArray<UInt8>`,
    /// `Data`, `ByteBuffer`, or any other byte buffer.
    public struct Context: Sendable {
        /// The current set of attributes to apply to the next HTML element.
        public var attributes: OrderedDictionary<String, String>

        /// The collected styles mapped to their generated class names.
        /// Style → className (e.g., HTML.Element.Style(Color.red) → "color-0")
        public var styles: OrderedDictionary<HTML.Element.Style, String>

        /// Configuration for rendering, including formatting options.
        public let configuration: Configuration

        /// The current indentation level for pretty-printing.
        public var currentIndentation: [UInt8]

        /// Counter for generating sequential class names.
        /// Each render context starts at 0, ensuring deterministic naming.
        private var styleCounter: Int
    }
}

extension HTML.Context {
    /// Creates a new HTML rendering context with the specified rendering configuration.
    ///
    /// - Parameter configuration: The rendering configuration to use. Defaults to current task-local value.
    public init(_ configuration: Configuration = .current) {
        self.attributes = [:]
        self.styles = [:]
        self.configuration = configuration
        self.currentIndentation = []
        self.styleCounter = 0
    }
}

extension HTML.Context {
    // MARK: - Style Push API

    /// Push a style to the context and get its class name.
    ///
    /// Same style always returns same class name within a render context.
    /// Class names are descriptive and sequential: `color-0`, `margin-1`, etc.
    ///
    /// - Parameter style: The style to register.
    /// - Returns: A deterministic class name for the style.
    public mutating func pushStyle(
        _ style: HTML.Element.Style
    ) -> String {
        if let existing = styles[style] {
            return existing
        }
        let className = "\(style.propertyName)-\(styleCounter)"
        styleCounter += 1
        styles[style] = className
        return className
    }
}

extension HTML.Context {
    /// Generates a CSS stylesheet from the collected styles as bytes.
    ///
    /// This is the canonical implementation - generates bytes directly without
    /// intermediate String allocation.
    ///
    /// - Parameter baseIndentation: The base indentation to apply to all CSS rules.
    ///   This should match the indentation level of the containing `<style>` tag's content.
    /// - Returns: The stylesheet bytes with proper indentation.
    public func stylesheetBytes(baseIndentation: [UInt8] = []) -> ContiguousArray<UInt8> {
        // Group styles by atRule
        var grouped: OrderedDictionary<HTML.AtRule?, [(style: HTML.Element.Style, className: String)]> = [:]
        for (style, className) in styles {
            grouped[style.atRule, default: []].append((style, className))
        }

        var sheet = ContiguousArray<UInt8>()
        let sortedGroups = grouped.sorted(by: { $0.key == nil ? $1.key != nil : false })

        for (atRule, stylesForAtRule) in sortedGroups {
            if let atRule {
                sheet.append(contentsOf: configuration.newline)
                sheet.append(contentsOf: baseIndentation)
                sheet.append(contentsOf: atRule.rawValue.utf8)
                sheet.append(.ascii.leftBrace)
            }

            for (style, className) in stylesForAtRule {
                // Build selector: [selector] .className[:pseudo]
                var selector = ""
                if let pre = style.selector?.rawValue {
                    selector.append(pre)
                    selector.append(" ")
                }
                selector.append(".")
                selector.append(className)
                if let pseudo = style.pseudo?.rawValue {
                    selector.append(pseudo)
                }

                sheet.append(contentsOf: configuration.newline)
                sheet.append(contentsOf: baseIndentation)
                if atRule != nil {
                    sheet.append(contentsOf: configuration.indentation)
                }
                sheet.append(contentsOf: selector.utf8)
                sheet.append(.ascii.leftBrace)
                sheet.append(contentsOf: style.declaration.utf8)
                if configuration.forceImportant {
                    sheet.append(
                        contentsOf: [.ascii.space] + .html.important
                    )
                }
                sheet.append(.ascii.rightBrace)
            }

            if atRule != nil {
                sheet.append(contentsOf: configuration.newline)
                sheet.append(contentsOf: baseIndentation)
                sheet.append(.ascii.rightBrace)
            }
        }
        return sheet
    }

    /// Generates a CSS stylesheet from the collected styles as bytes.
    ///
    /// Convenience property that calls `stylesheetBytes(baseIndentation:)` with no indentation.
    public var stylesheetBytes: ContiguousArray<UInt8> {
        stylesheetBytes(baseIndentation: [])
    }

    /// Generates a CSS stylesheet from the collected styles.
    ///
    /// Convenience property that converts bytes to String.
    /// Prefer `stylesheetBytes` for performance-critical code.
    public var stylesheet: String {
        String(decoding: stylesheetBytes, as: UTF8.self)
    }
}

extension HTML {
    static let important: [UInt8] = [
        .ascii.exclamationPoint,
        .ascii.i,
        .ascii.m,
        .ascii.p,
        .ascii.o,
        .ascii.r,
        .ascii.t,
        .ascii.a,
        .ascii.n,
        .ascii.t,
    ]
}


// ====================
// Sources/HTML Renderable/HTML.Doctype.swift
// ====================
//
//  HTML.Doctype.swift
//
//
//  Created by Point-Free, Inc
//

import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// Represents the HTML doctype declaration.
    ///
    /// The `HTML.Doctype` struct provides a convenient way to add the HTML5 doctype
    /// declaration to an HTML document. This declaration is required for proper
    /// rendering and standards compliance in web browsers.
    ///
    /// Example:
    /// ```swift
    /// var body: some HTML.View {
    ///     HTML.Doctype()
    ///     html {
    ///         // HTML content...
    ///     }
    /// }
    /// ```
    ///
    /// - Note: In HTML5, the doctype is simplified to `<!doctype html>` compared
    ///   to the more complex doctypes in earlier HTML versions.
    public struct Doctype: HTML.View {
        /// Creates a new doctype declaration.
        public init() {}

        /// The body of the doctype declaration, which renders as raw HTML.
        public var body: some HTML.View {
            HTML.Raw([UInt8].html.tag.doctype)
        }
    }
}


// ====================
// Sources/HTML Renderable/HTML.Document+ViewRepresentable.swift
// ====================
#if canImport(SwiftUI)
#if os(macOS)
import AppKit
#endif
@preconcurrency public import SwiftUI
public import WebKit
public import WHATWG_HTML_Shared

// MARK: - Shared Implementation

private extension HTML.Document where Body: HTML.View, Head: HTML.View {
    @MainActor
    func makeWebView() -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")

        let webView = WKWebView(frame: .zero, configuration: configuration)
        loadHTML(into: webView)
        return webView
    }

    @MainActor
    func loadHTML(into webView: WKWebView) {
        let html = (try? String(self)) ?? """
            <!doctype html>
            <html>
            <body style="font-family: system-ui; color: #c00; padding: 20px;">
            <p>Failed to render HTML document</p>
            </body>
            </html>
            """
        webView.loadHTMLString(html, baseURL: nil)
    }
}

// MARK: - macOS

#if os(macOS)
extension HTML.Document: SwiftUI.View where Body: HTML.View, Head: HTML.View {}

extension HTML.Document: SwiftUI.NSViewRepresentable where Body: HTML.View, Head: HTML.View {
    public typealias NSViewType = WKWebView

    public func makeNSView(context: NSViewRepresentableContext<Self>) -> WKWebView {
        makeWebView()
    }

    public func updateNSView(_ webView: WKWebView, context: NSViewRepresentableContext<Self>) {
        loadHTML(into: webView)
    }
}

// MARK: - iOS

#elseif os(iOS)
extension HTML.Document: SwiftUI.View where Body: HTML.View, Head: HTML.View {}

extension HTML.Document: SwiftUI.UIViewRepresentable where Body: HTML.View, Head: HTML.View {
    public typealias UIViewType = WKWebView

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> WKWebView {
        makeWebView()
    }

    public func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<Self>) {
        loadHTML(into: webView)
    }
}
#endif
#endif


// ====================
// Sources/HTML Renderable/HTML.Document.Protocol.swift
// ====================
//
//  HTML.Document.Protocol.swift
//
//
//  Created by Point-Free, Inc
//

import OrderedCollections
import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// A protocol representing a complete HTML document.
    ///
    /// The `HTML.Document.Protocol` extends `HTML.View` to specifically represent
    /// a complete HTML document with both head and body sections. This allows
    /// for structured creation of full HTML pages with proper doctype, head
    /// metadata, and body content.
    ///
    /// Example:
    /// ```swift
    /// struct MyDocument: HTML.Document.Protocol {
    ///     var head: some HTML.View {
    ///         title { "My Web Page" }
    ///         meta().charset("utf-8")
    ///         meta().name("viewport").content("width=device-width, initial-scale=1")
    ///     }
    ///
    ///     var body: some HTML.View {
    ///         div {
    ///             h1 { "Welcome to My Website" }
    ///             p { "This is a complete HTML document." }
    ///         }
    ///     }
    /// }
    /// ```
    public protocol DocumentProtocol: HTML.View {
        /// The type of HTML content for the document's head section.
        associatedtype Head: HTML.View

        /// The head section of the HTML document.
        ///
        /// This property defines metadata, title, stylesheets, scripts, and other
        /// elements that should appear in the document's head section.
        @HTML.Builder
        var head: Head { get }
    }
}

extension HTML.DocumentProtocol {
    /// Streaming render for HTML documents.
    ///
    /// Documents require two-phase rendering:
    /// 1. Render body to collect styles
    /// 2. Write document structure with collected styles
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: Self,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        let configuration = context.configuration
        let indent = configuration.indentation

        // Phase 1: Render body to collect styles
        // Body content is 2 levels deep: html > body > content
        var bodyBuffer: [UInt8] = []
        var bodyContext = HTML.Context(configuration)
        bodyContext.currentIndentation = indent + indent
        Content._render(html.body, into: &bodyBuffer, context: &bodyContext)

        // Transfer collected styles to main context
        for (key, value) in bodyContext.styles {
            context.styles[key] = value
        }

        // Phase 2: Write document structure directly (more performant than building HTML tree)
        // Match HTML.Element's block-level rendering behavior for consistent output
        let newline = configuration.newline

        // <!doctype html>
        buffer.append(contentsOf: [UInt8].html.tag.doctype)

        // <html> (block element - newline before, indent content)
        buffer.append(contentsOf: newline)
        buffer.append(contentsOf: [UInt8].html.tag.open)

        // <head> (block element inside html - newline + indent before)
        buffer.append(contentsOf: newline)
        buffer.append(contentsOf: indent)
        buffer.append(contentsOf: [UInt8].html.tag.headOpen)

        // Render head content (with increased indentation)
        let oldIndentation = context.currentIndentation
        context.currentIndentation = indent + indent
        Head._render(html.head, into: &buffer, context: &context)

        // Add collected styles if any (as block element inside head)
        // Style content indentation: 3 levels deep (html > head > style content)
        let styleContentIndent = indent + indent + indent
        let stylesheetBytes = bodyContext.stylesheetBytes(baseIndentation: styleContentIndent)
        if !bodyContext.styles.isEmpty {
            // <style> tag as block element: newline + indent before
            buffer.append(contentsOf: newline)
            buffer.append(contentsOf: indent)
            buffer.append(contentsOf: indent)
            buffer.append(contentsOf: [UInt8].html.tag.styleOpen)
            // Stylesheet content (starts with newline, has proper indentation)
            buffer.append(contentsOf: stylesheetBytes)
            // </style> as block element: newline + indent before closing
            buffer.append(contentsOf: newline)
            buffer.append(contentsOf: indent)
            buffer.append(contentsOf: indent)
            buffer.append(contentsOf: [UInt8].html.tag.styleClose)
        }

        // </head> (newline + indent before closing)
        buffer.append(contentsOf: newline)
        buffer.append(contentsOf: indent)
        buffer.append(contentsOf: [UInt8].html.tag.headClose)

        // <body> (block element inside html)
        buffer.append(contentsOf: newline)
        buffer.append(contentsOf: indent)
        buffer.append(contentsOf: [UInt8].html.tag.bodyOpen)

        // Append pre-rendered body bytes (already has proper indentation)
        buffer.append(contentsOf: bodyBuffer)

        // </body> (newline + indent before closing)
        buffer.append(contentsOf: newline)
        buffer.append(contentsOf: indent)
        buffer.append(contentsOf: [UInt8].html.tag.bodyClose)

        // </html> (newline before closing, no indent since it's root)
        buffer.append(contentsOf: newline)
        buffer.append(contentsOf: [UInt8].html.tag.close)

        // Restore indentation
        context.currentIndentation = oldIndentation
    }
}

extension HTML.DocumentProtocol {
    /// Asynchronously render this document to a complete byte array.
    ///
    /// Convenience method that delegates to `[UInt8].html.init(document:configuration:)`.
    ///
    /// - Parameter configuration: Rendering configuration.
    /// - Returns: Complete rendered bytes.
    @inlinable
    public func asyncDocumentBytes(
        configuration: HTML.Context.Configuration? = nil
    ) async -> [UInt8] {
        await [UInt8](self, configuration: configuration)
    }

    /// Asynchronously render this document to a String.
    ///
    /// Convenience method that delegates to `String.init(document:configuration:)`.
    ///
    /// - Parameter configuration: Rendering configuration.
    /// - Returns: Rendered HTML document string.
    @inlinable
    public func asyncDocumentString(
        configuration: HTML.Context.Configuration? = nil
    ) async -> String {
        await String(self, configuration: configuration)
    }
}

// Streaming extensions for HTML.DocumentProtocol are defined in:
// - AsyncStream.swift (asyncStream)
// - AsyncThrowingStream.swift (asyncThrowingStream)


// ====================
// Sources/HTML Renderable/HTML.Document.swift
// ====================
//
//  HTML.Document.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 22/07/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// A complete HTML document with head and body sections.
    ///
    /// `HTML.Document` represents a full HTML page with proper structure including
    /// doctype, html, head, and body elements. Use this type when you need
    /// to render a complete HTML document rather than just a fragment.
    ///
    /// Example:
    /// ```swift
    /// let page = HTML.Document {
    ///     div {
    ///         h1 { "Welcome" }
    ///         p { "Hello, World!" }
    ///     }
    /// } head: {
    ///     title { "My Page" }
    ///     meta().charset("utf-8")
    /// }
    /// ```
    public struct Document<Body: HTML.View, Head: HTML.View>: HTML.DocumentProtocol {
        public let head: Head
        public let body: Body

        /// Creates a new HTML document.
        ///
        /// - Parameters:
        ///   - body: A builder closure that returns the body content.
        ///   - head: A builder closure that returns the head content. Defaults to empty.
        public init(
            @HTML.Builder body: () -> Body,
            @HTML.Builder head: () -> Head = { Empty() }
        ) {
            self.body = body()
            self.head = head()
        }
    }
}

extension HTML.Document {
    /// Creates a new HTML document with head specified first.
    ///
    /// This overload allows specifying head before body for cases where
    /// that ordering reads more naturally.
    ///
    /// - Parameters:
    ///   - head: A builder closure that returns the head content. Defaults to empty.
    ///   - body: A builder closure that returns the body content.
    @_disfavoredOverload
    public init(
        @HTML.Builder head: () -> Head = { Empty() },
        @HTML.Builder body: () -> Body
    ) {
        self.body = body()
        self.head = head()
    }
}

extension HTML.Document: Sendable where Body: Sendable, Head: Sendable {}


// ====================
// Sources/HTML Renderable/HTML.Element.swift
// ====================
//
//  HTML.Element.swift
//
//
//  Created by Point-Free, Inc
//

import INCITS_4_1986
import OrderedCollections
import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

extension HTML.Element {
    /// Represents an HTML element with a tag, attributes, and optional content.
    ///
    /// `HTML.Element.Tag` is a fundamental building block representing a standard HTML element
    /// with a tag name, attributes, and optional child content. This type handles the
    /// rendering of both opening and closing tags, attribute formatting, and proper
    /// indentation based on block vs. inline elements.
    ///
    /// Example using typed initializer:
    /// ```swift
    /// HTML.Element.Tag(for: HTML.Grouping.Div.self) {
    ///     p { "Hello, world!" }
    /// }
    /// ```
    ///
    /// Example using string initializer:
    /// ```swift
    /// HTML.Element.Tag(tag: "div") {
    ///     "Hello, world!"
    /// }
    /// ```
    ///
    /// This type is typically not used directly by library consumers, who would
    /// instead use the more convenient tag functions like `div`, `span`, `p`, etc.
    public struct Tag<Content: HTML.View>: HTML.View {
        /// The HTML tag name for this element.
        public let tagName: String
        
        /// Whether this is a block-level element (for pretty-printing).
        public let isBlock: Bool
        
        /// Whether this is a void element (no closing tag).
        public let isVoid: Bool
        
        /// Whether this is a pre element (preserves whitespace).
        let isPreElement: Bool
        
        /// The optional content contained within this element.
        public let content: Content?
        
        
    }
}

extension HTML.Element.Tag where Content: HTML.View {
    // MARK: - Initializers
    
    /// Creates a new HTML element with a typed tag.
    ///
    /// This initializer captures tag metadata at construction time from the
    /// compile-time type, enabling type-safe element creation while storing
    /// the metadata as values for flexible rendering.
    ///
    /// - Parameters:
    ///   - tagType: The WHATWG HTML element type.
    ///   - content: A closure that returns the content of this element.
    public init<Tag: HTML.Element.`Protocol`>(
        for tagType: Tag.Type,
        @HTML.Builder content: () -> Content? = { Never?.none }
    ) {
        self.tagName = Tag.tag
        self.isBlock = !Tag.categories.contains(.phrasing)
        self.isVoid = Tag.content.model == .nothing
        self.isPreElement = Tag.tag == "pre"
        self.content = content()
    }
    
    /// Creates a new HTML element with a string tag name.
    ///
    /// Uses runtime lookup for tag metadata. Prefer the typed initializer
    /// when the tag is known at compile time.
    ///
    /// - Parameters:
    ///   - tag: The HTML tag name.
    ///   - content: A closure that returns the content of this element.
    public init(
        tag: String,
        @HTML.Builder content: () -> Content? = { Never?.none }
    ) {
        self.tagName = tag
        let categories = HTML.Element.Content.categories(for: tag)
        self.isBlock = !categories.contains(.phrasing)
        self.isVoid = HTML.Element.Content.model(for: tag) == .nothing
        self.isPreElement = tag == "pre"
        self.content = content()
    }
}


extension HTML.Element.Tag {
    /// Renders this HTML element into the provided buffer.
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: Self,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        let isPrettyPrinting = !context.configuration.newline.isEmpty
        let htmlIsBlock = isPrettyPrinting && html.isBlock
        
        // Add newline and indentation for block elements
        if htmlIsBlock {
            buffer.append(contentsOf: context.configuration.newline)
            buffer.append(contentsOf: context.currentIndentation)
        }
        
        // Write opening tag
        buffer.append(.ascii.lessThanSign)
        buffer.append(contentsOf: html.tagName.utf8)
        
        // Add attributes - single-pass escaping without intermediate allocation
        for (name, value) in context.attributes {
            buffer.append(.ascii.space)
            buffer.append(contentsOf: name.utf8)
            if !value.isEmpty {
                buffer.append(.ascii.equalsSign)
                buffer.append(.ascii.dquote)
                
                // Single-pass: iterate directly over UTF-8 view, escape as needed
                for byte in value.utf8 {
                    switch byte {
                    case .ascii.dquote:
                        buffer.append(contentsOf: [UInt8].html.doubleQuotationMark)
                    case .ascii.apostrophe:
                        buffer.append(contentsOf: [UInt8].html.apostrophe)
                    case .ascii.ampersand:
                        buffer.append(contentsOf: [UInt8].html.ampersand)
                    case .ascii.lessThanSign:
                        buffer.append(contentsOf: [UInt8].html.lessThan)
                    case .ascii.greaterThanSign:
                        buffer.append(contentsOf: [UInt8].html.greaterThan)
                    default:
                        buffer.append(byte)
                    }
                }
                
                buffer.append(.ascii.dquote)
            }
        }
        buffer.append(.ascii.greaterThanSign)
        
        // Render content if present
        if let content = html.content {
            let oldAttributes = context.attributes
            let oldIndentation = context.currentIndentation
            defer {
                context.attributes = oldAttributes
                context.currentIndentation = oldIndentation
            }
            context.attributes.removeAll()
            if htmlIsBlock && !html.isPreElement {
                context.currentIndentation += context.configuration.indentation
            }
            Content._render(content, into: &buffer, context: &context)
        }
        
        // Add closing tag unless it's a void element
        if !html.isVoid {
            if htmlIsBlock && !html.isPreElement {
                buffer.append(contentsOf: context.configuration.newline)
                buffer.append(contentsOf: context.currentIndentation)
            }
            buffer.append(.ascii.lessThanSign)
            buffer.append(.ascii.slant)
            buffer.append(contentsOf: html.tagName.utf8)
            buffer.append(.ascii.greaterThanSign)
        }
    }
    
    /// This type uses direct rendering and doesn't have a body.
    public var body: Never {
        fatalError("body should not be called")
    }
}

extension HTML.Element.Tag: Sendable where Content: Sendable {}

// MARK: - Async Rendering

extension HTML.Element.Tag: AsyncRenderable where Content: AsyncRenderable {
    /// Async renders this HTML element with backpressure support.
    ///
    /// This implementation mirrors the sync `_render` but uses async writes
    /// to the stream, allowing suspension at strategic points.
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        let isPrettyPrinting = !context.configuration.newline.isEmpty
        let htmlIsBlock = isPrettyPrinting && html.isBlock
        
        // Build opening tag into local buffer, then write once
        var openTag: [UInt8] = []
        
        if htmlIsBlock {
            openTag.append(contentsOf: context.configuration.newline)
            openTag.append(contentsOf: context.currentIndentation)
        }
        
        openTag.append(.ascii.lessThanSign)
        openTag.append(contentsOf: html.tagName.utf8)
        
        // Add attributes
        for (name, value) in context.attributes {
            openTag.append(.ascii.space)
            openTag.append(contentsOf: name.utf8)
            if !value.isEmpty {
                openTag.append(.ascii.equalsSign)
                openTag.append(.ascii.dquote)
                
                for byte in value.utf8 {
                    switch byte {
                    case .ascii.dquote:
                        openTag.append(contentsOf: [UInt8].html.doubleQuotationMark)
                    case .ascii.apostrophe:
                        openTag.append(contentsOf: [UInt8].html.apostrophe)
                    case .ascii.ampersand:
                        openTag.append(contentsOf: [UInt8].html.ampersand)
                    case .ascii.lessThanSign:
                        openTag.append(contentsOf: [UInt8].html.lessThan)
                    case .ascii.greaterThanSign:
                        openTag.append(contentsOf: [UInt8].html.greaterThan)
                    default:
                        openTag.append(byte)
                    }
                }
                
                openTag.append(.ascii.dquote)
            }
        }
        openTag.append(.ascii.greaterThanSign)
        
        await stream.write(openTag)
        
        // Render content if present
        if let content = html.content {
            let oldAttributes = context.attributes
            let oldIndentation = context.currentIndentation
            defer {
                context.attributes = oldAttributes
                context.currentIndentation = oldIndentation
            }
            context.attributes.removeAll()
            if htmlIsBlock && !html.isPreElement {
                context.currentIndentation += context.configuration.indentation
            }
            await Content._renderAsync(content, into: stream, context: &context)
        }
        
        // Add closing tag unless it's a void element
        if !html.isVoid {
            var closeTag: [UInt8] = []
            if htmlIsBlock && !html.isPreElement {
                closeTag.append(contentsOf: context.configuration.newline)
                closeTag.append(contentsOf: context.currentIndentation)
            }
            closeTag.append(.ascii.lessThanSign)
            closeTag.append(.ascii.slant)
            closeTag.append(contentsOf: html.tagName.utf8)
            closeTag.append(.ascii.greaterThanSign)
            
            await stream.write(closeTag)
        }
    }
}


// ====================
// Sources/HTML Renderable/HTML.Empty.swift
// ====================
//
//  Empty+HTML.swift
//
//
//  Created by Point-Free, Inc
//

public import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

public typealias RenderingEmpty = Empty

/// Represents an empty HTML node that renders nothing.
///
/// `Empty` is a utility type that conforms to the `HTML.View` protocol but
/// renders no content. It's useful in scenarios where you need to provide
/// HTML content but want it to be empty, such as in conditional rendering
/// or as a default placeholder.
///
/// Example:
/// ```swift
/// // Conditionally render content
/// var content: some HTML.View {
///     if shouldShowGreeting {
///         h1 { "Hello, World!" }
///     } else {
///         Empty()
///     }
/// }
/// ```
extension HTML {
    public typealias Empty = RenderingEmpty
}

extension HTML.Empty: @retroactive Renderable {
    public typealias Content = Never
    public typealias Output = UInt8
    public typealias Context = HTML.Context

    public static func _render<Buffer: RangeReplaceableCollection>(
        _ markup: Empty,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        // Produces no output
    }

    public var body: Never { fatalError("body should not be called") }
}

extension HTML.Empty: HTML.View {}

extension HTML.Empty: @retroactive AsyncRenderable {
    /// Async renders nothing (empty content).
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ markup: Empty,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        // Produces no output
    }
}


// ====================
// Sources/HTML Renderable/HTML.Group.swift
// ====================
//
//  Group+HTML.swift
//
//
//  Created by Point-Free, Inc
//

public import Rendering
public import WHATWG_HTML_Shared

public typealias RenderingGroup = Group

/// A container that groups multiple HTML elements together without adding a wrapper element.
///
/// `Group` allows you to group a collection of HTML elements together
/// without introducing an additional HTML element in the rendered output.
/// This is useful for creating reusable components that contain multiple
/// elements but don't need a container element.
///
/// Example:
/// ```swift
/// func navigation() -> some HTML.View {
///     Group {
///         a().href("/home") { "Home" }
///         a().href("/about") { "About" }
///         a().href("/contact") { "Contact" }
///     }
/// }
///
/// var body: some HTML.View {
///     nav {
///         navigation()
///     }
/// }
/// ```
///
/// This would render as:
/// ```html
/// <nav>
///     <a href="/home">Home</a>
///     <a href="/about">About</a>
///     <a href="/contact">Contact</a>
/// </nav>
/// ```

extension HTML {
    public typealias Group = RenderingGroup
}

extension HTML.Group: HTML.View where Content: HTML.View {}


// ====================
// Sources/HTML Renderable/HTML.Pseudo.swift
// ====================
//
//  HTML.Pseudo.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 16/04/2025.
//

import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// Represents CSS pseudo-classes and pseudo-elements for targeting element states and parts.
    ///
    /// `HTML.Pseudo` provides a type-safe way to apply CSS pseudo-classes and pseudo-elements
    /// in HTML_Renderable. Pseudo-classes target elements in specific states (like `:hover`,
    /// `:focus`, `:disabled`), while pseudo-elements target specific parts of elements
    /// (like `::before`, `::after`, `::first-line`).
    ///
    /// ## Basic Usage
    ///
    /// ```swift
    /// // Most common: using string literals
    /// button { "Click me" }
    ///     .inlineStyle("background-color", "blue")
    ///     .inlineStyle("background-color", "red", pseudo: ":hover")
    ///
    /// // Using static properties (equivalent)
    /// let hover: HTML.Pseudo = .hover
    /// button { "Click me" }
    ///     .inlineStyle("background-color", "red", pseudo: .hover)
    ///
    /// // Pseudo-element for generated content
    /// div { "Content" }
    ///     .inlineStyle("content", "\"★\"", pseudo: "::before")
    /// ```
    ///
    /// ## Pseudo-Classes vs Pseudo-Elements
    ///
    /// **Pseudo-classes** (single colon `:`) target elements based on their state:
    /// - `:hover` - when user hovers over element
    /// - `:focus` - when element has keyboard focus
    /// - `:disabled` - when form element is disabled
    /// - `:first-child` - first child element
    ///
    /// **Pseudo-elements** (double colon `::`) target parts of elements:
    /// - `::before` - generated content before element
    /// - `::after` - generated content after element
    /// - `::first-line` - first line of text content
    ///
    /// ## Combining Pseudo-Selectors
    ///
    /// Use the `+` operator to combine multiple pseudo-selectors:
    ///
    /// ```swift
    /// // Using string literals (most common)
    /// let combined: HTML.Pseudo = ":not(:disabled):hover"
    ///
    /// // Or combining static properties
    /// let notDisabled: HTML.Pseudo = .not(.disabled)
    /// let combined: HTML.Pseudo = notDisabled + .hover
    ///
    /// input { "" }
    ///     .inlineStyle("border-color", "blue", pseudo: .init(rawValue: ":not(:disabled):hover"))
    /// // Generates: input:not(:disabled):hover { border-color: blue; }
    /// ```
    ///
    /// ## Functional Pseudo-Classes
    ///
    /// Some pseudo-classes accept parameters:
    ///
    /// ```swift
    /// // Using string literals (most common)
    /// li { "Item" }
    ///     .inlineStyle("color", "red", pseudo: ":nth-child(odd)")
    ///     .inlineStyle("color", "blue", pseudo: ":nth-child(2n+1)")
    ///
    /// // Using static functions (equivalent)
    /// let oddChild: HTML.Pseudo = .nthChild("odd")
    /// li { "Item" }
    ///     .inlineStyle("color", "red", pseudo: .nthChild("odd"))
    ///
    /// // Negation pseudo-class
    /// button { "Button" }
    ///     .inlineStyle("opacity", "0.5", pseudo: ":not(:enabled)")
    /// ```
    public struct Pseudo: RawRepresentable, Hashable, Sendable, ExpressibleByStringLiteral,
        ExpressibleByStringInterpolation {
        /// The CSS pseudo-class or pseudo-element selector.
        public var rawValue: String

        /// Creates a pseudo-selector with the specified CSS selector string.
        ///
        /// - Parameter rawValue: The CSS pseudo-selector string (e.g., ":hover", "::before").
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Creates a pseudo-selector from a string literal.
        ///
        /// This allows you to write:
        /// ```swift
        /// let custom: Pseudo = ":custom-state"
        /// ```
        ///
        /// - Parameter value: The CSS pseudo-selector string.
        public init(stringLiteral value: String) {
            self.init(rawValue: value)
        }
    }
}

// MARK: - Pseudo-Selector Combination
extension HTML.Pseudo {
    /// Combines two pseudo-selectors into a single compound pseudo-selector.
    ///
    /// This operator allows you to chain multiple pseudo-classes or pseudo-elements
    /// together. This is useful for creating complex state-based selectors.
    ///
    /// ```swift
    /// // Using string literals (most common)
    /// let focusedEnabled: Pseudo = ":not(:disabled):focus"
    ///
    /// // Or combining static properties
    /// let focusedEnabled: Pseudo = .not(.disabled) + .focus
    ///
    /// input { "" }
    ///     .inlineStyle("border-color", "blue", pseudo: .init(rawValue: ":not(:disabled):focus"))
    /// // Generates: input:not(:disabled):focus { border-color: blue; }
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The first pseudo-selector.
    ///   - rhs: The second pseudo-selector to combine.
    /// - Returns: A new pseudo-selector representing the combination.
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(rawValue: lhs.rawValue + rhs.rawValue)
    }
}

// MARK: - Pseudo-Elements
extension HTML.Pseudo {
    /// Pseudo-elements target specific parts of elements and create virtual elements.
    /// They use double colon (::) syntax and are used for styling generated content
    /// or specific portions of element content.

    /// `::after` pseudo-element creates a virtual element after the element's content.
    ///
    /// Used with the `content` CSS property to insert generated content.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// div { "Text" }
    ///     .inlineStyle("content", "\" (suffix)\"", pseudo: "::after")
    ///
    /// // Using static property (equivalent)
    /// let after: Pseudo = .after
    /// div { "Text" }
    ///     .inlineStyle("content", "\" (suffix)\"", pseudo: .after)
    /// ```
    public static let after: Self = "::after"

    /// `::before` pseudo-element creates a virtual element before the element's content.
    ///
    /// Used with the `content` CSS property to insert generated content.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// div { "Text" }
    ///     .inlineStyle("content", "\"★ \"", pseudo: "::before")
    ///
    /// // Using static property (equivalent)
    /// let before: Pseudo = .before
    /// div { "Text" }
    ///     .inlineStyle("content", "\"★ \"", pseudo: .before)
    /// ```
    public static let before: Self = "::before"

    /// `::first-line` pseudo-element targets the first line of text in a block element.
    ///
    /// Useful for styling drop caps or emphasizing opening lines.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// p { "Long paragraph text..." }
    ///     .inlineStyle("font-weight", "bold", pseudo: "::first-line")
    ///
    /// // Using static property (equivalent)
    /// let firstLine: Pseudo = .firstLine
    /// p { "Long paragraph text..." }
    ///     .inlineStyle("font-weight", "bold", pseudo: .firstLine)
    /// ```
    public static let firstLine: Self = "::first-line"
}

// MARK: - Pseudo-Classes
// Pseudo-classes target elements based on their state or position.
// They use single colon (:) syntax and are applied when elements
// meet specific conditions or are in particular states.
extension HTML.Pseudo {

    // MARK: Interactive States

    /// `:active` targets elements during activation (e.g., mouse click).
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// button { "Click me" }
    ///     .inlineStyle("background-color", "darkblue", pseudo: ":active")
    ///
    /// // Using static property (equivalent)
    /// let active: Pseudo = .active
    /// button { "Click me" }
    ///     .inlineStyle("background-color", "darkblue", pseudo: .active)
    /// ```
    public static let active: Self = ":active"

    /// `:hover` targets elements when the user hovers over them.
    ///
    /// ```swift
    /// a { "Link" }
    ///     .inlineStyle("color", "red", pseudo: ":hover")
    /// ```
    public static let hover: Self = ":hover"

    /// `:focus` targets elements that have keyboard focus.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("border-color", "blue", pseudo: ":focus")
    /// ```
    public static let focus: Self = ":focus"

    /// `:visited` targets visited links.
    ///
    /// ```swift
    /// a { "Link" }
    ///     .inlineStyle("color", "purple", pseudo: ":visited")
    /// ```
    public static let visited: Self = ":visited"

    /// `:link` targets unvisited links.
    ///
    /// ```swift
    /// a { "Link" }
    ///     .inlineStyle("color", "blue", pseudo: ":link")
    /// ```
    public static let link: Self = ":link"

    // MARK: Form States

    /// `:checked` targets checked form elements (checkboxes, radio buttons).
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("accent-color", "green", pseudo: ":checked")
    /// ```
    public static let checked: Self = ":checked"

    /// `:disabled` targets disabled form elements.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("opacity", "0.5", pseudo: ":disabled")
    /// ```
    public static let disabled: Self = ":disabled"

    /// `:enabled` targets enabled form elements.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("border-color", "black", pseudo: ":enabled")
    /// ```
    public static let enabled: Self = ":enabled"

    /// `:required` targets form elements with the required attribute.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("border-color", "red", pseudo: ":required")
    /// ```
    public static let required: Self = ":required"

    /// `:optional` targets form elements without the required attribute.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("border-color", "gray", pseudo: ":optional")
    /// ```
    public static let optional: Self = ":optional"

    /// `:valid` targets form elements with valid values.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("border-color", "green", pseudo: ":valid")
    /// ```
    public static let valid: Self = ":valid"

    /// `:invalid` targets form elements with invalid values.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("border-color", "red", pseudo: ":invalid")
    /// ```
    public static let invalid: Self = ":invalid"

    /// `:in-range` targets input elements whose values are within specified range.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("border-color", "green", pseudo: ":in-range")
    /// ```
    public static let inRange: Self = ":in-range"

    /// `:out-of-range` targets input elements whose values are outside specified range.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("border-color", "red", pseudo: ":out-of-range")
    /// ```
    public static let outOfRange: Self = ":out-of-range"

    /// `:read-only` targets read-only form elements.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("background-color", "lightgray", pseudo: ":read-only")
    /// ```
    public static let readOnly: Self = ":read-only"

    /// `:read-write` targets editable form elements.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("background-color", "white", pseudo: ":read-write")
    /// ```
    public static let readWrite: Self = ":read-write"

    /// `:placeholder-shown` targets input elements displaying placeholder text.
    ///
    /// ```swift
    /// input { "" }
    ///     .inlineStyle("border-color", "gray", pseudo: ":placeholder-shown")
    /// ```
    public static let placeholderShown: Self = ":placeholder-shown"

    // MARK: Structural Pseudo-Classes

    /// `:first-child` targets the first child element.
    ///
    /// ```swift
    /// li { "First item" }
    ///     .inlineStyle("font-weight", "bold", pseudo: ":first-child")
    /// ```
    public static let firstChild: Self = ":first-child"

    /// `:last-child` targets the last child element.
    ///
    /// ```swift
    /// li { "Last item" }
    ///     .inlineStyle("margin-bottom", "0", pseudo: ":last-child")
    /// ```
    public static let lastChild: Self = ":last-child"

    /// `:only-child` targets elements that are the only child of their parent.
    ///
    /// ```swift
    /// p { "Only paragraph" }
    ///     .inlineStyle("text-align", "center", pseudo: ":only-child")
    /// ```
    public static let onlyChild: Self = ":only-child"

    /// `:first-of-type` targets the first element of its type among siblings.
    ///
    /// ```swift
    /// h2 { "First heading" }
    ///     .inlineStyle("margin-top", "0", pseudo: ":first-of-type")
    /// ```
    public static let firstOfType: Self = ":first-of-type"

    /// `:last-of-type` targets the last element of its type among siblings.
    ///
    /// ```swift
    /// p { "Last paragraph" }
    ///     .inlineStyle("margin-bottom", "0", pseudo: ":last-of-type")
    /// ```
    public static let lastOfType: Self = ":last-of-type"

    /// `:only-of-type` targets elements that are the only one of their type among siblings.
    ///
    /// ```swift
    /// img { }
    ///     .inlineStyle("display", "block", pseudo: ":only-of-type")
    /// ```
    public static let onlyOfType: Self = ":only-of-type"

    // MARK: Content States

    /// `:empty` targets elements with no children or text content.
    ///
    /// ```swift
    /// div { "" }
    ///     .inlineStyle("display", "none", pseudo: ":empty")
    /// ```
    public static let empty: Self = ":empty"

    /// `:root` targets the root element of the document (usually `<html>`).
    ///
    /// ```swift
    /// // Apply to document root
    /// let rootStyle = inlineStyle("font-size", "16px", pseudo: ":root")
    /// ```
    public static let root: Self = ":root"

    /// `:target` targets elements that are the target of a fragment identifier.
    ///
    /// ```swift
    /// section { "Content" }
    ///     .inlineStyle("background-color", "yellow", pseudo: ":target")
    /// ```
    public static let target: Self = ":target"

    // MARK: Language

    /// `:lang` base for language pseudo-class (needs parameter).
    ///
    /// Use with specific language codes in custom implementations.
    /// For parameterized version, create custom pseudo-selector.
    public static let lang: Self = ":lang"

    // MARK: Functional Pseudo-Classes

    /// `:nth-child()` targets elements based on their position among siblings.
    ///
    /// Accepts various patterns:
    /// - Numbers: `1`, `2`, `3`
    /// - Keywords: `odd`, `even`
    /// - Formulas: `2n+1`, `3n`, `-n+3`
    ///
    /// ```swift
    /// // Using string literals (most common)
    /// tr { }
    ///     .inlineStyle("background-color", "lightgray", pseudo: ":nth-child(even)")
    ///     .inlineStyle("background-color", "white", pseudo: ":nth-child(odd)")
    ///
    /// // Using static function (equivalent)
    /// let evenChild: Pseudo = .nthChild("even")
    /// tr { }
    ///     .inlineStyle("background-color", "lightgray", pseudo: .nthChild("even"))
    /// ```
    ///
    /// - Parameter n: The nth-child pattern (number, keyword, or formula).
    /// - Returns: A pseudo-selector for the nth child.
    public static func nthChild(_ n: any CustomStringConvertible) -> Self {
        ":nth-child(\(n))"
    }

    /// `:nth-last-child()` targets elements based on their position from the end.
    ///
    /// ```swift
    /// li { "Item" }
    ///     .inlineStyle("color", "red", pseudo: ":nth-last-child(2)")
    /// ```
    ///
    /// - Parameter n: The nth-last-child pattern.
    /// - Returns: A pseudo-selector for the nth child from the end.
    public static func nthLastChild(_ n: any CustomStringConvertible) -> Self {
        ":nth-last-child(\(n))"
    }

    /// `:nth-of-type()` targets elements based on their position among siblings of the same type.
    ///
    /// ```swift
    /// h2 { "Heading" }
    ///     .inlineStyle("color", "blue", pseudo: ":nth-of-type(2)")
    /// ```
    ///
    /// - Parameter n: The nth-of-type pattern.
    /// - Returns: A pseudo-selector for the nth element of its type.
    public static func nthOfType(_ n: any CustomStringConvertible) -> Self {
        ":nth-of-type(\(n))"
    }

    /// `:nth-last-of-type()` targets elements based on their position from the end among same type.
    ///
    /// ```swift
    /// p { "Paragraph" }
    ///     .inlineStyle("margin-bottom", "0", pseudo: ":nth-last-of-type(1)")
    /// ```
    ///
    /// - Parameter n: The nth-last-of-type pattern.
    /// - Returns: A pseudo-selector for the nth element of its type from the end.
    public static func nthLastOfType(_ n: any CustomStringConvertible) -> Self {
        ":nth-last-of-type(\(n))"
    }

    /// `:is()` matches elements that match any of the provided selectors.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// let headings: Pseudo = ":is(h1, h2, h3)"
    ///
    /// // Using static function (equivalent)
    /// let headings: Pseudo = .is("h1, h2, h3")
    /// ```
    ///
    /// - Parameter s: A selector list or compound selector.
    /// - Returns: A pseudo-selector that matches any of the provided selectors.
    public static func `is`(_ s: any CustomStringConvertible) -> Self {
        ":is(\(s))"
    }

    /// `:not()` matches elements that do NOT match the provided selector.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// input { "" }
    ///     .inlineStyle("background-color", "white", pseudo: ":not(:disabled)")
    ///
    /// // Using static function (equivalent)
    /// let notDisabled: Pseudo = .not(.disabled)
    /// input { "" }
    ///     .inlineStyle("background-color", "white", pseudo: .not(.disabled))
    /// ```
    ///
    /// - Parameter other: The pseudo-selector to negate.
    /// - Returns: A pseudo-selector that matches elements not matching the input.
    public static func not(_ other: Self) -> Self {
        ":not(\(other.rawValue))"
    }
}


// ====================
// Sources/HTML Renderable/HTML.Raw.swift
// ====================
//
//  HTML.Raw.swift
//
//
//  Created by Point-Free, Inc
//

public import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

// Public typealias to disambiguate between the Rendering module and Rendering protocol
// when accessing the Raw type from the Rendering module.
public typealias RenderingRaw = Raw

extension HTML {
    /// Represents raw, unescaped HTML content.
    ///
    /// `HTML.Raw` allows you to insert raw HTML content without any escaping or processing.
    /// This is useful when you need to include pre-generated HTML or for special cases
    /// where you need to bypass the normal HTML generation mechanism.
    ///
    /// Example:
    /// ```swift
    /// var body: some HTML.View {
    ///     div {
    ///         // Normal, escaped content
    ///         p { "Regular <p> content will be escaped" }
    ///
    ///         // Raw, unescaped content
    ///         HTML.Raw("<script>console.log('This is raw JS');</script>")
    ///     }
    /// }
    /// ```
    ///
    /// - Warning: Using `HTML.Raw` with user-provided content can lead to security
    ///   vulnerabilities such as cross-site scripting (XSS) attacks. Only use
    ///   `HTML.Raw` with trusted content that you have full control over.
    ///
    /// Note: This is a typealias to the `Raw` type from the Rendering module.
    /// The same `Raw` type can be used for HTML, SVG, XML, or any other rendering context.
    public typealias Raw = RenderingRaw
}

// Give Raw (from Rendering module) the HTML.View conformance
extension Raw: @retroactive Renderable {
    public typealias Content = Never
    public typealias Context = HTML.Context
    public typealias Output = UInt8

    /// Renders the raw bytes directly to the buffer without any processing.
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ raw: Self,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        buffer.append(contentsOf: raw.bytes)
    }

    /// This type uses direct rendering and doesn't have a body.
    public var body: Never { fatalError("body should not be called") }
}

extension Raw: HTML.View {}

extension Raw: @retroactive AsyncRenderable {
    /// Async renders the raw bytes directly to the stream.
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ raw: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        await stream.write(raw.bytes)
    }
}


// ====================
// Sources/HTML Renderable/HTML.Selector.swift
// ====================
//
//  HTML.Selector.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 16/04/2025.
//

import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// Represents a CSS selector for targeting HTML elements.
    ///
    /// `HTML.Selector` provides a type-safe way to construct CSS selectors using Swift syntax.
    /// It supports all CSS selector types including element selectors, class selectors,
    /// ID selectors, attribute selectors, and complex combinators.
    ///
    /// ## Basic Usage
    ///
    /// ```swift
    /// // Element selector
    /// let div: HTML.Selector = "div"
    ///
    /// // Class selector
    /// let header: HTML.Selector = .class("header")
    ///
    /// // ID selector
    /// let main: HTML.Selector = .id("main")
    ///
    /// // Using with inline styles
    /// tag("div") { "Content" }
    ///     .inlineStyle("color", "red", selector: .init(rawValue: "div"))
    /// ```
    ///
    /// ## Combinators
    ///
    /// CSS combinators allow you to select elements based on their relationship:
    ///
    /// ```swift
    /// let div: HTML.Selector = "div"
    /// let p: HTML.Selector = "p"
    ///
    /// // Child combinator: div > p
    /// let childSelector = p.child(of: div)
    ///
    /// // Descendant combinator: div p
    /// let descendantSelector = p.descendant(of: div)
    ///
    /// // Next sibling combinator: div + p
    /// let nextSiblingSelector = p.nextSibling(of: div)
    ///
    /// // Subsequent sibling combinator: div ~ p
    /// let subsequentSiblingSelector = p.subsequentSibling(of: div)
    /// ```
    ///
    /// ## Attribute Selectors
    ///
    /// Target elements based on their attributes:
    ///
    /// ```swift
    /// // Element with attribute: [disabled]
    /// let disabled: HTML.Selector = .hasAttribute("disabled")
    ///
    /// // Attribute equals: [type="submit"]
    /// let submitButton: HTML.Selector = .attribute("type", equals: "submit")
    ///
    /// // Attribute starts with: [href^="https"]
    /// let httpsLinks: HTML.Selector = .attribute("href", startsWith: "https")
    /// ```
    ///
    /// ## Selector Lists and Compound Selectors
    ///
    /// ```swift
    /// // Selector list (OR): h1, h2, h3
    /// let headings: HTML.Selector = ("h1" as HTML.Selector).or("h2", "h3")
    ///
    /// // Compound selector (AND): div.header#main
    /// let specificDiv: HTML.Selector = ("div" as HTML.Selector).and(.class("header")).and(.id("main"))
    ///
    /// // Using convenience methods
    /// let navHeader: HTML.Selector = ("div" as HTML.Selector).withClass("nav").withId("header")
    /// ```
    public struct Selector: RawRepresentable, Hashable, Sendable, ExpressibleByStringLiteral,
        ExpressibleByStringInterpolation {
        /// The raw CSS selector string.
        public var rawValue: String

        /// Creates a selector with the specified CSS selector string.
        ///
        /// - Parameter rawValue: The CSS selector string (e.g., "div", ".class", "#id").
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Creates a selector from a string literal.
        ///
        /// This allows you to write:
        /// ```swift
        /// let div: Selector = "div"
        /// ```
        ///
        /// - Parameter value: The CSS selector string.
        public init(stringLiteral value: String) {
            self.init(rawValue: value)
        }
    }
}

// MARK: - CSS Combinators
extension HTML.Selector {

    /// Creates a descendant combinator selector.
    ///
    /// The descendant combinator selects all elements that are descendants of a specified element.
    /// It matches any element that is contained within another element, regardless of nesting depth.
    ///
    /// ```swift
    /// let div: Selector = "div"
    /// let span: Selector = "span"
    /// let selector = span.descendant(of: div)  // "div span"
    /// ```
    ///
    /// This generates the CSS selector `div span`, which matches all `<span>` elements
    /// that are descendants of `<div>` elements.
    ///
    /// - Parameter other: The ancestor selector.
    /// - Returns: A new selector representing the descendant relationship.
    public func descendant(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " " + self.rawValue)
    }

    /// Creates a child combinator selector.
    ///
    /// The child combinator selects all elements that are direct children of a specified element.
    /// Unlike the descendant combinator, this only matches immediate children, not deeper descendants.
    ///
    /// ```swift
    /// let ul: HTML.Selector = "ul"
    /// let li: HTML.Selector = "li"
    /// let selector = li.child(of: ul)  // "ul > li"
    /// ```
    ///
    /// This generates the CSS selector `ul > li`, which matches only `<li>` elements
    /// that are direct children of `<ul>` elements.
    ///
    /// - Parameter other: The parent selector.
    /// - Returns: A new selector representing the child relationship.
    public func child(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " > " + self.rawValue)
    }

    /// Creates a next-sibling combinator selector.
    ///
    /// The next-sibling combinator selects the first element that immediately follows
    /// another element, and both elements share the same parent.
    ///
    /// ```swift
    /// let h1: HTML.Selector = "h1"
    /// let p: HTML.Selector = "p"
    /// let selector = p.nextSibling(of: h1)  // "h1 + p"
    /// ```
    ///
    /// This generates the CSS selector `h1 + p`, which matches `<p>` elements
    /// that immediately follow `<h1>` elements.
    ///
    /// - Parameter other: The preceding sibling selector.
    /// - Returns: A new selector representing the next-sibling relationship.
    public func nextSibling(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " + " + self.rawValue)
    }

    /// Creates a next-sibling combinator selector (alias for `nextSibling`).
    ///
    /// This is an alias for `nextSibling(of:)` for those familiar with the
    /// "adjacent sibling" terminology.
    ///
    /// - Parameter other: The preceding sibling selector.
    /// - Returns: A new selector representing the next-sibling relationship.
    public func adjacent(to other: HTML.Selector) -> HTML.Selector {
        nextSibling(of: other)
    }

    /// Creates a subsequent-sibling combinator selector.
    ///
    /// The subsequent-sibling combinator selects all elements that follow
    /// another element (not necessarily immediately), and both elements share the same parent.
    ///
    /// ```swift
    /// let h1: HTML.Selector = "h1"
    /// let p: HTML.Selector = "p"
    /// let selector = p.subsequentSibling(of: h1)  // "h1 ~ p"
    /// ```
    ///
    /// This generates the CSS selector `h1 ~ p`, which matches all `<p>` elements
    /// that follow `<h1>` elements as siblings.
    ///
    /// - Parameter other: The preceding sibling selector.
    /// - Returns: A new selector representing the subsequent-sibling relationship.
    public func subsequentSibling(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " ~ " + self.rawValue)
    }

    /// Creates a subsequent-sibling combinator selector (alias for `subsequentSibling`).
    ///
    /// This is an alias for `subsequentSibling(of:)` for those familiar with the
    /// "general sibling" terminology.
    ///
    /// - Parameter other: The preceding sibling selector.
    /// - Returns: A new selector representing the subsequent-sibling relationship.
    public func sibling(of other: HTML.Selector) -> HTML.Selector {
        subsequentSibling(of: other)
    }

    /// Creates a column combinator selector.
    ///
    /// The column combinator selects elements that belong to a column in a table.
    /// This is a newer CSS feature primarily used with CSS Grid and table layouts.
    ///
    /// ```swift
    /// let col: HTML.Selector = "col"
    /// let td: HTML.Selector = "td"
    /// let selector = td.column(of: col)  // "col || td"
    /// ```
    ///
    /// This generates the CSS selector `col || td`, which matches `<td>` elements
    /// that belong to the column defined by the `<col>` element.
    ///
    /// - Parameter other: The column selector.
    /// - Returns: A new selector representing the column relationship.
    public func column(of other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: other.rawValue + " || " + self.rawValue)
    }
}

// MARK: - Selector Lists and Compound Selectors
extension HTML.Selector {
    /// Creates a selector list (comma-separated selectors).
    ///
    /// Selector lists allow you to apply styles to multiple different selectors.
    /// This is equivalent to the CSS comma operator for grouping selectors.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// h1 { "Heading" }
    ///     .inlineStyle("font-weight", "bold", selector: "h1, h2")
    ///
    /// // Using method (equivalent)
    /// let h1: Selector = "h1"
    /// let h2: Selector = "h2"
    /// let headings: Selector = h1.or(h2)  // "h1, h2"
    /// ```
    ///
    /// This generates the CSS selector `h1, h2`, which matches both `<h1>` and `<h2>` elements.
    ///
    /// - Parameter other: The additional selector to include in the list.
    /// - Returns: A new selector representing the selector list.
    public func or(_ other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: self.rawValue + ", " + other.rawValue)
    }

    /// Creates a selector list with multiple selectors.
    ///
    /// This is a variadic version of `or(_:)` that allows you to combine
    /// multiple selectors into a single selector list.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// h1 { "Heading" }
    ///     .inlineStyle("color", "blue", selector: "h1, h2, h3")
    ///
    /// // Using method (equivalent)
    /// let h1: HTML.Selector = "h1"
    /// let h2: HTML.Selector = "h2"
    /// let h3: HTML.Selector = "h3"
    /// let headings: HTML.Selector = h1.or(h2, h3)  // "h1, h2, h3"
    /// ```
    ///
    /// - Parameter others: Additional selectors to include in the list.
    /// - Returns: A new selector representing the combined selector list.
    public func or(_ others: HTML.Selector...) -> HTML.Selector {
        let allSelectors = [self] + others
        return .init(rawValue: allSelectors.map(\.rawValue).joined(separator: ", "))
    }

    /// Creates a compound selector by combining this selector with another.
    ///
    /// Compound selectors combine multiple simple selectors without any combinator,
    /// meaning all conditions must match the same element.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// div { "Content" }
    ///     .inlineStyle("background", "gray", selector: "div.header")
    ///
    /// // Using method (equivalent)
    /// let div: HTML.Selector = "div"
    /// let headerClass: HTML.Selector = .class("header")
    /// let compound: HTML.Selector = div.and(headerClass)  // "div.header"
    /// ```
    ///
    /// This generates the CSS selector `div.header`, which matches `<div>` elements
    /// that also have the class "header".
    ///
    /// - Parameter other: The selector to combine with this one.
    /// - Returns: A new compound selector.
    public func and(_ other: HTML.Selector) -> HTML.Selector {
        .init(rawValue: self.rawValue + other.rawValue)
    }
}

// MARK: - Convenience Methods
extension HTML.Selector {
    /// Adds a CSS class to this selector.
    ///
    /// This is a convenience method for creating compound selectors with classes.
    /// It's equivalent to using `and(Selector.class(className))`.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// div { "Content" }
    ///     .inlineStyle("background", "blue", selector: "div.navigation")
    ///
    /// // Using method (equivalent)
    /// let div: Selector = "div"
    /// let navDiv: Selector = div.withClass("navigation")  // "div.navigation"
    /// ```
    ///
    /// - Parameter className: The CSS class name to add.
    /// - Returns: A new selector with the class added.
    public func withClass(_ className: String) -> HTML.Selector {
        self.and(.class(className))
    }

    /// Adds a CSS ID to this selector.
    ///
    /// This is a convenience method for creating compound selectors with IDs.
    /// It's equivalent to using `and(HTML.Selector.id(idName))`.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// div { "Content" }
    ///     .inlineStyle("width", "100%", selector: "div#main")
    ///
    /// // Using method (equivalent)
    /// let div: HTML.Selector = "div"
    /// let mainDiv: HTML.Selector = div.withId("main")  // "div#main"
    /// ```
    ///
    /// - Parameter idName: The CSS ID to add.
    /// - Returns: A new selector with the ID added.
    public func withId(_ idName: String) -> HTML.Selector {
        self.and(.id(idName))
    }

    /// Adds an attribute selector to this selector.
    ///
    /// This is a convenience method for creating compound selectors with attribute conditions.
    /// It's equivalent to using `and(HTML.Selector.attribute(name, equals: value))`.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// input { "" }
    ///     .inlineStyle("background", "green", selector: "input[type=\"submit\"]")
    ///
    /// // Using method (equivalent)
    /// let input: HTML.Selector = "input"
    /// let submitButton: HTML.Selector = input.withAttribute("type", equals: "submit")  // "input[type=\"submit\"]"
    /// ```
    ///
    /// - Parameters:
    ///   - name: The attribute name.
    ///   - value: The required attribute value.
    /// - Returns: A new selector with the attribute condition added.
    public func withAttribute(_ name: String, equals value: String) -> HTML.Selector {
        self.and(.attribute(name, equals: value))
    }

    /// Adds a pseudo-class or pseudo-element to this selector.
    ///
    /// This method appends a pseudo-class or pseudo-element to the selector.
    /// Unlike other `with` methods, this doesn't use `and()` because pseudo-classes
    /// and pseudo-elements are part of the same selector, not compound selectors.
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// button { "Click me" }
    ///     .inlineStyle("background", "red", selector: "button:hover")
    ///
    /// // Using method (equivalent)
    /// let button: HTML.Selector = "button"
    /// let hoverButton: HTML.Selector = button.withPseudo(.hover)  // "button:hover"
    /// ```
    ///
    /// - Parameter pseudo: The pseudo-class or pseudo-element to add.
    /// - Returns: A new selector with the pseudo added.
    public func withPseudo(_ pseudo: HTML.Pseudo) -> HTML.Selector {
        .init(rawValue: self.rawValue + pseudo.rawValue)
    }
}

// MARK: - Universal and Namespace Selectors
extension HTML.Selector {
    /// Universal selector: `*`
    public static let universal: Self = "*"

    /// Namespace separator for XML namespaces: `namespace|element`
    /// Note: This is different from the selector list operator |
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// let svgCircle: HTML.Selector = "svg|circle"
    ///
    /// // Using method (equivalent)
    /// let circle: HTML.Selector = "circle"
    /// let result: HTML.Selector = circle.namespace("svg")  // "svg|circle"
    /// ```
    public func namespace(_ ns: String) -> HTML.Selector {
        .init(rawValue: "\(ns)|\(self.rawValue)")
    }

    /// Create a namespaced selector: `ns|element`
    ///
    /// ```swift
    /// // Using string literal (most common)
    /// let svgCircle: HTML.Selector = "svg|circle"
    ///
    /// // Using static method (equivalent)
    /// let circle: HTML.Selector = "circle"
    /// let result: HTML.Selector = .namespace("svg", element: circle)  // "svg|circle"
    /// ```
    public static func namespace(_ ns: String, element: HTML.Selector) -> HTML.Selector {
        element.namespace(ns)
    }
}

// MARK: - Attribute Selectors
extension HTML.Selector {
    /// Attribute exists: `[attr]`
    public static func hasAttribute(_ name: String) -> Self {
        "[\(name)]"
    }

    /// Attribute equals: `[attr="value"]`
    public static func attribute(_ name: String, equals value: String) -> Self {
        "[\(name)=\"\(value)\"]"
    }

    /// Attribute contains word: `[attr~="value"]`
    public static func attribute(_ name: String, containsWord value: String) -> Self {
        "[\(name)~=\"\(value)\"]"
    }

    /// Attribute starts with: `[attr^="value"]`
    public static func attribute(_ name: String, startsWith value: String) -> Self {
        "[\(name)^=\"\(value)\"]"
    }

    /// Attribute ends with: `[attr$="value"]`
    public static func attribute(_ name: String, endsWith value: String) -> Self {
        "[\(name)$=\"\(value)\"]"
    }

    /// Attribute contains substring: `[attr*="value"]`
    public static func attribute(_ name: String, contains value: String) -> Self {
        "[\(name)*=\"\(value)\"]"
    }

    /// Attribute starts with or followed by hyphen: `[attr|="value"]`
    public static func attribute(_ name: String, startsWithOrHyphen value: String) -> Self {
        "[\(name)|=\"\(value)\"]"
    }
}

// MARK: - Class and ID Selectors
extension HTML.Selector {
    /// Class selector: `.class-name`
    public static func `class`(_ name: String) -> Self {
        ".\(name)"
    }

    /// ID selector: `#id-name`
    public static func id(_ name: String) -> Self {
        "#\(name)"
    }
}

// MARK: - Form Input Types
extension HTML.Selector {
    /// Input type selector: `input[type="text"]`
    public static func inputType(_ type: String) -> Self {
        "input[type=\"\(type)\"]"
    }

    // Common input types
    public static let inputText: Self = "input[type=\"text\"]"
    public static let inputPassword: Self = "input[type=\"password\"]"
    public static let inputEmail: Self = "input[type=\"email\"]"
    public static let inputNumber: Self = "input[type=\"number\"]"
    public static let inputTel: Self = "input[type=\"tel\"]"
    public static let inputUrl: Self = "input[type=\"url\"]"
    public static let inputSearch: Self = "input[type=\"search\"]"
    public static let inputDate: Self = "input[type=\"date\"]"
    public static let inputTime: Self = "input[type=\"time\"]"
    public static let inputDatetime: Self = "input[type=\"datetime-local\"]"
    public static let inputMonth: Self = "input[type=\"month\"]"
    public static let inputWeek: Self = "input[type=\"week\"]"
    public static let inputColor: Self = "input[type=\"color\"]"
    public static let inputRange: Self = "input[type=\"range\"]"
    public static let inputFile: Self = "input[type=\"file\"]"
    public static let inputCheckbox: Self = "input[type=\"checkbox\"]"
    public static let inputRadio: Self = "input[type=\"radio\"]"
    public static let inputSubmit: Self = "input[type=\"submit\"]"
    public static let inputReset: Self = "input[type=\"reset\"]"
    public static let inputButton: Self = "input[type=\"button\"]"
    public static let inputHidden: Self = "input[type=\"hidden\"]"
}


// ====================
// Sources/HTML Renderable/HTML.Style.Context.swift
// ====================
//
//  HTML.Element.Style.Context.swift
//  swift-html-rendering
//
//  TaskLocal-based context for CSS styling.
//

public import WHATWG_HTML_Shared

extension HTML.Element.Style {
    /// Context for CSS styling that captures at-rule, selector, and pseudo state.
    ///
    /// This context is propagated via Swift's TaskLocal mechanism, enabling
    /// implicit parameter passing for media queries, selectors, and pseudo-states.
    ///
    /// ## Usage
    ///
    /// Set context for a scope:
    /// ```swift
    /// HTML.Element.Style.Context.$current.withValue(.init(atRule: .dark)) {
    ///     div.css.color(.red)  // Applies color with @media dark
    /// }
    /// ```
    ///
    /// Or use the convenience modifiers on CSS:
    /// ```swift
    /// div.css.dark { $0.color(.red) }
    /// button.css.hover { $0.backgroundColor(.blue) }
    /// ```
    ///
    /// ## Context Merging
    ///
    /// Nested contexts are merged, allowing composition:
    /// ```swift
    /// div.css.dark {
    ///     $0.hover {
    ///         $0.color(.white)  // Gets both @media dark AND :hover
    ///     }
    /// }
    /// ```
    public struct Context: Sendable, Hashable {
        /// Optional at-rule (e.g., media query).
        public let atRule: HTML.AtRule?

        /// Optional CSS selector prefix.
        public let selector: HTML.Selector?

        /// Optional pseudo-class or pseudo-element.
        public let pseudo: HTML.Pseudo?

        /// The default empty context.
        public static let `default` = Context(atRule: nil, selector: nil, pseudo: nil)

        /// TaskLocal storage for the current style context.
        ///
        /// Use `$current.withValue(_:operation:)` to set context for a scope:
        /// ```swift
        /// HTML.Element.Style.Context.$current.withValue(.init(atRule: .dark)) {
        ///     // All styles in this scope get the dark media query
        /// }
        /// ```
        @TaskLocal public static var current: Context = .default

        /// Creates a style context with the specified modifiers.
        ///
        /// - Parameters:
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional CSS selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init(
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// Creates a context with a media query.
        ///
        /// - Parameter media: The media query to apply.
        public init(media: HTML.AtRule.Media?) {
            self.atRule = media
            self.selector = nil
            self.pseudo = nil
        }

        /// Creates a context with a pseudo-class or pseudo-element.
        ///
        /// - Parameter pseudo: The pseudo-class or pseudo-element.
        public init(pseudo: HTML.Pseudo?) {
            self.atRule = nil
            self.selector = nil
            self.pseudo = pseudo
        }

        /// Creates a context with a selector.
        ///
        /// - Parameter selector: The CSS selector prefix.
        public init(selector: HTML.Selector?) {
            self.atRule = nil
            self.selector = selector
            self.pseudo = nil
        }

        // MARK: - Composition

        /// Merges this context with another, with the other taking precedence for non-nil values.
        ///
        /// This enables nested contexts to accumulate:
        /// ```swift
        /// .dark {           // atRule = .dark
        ///     .hover { ... }  // atRule = .dark, pseudo = :hover (merged)
        /// }
        /// ```
        ///
        /// - Parameter other: The context to merge with (its values take precedence).
        /// - Returns: A new context with merged values.
        public func merging(with other: Context) -> Context {
            Context(
                atRule: other.atRule ?? self.atRule,
                selector: other.selector ?? self.selector,
                pseudo: combinePseudo(self.pseudo, other.pseudo)
            )
        }

        /// Combines two pseudo-selectors.
        ///
        /// When both contexts have pseudo values, they're combined (e.g., `:hover:focus`).
        /// - Parameters:
        ///   - lhs: The first pseudo value.
        ///   - rhs: The second pseudo value.
        /// - Returns: The combined pseudo value, or the non-nil one if only one exists.
        private func combinePseudo(_ lhs: HTML.Pseudo?, _ rhs: HTML.Pseudo?) -> HTML.Pseudo? {
            switch (lhs, rhs) {
            case (nil, nil): return nil
            case (let p?, nil): return p
            case (nil, let p?): return p
            case (let l?, let r?): return l + r
            }
        }
    }
}


// ====================
// Sources/HTML Renderable/HTML.Style.swift
// ====================
//
//  HTML.Style.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

public import W3C_CSS_Shared
public import WHATWG_HTML_Shared

extension HTML.Element {
    /// A CSS style declaration with optional scope modifiers.
    ///
    /// `HTML.Style` captures a CSS declaration and its context (at-rule, selector, pseudo).
    /// This is the unified representation for all styling operations.
    ///
    /// Create styles from typed CSS properties for compile-time safety:
    /// ```swift
    /// HTML.Style(Color.red)
    /// HTML.Style(Margin.px(10), pseudo: .hover)
    /// ```
    ///
    /// Or from raw declaration strings when needed:
    /// ```swift
    /// HTML.Style(declaration: "color:red")
    /// ```
    public struct Style: Hashable, Sendable {
        /// The CSS declaration string (e.g., "color:red")
        public let declaration: String

        /// Optional at-rule (e.g., @media query)
        public let atRule: HTML.AtRule?

        /// Optional CSS selector prefix
        public let selector: HTML.Selector?

        /// Optional pseudo-class or pseudo-element
        public let pseudo: HTML.Pseudo?

        /// Create a style from a typed CSS property.
        ///
        /// This is the primary API for creating styles with compile-time type safety.
        ///
        /// - Parameters:
        ///   - property: The typed CSS property value.
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init<P: Property>(
            _ property: P,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.declaration = property.declaration.description
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// Create a style from a raw declaration string.
        ///
        /// Use this when you need to bypass the typed property system.
        ///
        /// - Parameters:
        ///   - declaration: The CSS declaration string (e.g., "color:red").
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init(
            declaration: String,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.declaration = declaration
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        /// The CSS property name extracted from the declaration.
        ///
        /// For "color:red", returns "color".
        /// Used for generating descriptive class names.
        public var propertyName: String {
            if let colonIndex = declaration.firstIndex(of: ":") {
                return String(declaration[..<colonIndex])
            }
            return declaration
        }
    }
}


// ====================
// Sources/HTML Renderable/HTML.Styled.swift
// ====================
//
//  HTML.Styled.swift
//  swift-html-rendering
//
//  Applies CSS styles to HTML content via generated class names.
//

import Rendering
public import W3C_CSS_Shared
public import WHATWG_HTML_Shared

extension HTML {
    /// A wrapper that applies a CSS style to HTML content.
    ///
    /// `HTML.Styled` applies CSS styles to HTML elements by generating
    /// unique class names and collecting the associated styles in a stylesheet.
    ///
    /// ```swift
    /// div()
    ///     .inlineStyle(Color.red)
    ///     .inlineStyle(Margin.px(10), pseudo: .hover)
    /// ```
    ///
    /// Styles are collected in the render context and output as a `<style>` block.
    /// The `P` generic preserves the typed property for PDF rendering.
    public struct Styled<Content, P: Property> {
        /// The HTML content being styled.
        public let content: Content

        /// The typed CSS property (nil if no style).
        public let property: P?

        /// The style metadata for HTML rendering.
        public let style: HTML.Element.Style?

        /// Optional at-rule (e.g., media query).
        public let atRule: HTML.AtRule?

        /// Optional CSS selector prefix.
        public let selector: HTML.Selector?

        /// Optional pseudo-class or pseudo-element.
        public let pseudo: HTML.Pseudo?

        /// Creates a styled HTML element from a typed CSS property.
        ///
        /// - Parameters:
        ///   - content: The HTML content to style.
        ///   - property: The typed CSS property value.
        ///   - atRule: Optional at-rule (e.g., media query).
        ///   - selector: Optional selector prefix.
        ///   - pseudo: Optional pseudo-class or pseudo-element.
        public init(
            _ content: Content,
            _ property: P?,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.content = content
            self.property = property
            self.style = property.map {
                HTML.Element.Style($0, atRule: atRule, selector: selector, pseudo: pseudo)
            }
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }
    }
}

extension HTML.Styled: Renderable where Content: HTML.View {
    public typealias Context = HTML.Context

    public typealias Output = UInt8
}

extension HTML.Styled: HTML.View where Content: HTML.View {
    /// Renders this styled HTML element into the provided buffer.
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: HTML.Styled<Content, P>,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        // Push style to context, get class name
        if let style = html.style {
            let className = context.pushStyle(style)
            // Append to existing class or set new
            if let existing = context.attributes["class"] {
                context.attributes["class"] = existing + " " + className
            } else {
                context.attributes["class"] = className
            }
        }
        // Render content with static dispatch
        Content._render(html.content, into: &buffer, context: &context)
    }

    /// This type uses direct rendering and doesn't have a body.
    public var body: Never { fatalError("body should not be called") }
}

extension HTML.Styled: Sendable where Content: Sendable, P: Sendable {}

// MARK: - HTML.View Extension

extension HTML.View {
    /// Applies a typed CSS property to an HTML element.
    ///
    /// This method enables a type-safe, declarative approach to styling HTML elements
    /// directly in Swift code. It generates CSS classes and stylesheets automatically.
    ///
    /// The at-rule, selector, and pseudo values are read from the current
    /// `HTML.Element.Style.Context` TaskLocal, allowing context-based styling:
    ///
    /// ```swift
    /// // Basic usage
    /// div { "Hello" }
    ///     .inlineStyle(Color.red)
    ///     .inlineStyle(Padding.px(10))
    ///
    /// // With context (via CSS modifiers)
    /// div.css.dark { $0.color(.white) }
    /// button.css.hover { $0.backgroundColor(.blue) }
    /// ```
    ///
    /// - Parameter property: The typed CSS property value.
    /// - Returns: An HTML element with the specified style applied.
    public func inlineStyle<P: Property>(
        _ property: P?
    ) -> HTML.Styled<Self, P> {
        let ctx = HTML.Element.Style.Context.current
        return HTML.Styled(
            self,
            property,
            atRule: ctx.atRule,
            selector: ctx.selector,
            pseudo: ctx.pseudo
        )
    }
}


// ====================
// Sources/HTML Renderable/HTML.Tag.swift
// ====================
//
//  HTML.Tag.swift
//
//
//  Created by Point-Free, Inc
//

import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    public static var tag: HTML.Tag.Type {
        HTML.Tag.self
    }
}

extension HTML {
    /// Represents a standard HTML tag that can contain other HTML elements.
    ///
    /// `HTML.Tag` provides a convenient way to create HTML elements with a function-call
    /// syntax. It supports both empty elements and elements with content.
    ///
    /// Example:
    /// ```swift
    /// // Empty div
    /// let emptyDiv = div()
    ///
    /// // Div with content
    /// let contentDiv = div {
    ///     h1 { "Title" }
    ///     p { "Paragraph" }
    /// }
    /// ```
    ///
    /// This struct is primarily used through the predefined tag variables like `div`, `span`,
    /// `h1`, etc., but can also be used directly with custom tag names.
    public struct Tag {
        /// The name of the HTML tag.
        public let rawValue: String

        /// Creates a new HTML tag with the specified name.
        ///
        /// - Parameter rawValue: The name of the HTML tag.
        internal init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension HTML.Tag {
    /// <!doctype html>
    @inlinable
    public static var doctype: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.exclamationPoint,
            .ascii.d, .ascii.o, .ascii.c, .ascii.t, .ascii.y, .ascii.p, .ascii.e,
            .ascii.space,
            .ascii.h, .ascii.t, .ascii.m, .ascii.l,
            .ascii.greaterThanSign,
        ]
    }

    /// <html>
    @inlinable
    public static var open: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.h, .ascii.t, .ascii.m, .ascii.l,
            .ascii.greaterThanSign,
        ]
    }

    /// </html>
    @inlinable
    public static var close: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.h, .ascii.t, .ascii.m, .ascii.l,
            .ascii.greaterThanSign,
        ]
    }

    /// <head>
    @inlinable
    public static var headOpen: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.h, .ascii.e, .ascii.a, .ascii.d,
            .ascii.greaterThanSign,
        ]
    }

    /// </head>
    @inlinable
    public static var headClose: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.h, .ascii.e, .ascii.a, .ascii.d,
            .ascii.greaterThanSign,
        ]
    }

    /// <body>
    @inlinable
    public static var bodyOpen: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.b, .ascii.o, .ascii.d, .ascii.y,
            .ascii.greaterThanSign,
        ]
    }

    /// </body>
    @inlinable
    public static var bodyClose: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.b, .ascii.o, .ascii.d, .ascii.y,
            .ascii.greaterThanSign,
        ]
    }

    /// <style>
    @inlinable
    public static var styleOpen: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.s, .ascii.t, .ascii.y, .ascii.l, .ascii.e,
            .ascii.greaterThanSign,
        ]
    }

    /// </style>
    @inlinable
    public static var styleClose: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.s, .ascii.t, .ascii.y, .ascii.l, .ascii.e,
            .ascii.greaterThanSign,
        ]
    }
}


// ====================
// Sources/HTML Renderable/HTML.Text.swift
// ====================
//
//  HTML.Text.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import INCITS_4_1986
import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

extension HTML {
    /// Represents plain text content in HTML, with proper escaping.
    ///
    /// `HTML.Text` handles escaping special characters in text content to ensure
    /// proper HTML rendering without security vulnerabilities.
    public struct Text: HTML.View, Sendable {
        /// The raw text content.
        public let text: String

        /// Creates a new HTML text component with the given text.
        ///
        /// - Parameter text: The text content to represent.
        public init(_ text: String) {
            self.text = text
        }

        /// Renders the text content with proper HTML escaping.
        public static func _render<Buffer: RangeReplaceableCollection>(
            _ html: Self,
            into buffer: inout Buffer,
            context: inout HTML.Context
        ) where Buffer.Element == UInt8 {
            for byte in html.text.utf8 {
                switch byte {
                case .ascii.ampersand:
                    buffer.append(contentsOf: [UInt8].html.ampersand)
                case .ascii.lessThanSign:
                    buffer.append(contentsOf: [UInt8].html.lessThan)
                case .ascii.greaterThanSign:
                    buffer.append(contentsOf: [UInt8].html.greaterThan)
                default:
                    buffer.append(byte)
                }
            }
        }

        /// This type uses direct rendering and doesn't have a body.
        public var body: Never { fatalError("body should not be called") }

        /// Concatenates two HTML text components.
        ///
        /// - Parameters:
        ///   - lhs: The left-hand side text.
        ///   - rhs: The right-hand side text.
        /// - Returns: A new HTML text component containing the concatenated text.
        public static func + (lhs: Self, rhs: Self) -> Self {
            HTML.Text(lhs.text + rhs.text)
        }
    }
}

/// Allows HTML text to be created from string literals.
extension HTML.Text: ExpressibleByStringLiteral {
    /// Creates a new HTML text component from a string literal.
    ///
    /// - Parameter value: The string literal to use as content.
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

/// Allows HTML text to be created with string interpolation.
extension HTML.Text: ExpressibleByStringInterpolation {}

// MARK: - Async Rendering

extension HTML.Text: AsyncRenderable {
    /// Async renders the text content with proper HTML escaping.
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        var buffer: [UInt8] = []
        for byte in html.text.utf8 {
            switch byte {
            case .ascii.ampersand:
                buffer.append(contentsOf: [UInt8].html.ampersand)
            case .ascii.lessThanSign:
                buffer.append(contentsOf: [UInt8].html.lessThan)
            case .ascii.greaterThanSign:
                buffer.append(contentsOf: [UInt8].html.greaterThan)
            default:
                buffer.append(byte)
            }
        }
        await stream.write(buffer)
    }
}


// ====================
// Sources/HTML Renderable/HTML.View.swift
// ====================
//
//  HTML.View.swift
//  swift-html-rendering
//
//  Created by Point-Free, Inc
//

import OrderedCollections
public import Rendering
public import RenderingAsync
import Standards
public import WHATWG_HTML_Shared

/// A protocol representing an HTML element or component that can be rendered.
///
/// The `HTML.View` protocol is the core abstraction of the RenderingHTML library,
/// allowing Swift types to represent HTML content in a declarative, composable manner.
/// It uses a component-based architecture similar to SwiftUI, where each component
/// defines its `body` property to build up a hierarchy of HTML elements.
///
/// This protocol is available as `HTML.View` for a more SwiftUI-like API.
///
/// Example:
/// ```swift
/// struct MyView: HTML.View {
///     var body: some HTML.View {
///         div {
///             h1 { "Hello, World!" }
///             p { "This is a paragraph." }
///         }
///     }
/// }
/// ```
///
/// - Note: This protocol is similar in design to SwiftUI's `View` protocol,
///   making it familiar to Swift developers who have worked with SwiftUI.
extension HTML {
    public protocol View: Renderable
    where Content: HTML.View, Context == HTML.Context, Output == UInt8 {
        @HTML.Builder var body: Content { get }
    }
}

extension HTML.View {
    @inlinable
    @_disfavoredOverload
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: Self,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        Content._render(html.body, into: &buffer, context: &context)
    }
}

// MARK: - Async Rendering

extension HTML {
    /// A protocol for HTML views that support async rendering with backpressure.
    ///
    /// Async rendering allows suspension at element boundaries, enabling true
    /// progressive streaming where memory is bounded to O(chunkSize).
    ///
    /// ## Rendering Options
    ///
    /// There are two canonical ways to render HTML:
    ///
    /// | Pattern | Memory | Use Case |
    /// |---------|--------|----------|
    /// | `[UInt8](html)` | O(doc) | Complete bytes (PDF, simple responses) |
    /// | `AsyncChannel { html }` | **O(chunk)** | Streaming with backpressure (HTTP) |
    ///
    /// ## Example Usage
    ///
    /// ```swift
    /// // Sync - complete bytes
    /// let bytes = [UInt8](myView)
    ///
    /// // Streaming with backpressure
    /// for await chunk in AsyncChannel { myView } {
    ///     await response.write(chunk)
    /// }
    /// ```
    ///
    /// Choose sync when you need the complete document (e.g., PDF generation).
    /// Choose AsyncChannel when streaming to a client that benefits from
    /// progressive delivery and you want bounded memory usage.
    public protocol AsyncView: HTML.View, AsyncRenderable where Content: AsyncRenderable {}
}

extension HTML.AsyncView {
    /// Default implementation delegates to content's async render method.
    @inlinable
    @_disfavoredOverload
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        await Content._renderAsync(html.body, into: stream, context: &context)
    }
}

/// Extension to add attribute capabilities to all HTML elements.
extension HTML.View {
    /// Adds a custom attribute to an HTML element.
    ///
    /// This method allows you to set any attribute on an HTML element,
    /// providing flexibility for both standard and custom attributes.
    ///
    /// Example:
    /// ```swift
    /// div { "Content" }
    ///     .attribute("data-testid", "main-content")
    ///     .attribute("aria-label", "Main content section")
    /// ```
    ///
    /// - Parameters:
    ///   - name: The name of the attribute.
    ///   - value: The optional value of the attribute. If nil, the attribute is omitted.
    ///            If an empty string, the attribute is included without a value.
    /// - Returns: An HTML element with the attribute applied.
    ///
    /// - Note: This is the primary method for adding any HTML attribute.
    ///   Use this for all attributes including common ones like
    ///   `charset`, `name`, `content`, `type`, etc.
    ///
    /// Example:
    /// ```swift
    /// meta().attribute("charset", "utf-8")
    /// meta().attribute("name", "viewport").attribute("content", "width=device-width, initial-scale=1")
    /// input().attribute("type", "text").attribute("placeholder", "Enter your name")
    /// div().attribute("id", "main").attribute("class", "container")
    /// ```
    public func attribute(_ name: String, _ value: String? = "") -> HTML._Attributes<Self> {
        HTML._Attributes(content: self, attributes: value.map { [name: $0] } ?? [:])
    }
}

extension HTML.View {
    @inlinable
    func render<Buffer: RangeReplaceableCollection>(
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        Self._render(self, into: &buffer, context: &context)
    }
}

/// Provides a default `description` implementation for HTML types that also conform to `CustomStringConvertible`.
///
/// This allows any HTML element to be printed or interpolated into strings,
/// automatically rendering its HTML representation.
///
/// ## Example
///
/// ```swift
/// struct Greeting: HTML.View, CustomStringConvertible {
///     var body: some HTML.View {
///         tag("div") { HTML.Text("Hello!") }
///     }
/// }
///
/// let greeting = Greeting()
/// print(greeting) // Prints: <div>Hello!</div>
/// ```
extension CustomStringConvertible where Self: HTML.View {
    public var description: String {
        do {
            return try String(self)
        } catch {
            return ""
        }
    }
}


// ====================
// Sources/HTML Renderable/HTML._Attributes.swift
// ====================
//
//  HTML._Attributes.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import OrderedCollections
import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

extension HTML {
    /// A wrapper that applies attributes to an HTML element.
    ///
    /// `HTML._Attributes` is used to attach HTML attributes to elements in
    /// a type-safe, chainable manner. It manages the collection of attributes
    /// and their rendering into the final HTML output.
    ///
    /// You typically don't create this type directly but use the `attribute`
    /// method and its convenience wrappers (like `href`, `src`, etc.) on HTML elements.
    ///
    /// Example:
    /// ```swift
    /// a { "Visit our site" }
    ///     .href("https://example.com")
    ///     .attribute("target", "_blank")
    /// ```
    public struct _Attributes<Content: HTML.View>: HTML.View {
        /// The HTML content to which attributes are being applied.
        public let content: Content

        /// The collection of attributes to apply.
        public var attributes: OrderedDictionary<String, String>

        /// Adds an additional attribute to this element.
        ///
        /// This method allows for chaining multiple attributes on a single element.
        ///
        /// Example:
        /// ```swift
        /// img()
        ///     .src("image.jpg")
        ///     .attribute("loading", "lazy")
        ///     .attribute("width", "300")
        /// ```
        ///
        /// - Parameters:
        ///   - name: The name of the attribute.
        ///   - value: The optional value of the attribute.
        /// - Returns: An HTML element with both the original and new attributes applied.
        public func attribute(_ name: String, _ value: String? = "") -> HTML._Attributes<Content> {
            var copy = self
            copy.attributes[name] = value
            return copy
        }

        /// Renders this HTML element with attributes into the provided buffer.
        public static func _render<Buffer: RangeReplaceableCollection>(
            _ html: Self,
            into buffer: inout Buffer,
            context: inout HTML.Context
        ) where Buffer.Element == UInt8 {
            let previousValue = context.attributes
            defer { context.attributes = previousValue }
            context.attributes.merge(html.attributes, uniquingKeysWith: { $1 })
            Content._render(html.content, into: &buffer, context: &context)
        }

        /// This type uses direct rendering and doesn't have a body.
        public var body: Never { fatalError("body should not be called") }
        
        public init(content: Content, attributes: OrderedDictionary<String, String>) {
            self.content = content
            self.attributes = attributes
        }
    }
}

// MARK: - Sendable

extension HTML._Attributes: Sendable where Content: Sendable {}

// MARK: - Async Rendering

extension HTML._Attributes: AsyncRenderable where Content: AsyncRenderable {
    /// Async renders this HTML element with attributes.
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        let previousValue = context.attributes
        defer { context.attributes = previousValue }
        context.attributes.merge(html.attributes, uniquingKeysWith: { $1 })
        await Content._renderAsync(html.content, into: stream, context: &context)
    }
}


// ====================
// Sources/HTML Renderable/HTML.swift
// ====================
//
//  HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

public import WHATWG_HTML_Shared

extension HTML {
    /// &quot; - Double quotation mark HTML entity
    public static let doubleQuotationMark: [UInt8] = [
        .ascii.ampersand,
        .ascii.q,
        .ascii.u,
        .ascii.o,
        .ascii.t,
        .ascii.semicolon,
    ]

    /// &#39; - Apostrophe HTML entity
    public static let apostrophe: [UInt8] = [
        .ascii.ampersand,
        .ascii.numberSign,
        .ascii.3,
        .ascii.9,
        .ascii.semicolon,
    ]

    /// &amp; - Ampersand HTML entity
    public static let ampersand: [UInt8] = [
        .ascii.ampersand,
        .ascii.a,
        .ascii.m,
        .ascii.p,
        .ascii.semicolon,
    ]

    /// &lt; - Less-than HTML entity
    public static let lessThan: [UInt8] = [
        .ascii.ampersand,
        .ascii.l,
        .ascii.t,
        .ascii.semicolon,
    ]

    /// &gt; - Greater-than HTML entity
    public static let greaterThan: [UInt8] = [
        .ascii.ampersand,
        .ascii.g,
        .ascii.t,
        .ascii.semicolon,
    ]
}


// ====================
// Sources/HTML Renderable/Never+HTML.swift
// ====================
//
//  Never+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

/// Conformance of `Never` to `Rendering` to support the type system.
///
/// This provides the `Rendering` conformance with `HTML.Context` as the context type.
/// Each domain module (HTML, XML, etc.) provides its own `Never` conformance.
extension Never: @retroactive Renderable {
    public typealias Content = Never
    public typealias Context = HTML.Context
    public typealias Output = UInt8

    @inlinable
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ markup: Self,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {}

    public var body: Never { fatalError("body should not be called") }
}

/// Conformance of `Never` to `HTML.View` to support the type system.
///
/// This conformance is provided to allow the use of the `HTML.View` protocol in
/// contexts where no content is expected or possible.
extension Never: HTML.View {}

extension Never: @retroactive AsyncRenderable {
    @inlinable
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ markup: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {}
}


// ====================
// Sources/HTML Renderable/Optional+HTML.swift
// ====================
//
//  Optional+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

/// Allows optional values to be used as HTML elements.
///
/// This conformance allows for convenient handling of optional HTML content,
/// where `nil` values simply render nothing.
extension Optional: HTML.View where Wrapped: HTML.View {}


// ====================
// Sources/HTML Renderable/RangeReplaceableCollection<UInt8>+HTML.swift
// ====================
//
//  File.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

extension RangeReplaceableCollection<UInt8> {
    /// Creates a byte collection from rendered HTML.
    ///
    /// This is the canonical way to render HTML to bytes when you need the
    /// complete document. Works with any `RangeReplaceableCollection<UInt8>`.
    ///
    /// ## When to Use
    ///
    /// Use `[UInt8](html)` when:
    /// - You need the complete document (e.g., PDF generation)
    /// - The document is small to medium sized
    /// - Simplicity is preferred over streaming
    ///
    /// Use `AsyncChannel { html }` instead when:
    /// - Streaming large documents to HTTP clients
    /// - Memory usage must be bounded regardless of document size
    ///
    /// ## Canonical Usage
    ///
    /// ```swift
    /// let bytes = [UInt8](myView)
    /// ```
    ///
    /// ## Memory Characteristics
    ///
    /// | Pattern | Memory |
    /// |---------|--------|
    /// | `[UInt8](html)` | O(doc size) |
    /// | `AsyncChannel { html }` | O(chunkSize) |
    ///
    /// - Parameters:
    ///   - view: The HTML content to render to bytes
    ///   - configuration: Rendering configuration. Uses current task-local or default if nil.
    @inlinable
    public init<View: HTML.View>(
        _ view: View,
        configuration: HTML.Context.Configuration? = nil
    ) {
        var buffer = Self()
        var context = HTML.Context(configuration ?? .current)
        View._render(view, into: &buffer, context: &context)
        self = buffer
    }
}
//
// extension RangeReplaceableCollection<UInt8> {
//    /// Creates a byte collection from rendered HTML.
//    ///
//    /// Convenience overload that accepts HTML as the first unlabeled parameter.
//    ///
//    /// - Parameters:
//    ///   - html: The HTML content to render to bytes
//    ///   - configuration: Rendering configuration. Uses current task-local or default if nil.
//    @inlinable
//    public init(
//        _ html: some HTML.View,
//        configuration: HTML.Context.Configuration? = nil
//    ) {
//        self.init(html: HTML.View, configuration: configuration)
//    }
// }

extension RangeReplaceableCollection<UInt8> {
    /// Asynchronously render HTML to a byte collection.
    ///
    /// This yields to the scheduler during rendering to avoid blocking,
    /// making it suitable for use in async contexts where responsiveness matters.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let html = div { "Hello" }
    /// let bytes: [UInt8] = await .init(html: html)
    /// ```
    ///
    /// - Parameters:
    ///   - html: The HTML content to render.
    ///   - configuration: Rendering configuration. Uses default if nil.
    @inlinable
    public init<View: HTML.View>(
        _ view: View,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        await Task.yield()
        var buffer = Self()
        var context = HTML.Context(configuration ?? .current)
        View._render(view, into: &buffer, context: &context)
        self = buffer
    }
}

// MARK: - Document Rendering

extension RangeReplaceableCollection<UInt8> {
    /// Creates a byte collection from a rendered HTML document.
    ///
    /// - Parameters:
    ///   - document: The HTML document to render.
    ///   - configuration: Rendering configuration. Uses current task-local or default if nil.
    @inlinable
    public init<Document: HTML.DocumentProtocol>(
        _ document: Document,
        configuration: HTML.Context.Configuration? = nil
    ) {
        var buffer = Self()
        var context = HTML.Context(configuration ?? .current)
        Document._render(document, into: &buffer, context: &context)
        self = buffer
    }
}

extension RangeReplaceableCollection<UInt8> {
    /// Asynchronously render an HTML document to a byte collection.
    ///
    /// - Parameters:
    ///   - document: The HTML document to render.
    ///   - configuration: Rendering configuration. Uses default if nil.
    @inlinable
    public init<Document: HTML.DocumentProtocol>(
        _ document: Document,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        await Task.yield()
        var buffer = Self()
        var context = HTML.Context(configuration ?? .current)
        Document._render(document, into: &buffer, context: &context)
        self = buffer
    }
}


// ====================
// Sources/HTML Renderable/String+HTML.swift
// ====================
//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 09/04/2025.
//

import Rendering
public import WHATWG_HTML_Shared

extension String: @retroactive Renderable {
    public typealias Content = HTML.Text
    public typealias Context = HTML.Context
    public typealias Output = UInt8
}

extension String: HTML.View {
    public var body: HTML.Text {
        HTML.Text(self)
    }
}


// ====================
// Sources/HTML Renderable/StringProtocol+HTML.swift
// ====================
//
//  String.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 12/03/2025.
//

import Rendering
public import WHATWG_HTML_Shared

// MARK: - RFC Pattern: String Derived from Bytes

extension StringProtocol {
    /// Creates a String from rendered HTML content.
    ///
    /// This is a **derived transformation** in the RFC pattern, where String
    /// is constructed from the canonical byte representation (`ContiguousArray<UInt8>`).
    /// The bytes are validated against the specified encoding before conversion.
    ///
    /// ## Transformation Chain
    ///
    /// ```
    /// HTML → ContiguousArray<UInt8> → String
    ///  ↑           ↑ (canonical)        ↑ (derived)
    ///  |           |                     |
    /// Protocol  Byte Representation  User-facing
    /// ```
    ///
    /// ## Performance
    ///
    /// - Uses zero-copy `ContiguousArray` internally
    /// - Validates UTF-8 encoding (or other specified encoding)
    /// - Throws if bytes are invalid for the specified encoding
    /// - ~3,500 documents/second (~280µs per complete HTML document)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let document = HTML.Document {
    ///     div {
    ///         h1 { "Hello, World!" }
    ///         p { "Welcome to PointFree HTML" }
    ///     }
    /// }
    ///
    /// do {
    ///     let htmlString = try String(document)
    ///     print(htmlString)
    /// } catch {
    ///     print("Failed to render HTML: \(error)")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - html: The HTML content to render as a string
    ///   - encoding: The character encoding to use when converting bytes to string (default: UTF-8)
    ///
    /// - Throws: `HTML.Context.Configuration.Error` if the rendered bytes cannot be converted to a string
    ///   using the specified encoding
    ///
    /// ## See Also
    ///
    /// - ``ContiguousArray/init(_:)-swift.method``: Canonical byte transformation
    /// - ``Array/init(_:)-swift.method``: Array convenience wrapper
    public init(
        _ html: some HTML.View,
        configuration: HTML.Context.Configuration? = nil
    ) throws(HTML.Context.Configuration.Error) {
        let bytes = ContiguousArray(html, configuration: configuration)
        self = Self(decoding: bytes, as: UTF8.self)
    }
}

extension StringProtocol {
    /// Asynchronously render HTML to a String.
    ///
    /// This is the authoritative implementation for async HTML string rendering.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let html = div { "Hello" }
    /// let string = await String(html)
    /// ```
    ///
    /// - Parameters:
    ///   - html: The HTML content to render.
    ///   - configuration: Rendering configuration. Uses default if nil.
    @inlinable
    public init<T: HTML.View>(
        _ view: T,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        let bytes = await [UInt8](view, configuration: configuration)
        self = Self(decoding: bytes, as: UTF8.self)
    }
}

extension StringProtocol {
    /// Asynchronously render an HTML document to a String.
    ///
    /// This is the authoritative implementation for async document string rendering.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let page = MyPage()
    /// let string = await String(document: page)
    /// ```
    ///
    /// - Parameters:
    ///   - document: The HTML document to render.
    ///   - configuration: Rendering configuration. Uses default if nil.
    @inlinable
    public init<T: HTML.DocumentProtocol>(
        _ document: T,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        let bytes = await [UInt8](document, configuration: configuration)
        self = Self(decoding: bytes, as: UTF8.self)
    }
}


// ====================
// Sources/HTML Renderable/_Array+HTML.swift
// ====================
//
//  _Array+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

// Extend the _Array type from Rendering module to conform to HTML.View
// Note: _Array is a top-level type exported from the Rendering module.
// Users can access it as _Array<Content> directly, not through HTML._Array.
extension _Array: HTML.View where Element: HTML.View {}


// ====================
// Sources/HTML Renderable/_Conditional+HTML.swift
// ====================
//
//  _Conditional+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

// Extend the _Conditional type from Rendering module to conform to HTML.View
// Note: _Conditional is a top-level type exported from the Rendering module.
// Users can access it as _Conditional<First, Second> directly, not through HTML._Conditional.
extension _Conditional: HTML.View where First: HTML.View, Second: HTML.View {}


// ====================
// Sources/HTML Renderable/_Tuple+HTML.swift
// ====================
//
//  _Tuple+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared
public import RenderingAsync

// Extend the _Tuple type from Rendering module to conform to HTML.View
// Note: _Tuple is a top-level type exported from the Rendering module.
// Users can access it as _Tuple<Content...> directly, not through HTML._Tuple.
extension _Tuple: @retroactive Renderable where repeat each Content: HTML.View {
    public typealias Context = HTML.Context
    public typealias Content = Never
    public typealias Output = UInt8
    public var body: Never { fatalError("body should not be called") }

    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: Self,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        func render<T: HTML.View>(_ element: T) {
            let oldAttributes = context.attributes
            defer { context.attributes = oldAttributes }
            T._render(element, into: &buffer, context: &context)
        }
        repeat render(each html.content)
    }
}

extension _Tuple: HTML.View where repeat each Content: HTML.View {}

extension _Tuple: @retroactive AsyncRenderable
where repeat each Content: AsyncRenderable, repeat each Content: HTML.View {
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        func render<T: AsyncRenderable>(_ element: T) async where T.Context == HTML.Context {
            let oldAttributes = context.attributes
            defer { context.attributes = oldAttributes }
            await T._renderAsync(element, into: stream, context: &context)
        }
        repeat await render(each html.content)
    }
}


// ====================
// Sources/HTML Renderable/_deprecations.swift
// ====================
//
//  File.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

import Rendering
public import WHATWG_HTML_Shared

extension HTML.DocumentProtocol {
    /// Renders this HTML document to bytes.
    ///
    /// This method creates a printer with the current configuration and
    /// renders the HTML document into it, then returns the resulting bytes.
    ///
    /// - Returns: A buffer of bytes representing the rendered HTML document.
    ///
    /// - Warning: This method is deprecated. Use the RFC pattern initialization instead:
    ///   ```swift
    ///   // Old (deprecated)
    ///   let bytes = document.render()
    ///
    ///   // New (RFC pattern - zero-copy)
    ///   let bytes = ContiguousArray(document)
    ///
    ///   // Or for String output
    ///   let string = try String(document)
    ///   ```
    @available(
        *,
        deprecated,
        message:
            "Use ContiguousArray(html) or String(html) instead. The RFC pattern makes bytes canonical and String derived."
    )
    public func render() -> ContiguousArray<UInt8> {
        var buffer: ContiguousArray<UInt8> = []
        var context = HTML.Context(HTML.Context.Configuration.current)
        Self._render(self, into: &buffer, context: &context)
        return buffer
    }
}

// String-based inlineStyle methods removed in favor of typed Property-based API.
// Use: .inlineStyle(CSSProperty.value) instead of .inlineStyle("property", "value")


// ====================
// Sources/HTML Renderable/exports.swift
// ====================
//
//  exports.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

@_exported import HTML_Standard
@_exported import INCITS_4_1986
@_exported import OrderedCollections
@_exported import Rendering
@_exported import W3C_CSS_Shared
@_exported import WHATWG_HTML_Shared


// ====================
// Sources/HTML Renderable/tag.swift
// ====================
//
//  tag.swift
//  swift-html-rendering
//
//  SPI-exposed function for creating HTML elements from string tag names.
//

public import WHATWG_HTML_Shared

// MARK: - Tag Function (SPI)

/// Creates an HTML element with the specified tag name and content.
///
/// This function allows creating HTML elements dynamically from string tag names.
/// It's exposed via SPI because in most cases you should prefer the typed element
/// functions like `div()`, `span()`, etc. for better type safety.
///
/// - Parameters:
///   - tagName: The name of the HTML tag.
///   - content: A closure that returns the content for this element.
/// - Returns: An HTML element with the specified tag and content.
///
/// - Note: Import with `@_spi(DynamicHTML) import HTML_Renderable` to access this function.
@_spi(DynamicHTML)
@inlinable
public func tag<T: HTML.View>(
    _ tagName: String,
    @HTML.Builder _ content: () -> T = { Empty() }
) -> HTML.Element.Tag<T> {
    HTML.Element.Tag(tag: tagName, content: content)
}

/// Creates an empty HTML element with the specified tag name.
///
/// - Parameter tagName: The name of the HTML tag.
/// - Returns: An HTML element with the specified tag and no content.
@_spi(DynamicHTML)
@inlinable
public func tag(_ tagName: String) -> HTML.Element.Tag<Empty> {
    HTML.Element.Tag(tag: tagName) { Empty() }
}


// ====================
// Sources/HTML Rendering TestSupport/DynamicElement.swift
// ====================
//
//  DynamicElement.swift
//  swift-html-rendering
//
//  Test support for creating HTML elements from string tag names.
//

import HTML_Renderable
import Rendering
import W3C_CSS_Shared
public import WHATWG_HTML_Shared

// MARK: - Tag Function for Testing

/// Creates an HTML element with the specified tag name and content.
///
/// This function is provided for testing purposes only. In production code,
/// use the typed element functions like `div()`, `span()`, etc.
///
/// - Parameters:
///   - tagName: The name of the HTML tag.
///   - content: A closure that returns the content for this element.
/// - Returns: An HTML element with the specified tag and content.
public func tag<T: HTML.View>(
    _ tagName: String,
    @HTML.Builder _ content: () -> T = { Empty() }
) -> HTML.Element.Tag<T> {
    HTML.Element.Tag(tag: tagName, content: content)
}

// MARK: - String-based Inline Style for Testing

/// A simple string-based CSS property for testing.
///
/// This is a workaround to support string-based property/value for tests.
/// Since `Property.property` is static and we need dynamic names, we use
/// a custom `Declaration` initializer.
public struct TestProperty: Property, GlobalConvertible {
    public static var property: String { "" }
    public let name: String
    public let value: String

    public init(_ name: String, _ value: String) {
        self.name = name
        self.value = value
    }

    public static func global(_ global: Global) -> TestProperty {
        TestProperty("", global.rawValue)
    }

    /// Returns just the value, since `Declaration.init` adds the property name
    public var description: String {
        value
    }

    /// Custom declaration that uses our dynamic name instead of the static property
    public var declaration: Declaration {
        Declaration(description: "\(name):\(value)")
    }
}

extension HTML.View {
    /// Applies a string-based inline style. For testing only.
    ///
    /// This version supports explicit atRule/selector/pseudo parameters for testing.
    /// In production code, use the context-based API via CSS modifiers.
    public func inlineStyle(
        _ property: String,
        _ value: String,
        atRule: HTML.AtRule? = nil,
        selector: HTML.Selector? = nil,
        pseudo: HTML.Pseudo? = nil
    ) -> HTML.Styled<Self, TestProperty> {
        HTML.Styled(
            self,
            TestProperty(property, value),
            atRule: atRule,
            selector: selector,
            pseudo: pseudo
        )
    }
}

// MARK: - HTML.Tag callAsFunction for Testing

extension HTML.Tag {
    /// Creates an empty HTML element with this tag. For testing only.
    public func callAsFunction() -> HTML.Element.Tag<Empty> {
        HTML.Element.Tag(tag: self.rawValue) { Empty() }
    }

    /// Creates an HTML element with content. For testing only.
    public func callAsFunction<T: HTML.View>(@HTML.Builder _ content: () -> T) -> HTML.Element.Tag<T> {
        HTML.Element.Tag(tag: self.rawValue, content: content)
    }
}

// MARK: - HTML.Element callAsFunction for Testing

extension HTML.Element.Tag where Content == Empty {
    /// Creates a new HTML element with the same tag but different content. For testing only.
    ///
    /// This allows the pattern:
    /// ```swift
    /// let div = tag("div")  // Returns HTML.Element.Tag<Empty>
    /// let content = div { "Hello" }  // Returns HTML.Element.Tag<String>
    /// ```
    public func callAsFunction<T: HTML.View>(@HTML.Builder _ content: () -> T) -> HTML.Element.Tag<T> {
        HTML.Element.Tag<T>(tag: self.tagName, content: content)
    }
}

// extension HTML.Tag.Void {
//    /// Creates an HTML void element with this tag. For testing only.
//    public func callAsFunction() -> HTML.Element.Tag<Empty> {
//        HTML.Element.Tag(tag: self.rawValue) { Empty() }
//    }
// }
//
// extension HTML.Tag.Text {
//    /// Creates an HTML element with text content. For testing only.
//    public func callAsFunction(_ content: String = "") -> HTML.Element.Tag<HTML.Text> {
//        HTML.Element.Tag(tag: self.rawValue) { HTML.Text(content) }
//    }
//
//    /// Creates an HTML element with dynamic text content. For testing only.
//    public func callAsFunction(_ content: () -> String) -> HTML.Element.Tag<HTML.Text> {
//        HTML.Element.Tag(tag: self.rawValue) { HTML.Text(content()) }
//    }
// }


// ====================
// Sources/HTML Rendering TestSupport/RenderingHTML+SnapshotTesting.swift
// ====================
//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import HTML_Renderable
import Rendering_TestSupport
public import WHATWG_HTML_Shared

extension Snapshotting where Value: HTML.DocumentProtocol, Format == String {
    public static var html: Self {
        .html()
    }

    public static func html(
        configuration: HTML.Context.Configuration = .pretty
    ) -> Self {
        Snapshotting<String, String>.lines.pullback { value in
            HTML.Context.Configuration.$current.withValue(configuration) {
                (try? String(value)) ?? "HTML rendering failed"
            }
        }
    }
}

extension Snapshotting where Value: HTML.View, Format == String {
    public static var html: Self {
        .html()
    }

    public static func html(
        configuration: HTML.Context.Configuration = .pretty
    ) -> Self {
        Snapshotting<String, String>.lines.pullback { value in
            HTML.Context.Configuration.$current.withValue(configuration) {
                (try? String(value)) ?? "HTML rendering failed"
            }
        }
    }
}


// ====================
// Sources/HTML Rendering TestSupport/exports.swift
// ====================
//
//  exports.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

@_exported import HTML_Renderable
@_exported import Rendering_TestSupport


// ====================
// Sources/HTML Rendering/HTML Rendering.swift
// ====================
//
//  File.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 27/11/2025.
//

@_exported import HTML_Attributes_Rendering
@_exported import HTML_Elements_Rendering


