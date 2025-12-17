//
//  _Tuple+WHATWG_HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared
public import RenderingAsync

// Extend the _Tuple type from Rendering module to conform to WHATWG_HTML.View
// Note: _Tuple is a top-level type exported from the Rendering module.
// Users can access it as _Tuple<Content...> directly, not through WHATWG_HTML._Tuple.
extension _Tuple: @retroactive Renderable where repeat each Content: WHATWG_HTML.View {
    public typealias Context = WHATWG_HTML.Context
    public typealias Content = Never
    public typealias Output = UInt8
    public var body: Never { fatalError("body should not be called") }

    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: Self,
        into buffer: inout Buffer,
        context: inout WHATWG_HTML.Context
    ) where Buffer.Element == UInt8 {
        func render<T: WHATWG_HTML.View>(_ element: T) {
            let oldAttributes = context.attributes
            defer { context.attributes = oldAttributes }
            T._render(element, into: &buffer, context: &context)
        }
        repeat render(each html.content)
    }
}

extension _Tuple: WHATWG_HTML.View where repeat each Content: WHATWG_HTML.View {}

extension _Tuple: @retroactive AsyncRenderable
where repeat each Content: AsyncRenderable, repeat each Content: WHATWG_HTML.View {
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout WHATWG_HTML.Context
    ) async {
        func render<T: AsyncRenderable>(_ element: T) async where T.Context == WHATWG_HTML.Context {
            let oldAttributes = context.attributes
            defer { context.attributes = oldAttributes }
            await T._renderAsync(element, into: stream, context: &context)
        }
        repeat await render(each html.content)
    }
}
