///
/// Lang.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 02/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Sets the lang attribute with a language tag
    @discardableResult
    public func lang(
        _ language: String
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Lang.attribute, language)
    }

    /// Sets the lang attribute with separate components
    @discardableResult
    public func lang(
        language: String,
        script: String? = nil,
        region: String? = nil
    ) -> WHATWG_HTML._Attributes<Self> {
        self.lang(Lang(language: language, script: script, region: region))
    }

    /// Sets the lang attribute using a Lang struct
    @discardableResult
    public func lang(
        _ attribute: Lang
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Lang.attribute, attribute.description)
    }
}
