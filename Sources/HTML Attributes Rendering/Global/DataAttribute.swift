///
/// DataAttribute.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    @discardableResult
    public func data(
        _ name: some CustomStringConvertible,
        _ value: some CustomStringConvertible
    ) -> WHATWG_HTML._Attributes<Self> {
        let attribute = DataAttribute(name: name, value: value)
        return self.attribute(attribute.attributeName, attribute.description)
    }

    @discardableResult
    public func data(
        _ value: DataAttribute?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(value?.attributeName ?? "", value?.description)
    }
}
