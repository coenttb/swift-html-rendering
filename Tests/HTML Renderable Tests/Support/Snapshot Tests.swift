//
//  Snapshot Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import Testing
import InlineSnapshotTesting

@Suite(
    .serialized,
    .snapshots(record: .never)
)
struct `Snapshot Tests` {}
