//
//  Never+WHATWG_HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

/// Conformance of `Never` to `Rendering` to support the type system.
///
/// This provides the `Rendering` conformance with `WHATWG_HTML.Context` as the context type.
/// Each domain module (HTML, XML, etc.) provides its own `Never` conformance.
extension Never: @retroactive Renderable {
    public typealias Content = Never
    public typealias Context = WHATWG_HTML.Context
    public typealias Output = UInt8

    @inlinable
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ markup: Self,
        into buffer: inout Buffer,
        context: inout WHATWG_HTML.Context
    ) where Buffer.Element == UInt8 {}

    public var body: Never { fatalError("body should not be called") }
}

/// Conformance of `Never` to `WHATWG_HTML.View` to support the type system.
///
/// This conformance is provided to allow the use of the `WHATWG_HTML.View` protocol in
/// contexts where no content is expected or possible.
extension Never: WHATWG_HTML.View {}

extension Never: @retroactive AsyncRenderable {
    @inlinable
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ markup: Self,
        into stream: Stream,
        context: inout WHATWG_HTML.Context
    ) async {}
}
