//
//  WHATWG_HTML.AnyView.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared

extension WHATWG_HTML {
    /// Type-erased wrapper for any HTML content.
    ///
    /// `WHATWG_HTML.AnyView` allows you to work with heterogeneous HTML types
    /// by erasing their specific type while preserving their rendering behavior.
    ///
    /// Example:
    /// ```swift
    /// func makeContent(condition: Bool) -> WHATWG_HTML.AnyView {
    ///     if condition {
    ///         WHATWG_HTML.AnyView(div { "Hello" })
    ///     } else {
    ///         WHATWG_HTML.AnyView(span { "World" })
    ///     }
    /// }
    /// ```
    public struct AnyView: WHATWG_HTML.View, @unchecked Sendable {
        public let base: any WHATWG_HTML.View
        private let renderFunction: (inout ContiguousArray<UInt8>, inout WHATWG_HTML.Context) -> Void

        public init<T: WHATWG_HTML.View>(_ base: T) {
            self.base = base
            self.renderFunction = { buffer, context in
                T._render(base, into: &buffer, context: &context)
            }
        }

        /// Creates a type-erased HTML wrapper from an existential WHATWG_HTML.View.
        ///
        /// This initializer handles the case where you already have an `any WHATWG_HTML.View`
        /// and need to wrap it in `AnyView` to apply modifiers.
        public init(_ base: any WHATWG_HTML.View) {
            // If it's already an AnyView, unwrap to avoid double-wrapping
            if let anyView = base as? WHATWG_HTML.AnyView {
                self = anyView
            } else {
                self.base = base
                self.renderFunction = { buffer, context in
                    func render<T: WHATWG_HTML.View>(_ html: T) {
                        T._render(html, into: &buffer, context: &context)
                    }
                    render(base)
                }
            }
        }

        public static func _render<Buffer: RangeReplaceableCollection>(
            _ html: WHATWG_HTML.AnyView,
            into buffer: inout Buffer,
            context: inout WHATWG_HTML.Context
        ) where Buffer.Element == UInt8 {
            var contiguousBuffer = ContiguousArray<UInt8>()
            html.renderFunction(&contiguousBuffer, &context)
            buffer.append(contentsOf: contiguousBuffer)
        }

        public var body: Never { fatalError("body should not be called") }
    }
}

extension WHATWG_HTML.AnyView {
    /// Creates a type-erased HTML wrapper from a builder closure.
    ///
    /// - Parameter closure: A closure that returns any HTML content.
    public init(
        @WHATWG_HTML.Builder _ closure: () -> any WHATWG_HTML.View
    ) {
        self.init(closure())
    }
}

// Keep AnyRenderable conformance for interoperability
extension AnyRenderable: @retroactive Renderable where Context == WHATWG_HTML.Context {
    public typealias Content = Never
    public typealias Output = UInt8

    public var body: Never { fatalError("body should not be called") }
}

extension AnyRenderable: WHATWG_HTML.View where Context == WHATWG_HTML.Context {}
public typealias AnyHTML = WHATWG_HTML.AnyView
