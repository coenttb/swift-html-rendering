///
/// Accept.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Add an accept attribute to specify which file types are allowed
    @discardableResult
    package func accept(
        _ value: Accept?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Accept.attribute, value?.description)
    }

    /// Add an accept attribute with multiple file types
    @discardableResult
    package func accept(
        _ fileTypes: Accept.FileType?...
    ) -> WHATWG_HTML._Attributes<Self> {
        self.accept(Accept(fileTypes.compactMap { $0 }))
    }

    /// Add an accept attribute with multiple file types
    @discardableResult
    package func accept(
        _ fileTypes: [Accept.FileType?]
    ) -> WHATWG_HTML._Attributes<Self> {
        self.accept(Accept(fileTypes.compactMap { $0 }))
    }
}
