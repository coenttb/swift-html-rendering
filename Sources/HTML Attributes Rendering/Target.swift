///
/// Target.swift
/// swift-html
///
/// Created by Coen ten Thije Boonkkamp on 03/04/2025.
///

import HTML_Renderable
import HTML_Standard_Attributes

extension WHATWG_HTML.View {
    /// Add a target attribute to a form to specify where to display the response
    @discardableResult
    package func target(
        _ value: Target?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Target.attribute, value?.description)
    }
}

extension WHATWG_HTML.View {
    /// Add a target attribute to a form to specify where to display the response
    @discardableResult
    package func target(
        _ value: FormTarget?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(FormTarget.attribute, value?.description)
    }
}

extension WHATWG_HTML.View {
    /// Add a target attribute to a form to specify where to display the response
    @discardableResult
    package func target(
        form value: Target?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Target.attribute, value?.description)
    }
}

extension WHATWG_HTML.View {
    /// Add a target attribute to specify where to display the linked URL
    @discardableResult
    public func target(
        anchor value: Target?
    ) -> WHATWG_HTML._Attributes<Self> {
        self.attribute(Target.attribute, value?.description)
    }

    /// Open the link in a new tab or window
    @discardableResult
    @WHATWG_HTML.Builder
    public func openInNewTab(
        withOpener: Bool = false
    ) -> some WHATWG_HTML.View {
        let result = self.target(anchor: .blank)

        if withOpener {
            result
        } else {
            result.rel(.noopener)
        }
    }

    /// Open the link in the parent browsing context
    @discardableResult
    public func openInParent() -> WHATWG_HTML._Attributes<Self> {
        self.target(anchor: .parent)
    }

    /// Open the link in the top-level browsing context
    @discardableResult
    public func openInTop() -> WHATWG_HTML._Attributes<Self> {
        self.target(anchor: .top)
    }
}
