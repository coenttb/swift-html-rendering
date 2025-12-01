//
//  PopoverTargetAction.swift
//  swift-html-css-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 10/04/2025.
//

import HTML_Standard_Attributes
import HTML_Renderable

extension HTML.View {

    /// Sets the popovertargetaction attribute on an element
    @discardableResult
    package func popoverTargetAction(
        _ value: PopoverTargetAction?
    ) -> HTML._Attributes<Self> {
        self.attribute(PopoverTargetAction.attribute, value?.description)
    }
}
