//
//  WHATWG_HTML.Raw.swift
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

extension WHATWG_HTML {
    /// Represents raw, unescaped HTML content.
    ///
    /// `WHATWG_HTML.Raw` allows you to insert raw HTML content without any escaping or processing.
    /// This is useful when you need to include pre-generated HTML or for special cases
    /// where you need to bypass the normal HTML generation mechanism.
    ///
    /// Example:
    /// ```swift
    /// var body: some WHATWG_HTML.View {
    ///     div {
    ///         // Normal, escaped content
    ///         p { "Regular <p> content will be escaped" }
    ///
    ///         // Raw, unescaped content
    ///         WHATWG_HTML.Raw("<script>console.log('This is raw JS');</script>")
    ///     }
    /// }
    /// ```
    ///
    /// - Warning: Using `WHATWG_HTML.Raw` with user-provided content can lead to security
    ///   vulnerabilities such as cross-site scripting (XSS) attacks. Only use
    ///   `WHATWG_HTML.Raw` with trusted content that you have full control over.
    ///
    /// Note: This is a typealias to the `Raw` type from the Rendering module.
    /// The same `Raw` type can be used for HTML, SVG, XML, or any other rendering context.
    public typealias Raw = RenderingRaw
}

// Give Raw (from Rendering module) the WHATWG_HTML.View conformance
extension Raw: @retroactive Renderable {
    public typealias Content = Never
    public typealias Context = WHATWG_HTML.Context
    public typealias Output = UInt8

    /// Renders the raw bytes directly to the buffer without any processing.
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ raw: Self,
        into buffer: inout Buffer,
        context: inout WHATWG_HTML.Context
    ) where Buffer.Element == UInt8 {
        buffer.append(contentsOf: raw.bytes)
    }

    /// This type uses direct rendering and doesn't have a body.
    public var body: Never { fatalError("body should not be called") }
}

extension Raw: WHATWG_HTML.View {}

extension Raw: @retroactive AsyncRenderable {
    /// Async renders the raw bytes directly to the stream.
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ raw: Self,
        into stream: Stream,
        context: inout WHATWG_HTML.Context
    ) async {
        await stream.write(raw.bytes)
    }
}
