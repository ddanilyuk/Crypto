//
//  View+if.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import SwiftUI

extension View {

    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    func modify<Content>(@ViewBuilder _ transform: (Self) -> Content) -> Content {
        transform(self)
    }

}
