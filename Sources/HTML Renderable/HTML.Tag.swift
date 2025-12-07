//
//  HTML.Tag.swift
//
//
//  Created by Point-Free, Inc
//

import Renderable

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
    public struct Tag: ExpressibleByStringLiteral {
        /// The name of the HTML tag.
        public let rawValue: String

        /// Creates a new HTML tag with the specified name.
        ///
        /// - Parameter rawValue: The name of the HTML tag.
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }

        /// Creates a new HTML tag from a string literal.
        ///
        /// - Parameter value: The string literal representing the tag name.
        public init(stringLiteral value: String) {
            self.init(value)
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
            .ascii.greaterThanSign
        ]
    }

    /// <html>
    @inlinable
    public static var open: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.h, .ascii.t, .ascii.m, .ascii.l,
            .ascii.greaterThanSign
        ]
    }

    /// </html>
    @inlinable
    public static var close: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.h, .ascii.t, .ascii.m, .ascii.l,
            .ascii.greaterThanSign
        ]
    }

    /// <head>
    @inlinable
    public static var headOpen: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.h, .ascii.e, .ascii.a, .ascii.d,
            .ascii.greaterThanSign
        ]
    }

    /// </head>
    @inlinable
    public static var headClose: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.h, .ascii.e, .ascii.a, .ascii.d,
            .ascii.greaterThanSign
        ]
    }

    /// <body>
    @inlinable
    public static var bodyOpen: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.b, .ascii.o, .ascii.d, .ascii.y,
            .ascii.greaterThanSign
        ]
    }

    /// </body>
    @inlinable
    public static var bodyClose: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.b, .ascii.o, .ascii.d, .ascii.y,
            .ascii.greaterThanSign
        ]
    }

    /// <style>
    @inlinable
    public static var styleOpen: [UInt8] {
        [
            .ascii.lessThanSign,
            .ascii.s, .ascii.t, .ascii.y, .ascii.l, .ascii.e,
            .ascii.greaterThanSign
        ]
    }

    /// </style>
    @inlinable
    public static var styleClose: [UInt8] {
        [
            .ascii.lessThanSign, .ascii.slant,
            .ascii.s, .ascii.t, .ascii.y, .ascii.l, .ascii.e,
            .ascii.greaterThanSign
        ]
    }
}
