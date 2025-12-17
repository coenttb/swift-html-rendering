//
//  WHATWG_HTML.Text.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import INCITS_4_1986
import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

extension WHATWG_HTML {
    /// Represents plain text content in HTML, with proper escaping.
    ///
    /// `WHATWG_HTML.Text` handles escaping special characters in text content to ensure
    /// proper HTML rendering without security vulnerabilities.
    public struct Text: WHATWG_HTML.View, Sendable {
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
            context: inout WHATWG_HTML.Context
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
            WHATWG_HTML.Text(lhs.text + rhs.text)
        }
    }
}

/// Allows HTML text to be created from string literals.
extension WHATWG_HTML.Text: ExpressibleByStringLiteral {
    /// Creates a new HTML text component from a string literal.
    ///
    /// - Parameter value: The string literal to use as content.
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

/// Allows HTML text to be created with string interpolation.
extension WHATWG_HTML.Text: ExpressibleByStringInterpolation {}

// MARK: - Async Rendering

extension WHATWG_HTML.Text: AsyncRenderable {
    /// Async renders the text content with proper HTML escaping.
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout WHATWG_HTML.Context
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
