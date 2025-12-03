//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Standard_Elements
import HTML_Attributes_Rendering
extension Option: @retroactive Renderable {}
extension HTML_Standard_Elements.Option: HTML.View {
    public var body: some HTML.View {
        HTML.Element(for: Self.self)
            .disabled(self.disabled)
            .label(self.label)
            .selected(self.selected)
            .value(self.value)
    }

    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Element(for: Self.self) { content() }
            .disabled(self.disabled)
            .label(self.label)
            .selected(self.selected)
            .value(self.value)
    }
}
