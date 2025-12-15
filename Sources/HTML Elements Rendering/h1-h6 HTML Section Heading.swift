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
    ) -> HTML.Element<Content> {
        HTML.Element(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H2 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element<Content> {
        HTML.Element(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H3 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element<Content> {
        HTML.Element(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H4 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element<Content> {
        HTML.Element(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H5 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element<Content> {
        HTML.Element(for: Self.self) { content() }
    }
}

extension HTML_Standard_Elements.H6 {
    public func callAsFunction<Content: HTML.View>(
        @HTML.Builder _ content: () -> Content
    ) -> HTML.Element<Content> {
        HTML.Element(for: Self.self) { content() }
    }
}
