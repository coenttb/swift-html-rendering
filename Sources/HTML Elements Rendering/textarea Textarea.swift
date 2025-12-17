//
//  File.swift
//  swift-html-pointfree
//
//  Created by Coen ten Thije Boonkkamp on 05/04/2025.
//

import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML_Standard_Elements.Textarea {
    public func callAsFunction(
        @WHATWG_HTML.Builder _ content: () -> some WHATWG_HTML.View = { WHATWG_HTML.Empty() }
    ) -> some WHATWG_HTML.View {
        WHATWG_HTML.Element.Tag(for: Self.self) { content() }
            .autocapitalize(self.autocapitalize)
            .autocomplete(self.autocomplete)
            .autocorrect(self.autocorrect)
            .autofocus(self.autofocus)
            .cols(self.cols)
            .dirname(self.dirname)
            .disabled(self.disabled)
            .form(self.form)
            .maxlength(self.maxlength)
            .minlength(self.minlength)
            .name(self.name)
            .placeholder(self.placeholder)
            .readonly(self.readonly)
            .required(self.required)
            .rows(self.rows)
            .spellcheck(self.spellcheck)
            .wrap(self.wrap)
    }
}
