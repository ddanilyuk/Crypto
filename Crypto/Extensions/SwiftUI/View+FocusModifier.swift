//
//  View+FocusModifier.swift
//  Crypto
//
//  Created by Denys Danyliuk on 27.07.2022.
//

import SwiftUI

@available(iOS 15, *)
struct FocusModifier<T: Hashable>: ViewModifier {

    @FocusState var focused: T?
    @Binding var state: T?
    let equals: T

    init(_ state: Binding<T?>, equals: T){
        self._state = state
        self.equals = equals
    }

    func body(content: Content) -> some View {
        content
            .focused($focused, equals: equals)
            .onChange(of: focused) { newValue in
                state = newValue
            }
            .onChange(of: state) { newValue in
                focused = newValue
            }
    }

}

@available(iOS 15, *)
extension View{

    func focusMe<T: Hashable>(state: Binding<T?>, equals: T) -> some View {
        modifier(FocusModifier(state, equals: equals))
    }

}
