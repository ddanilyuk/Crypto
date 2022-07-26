//
//  Loader.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import SwiftUI

struct Loader: View {

    var body: some View {
        ZStack {
            Color.secondary.opacity(0.3)

            ProgressView("Loading...")
                .foregroundColor(Color.blue)
                .font(.caption)
                .tint(Color.blue)
                .controlSize(.large)
                .scaleEffect(1.5)
                .progressViewStyle(.circular)
        }
        .edgesIgnoringSafeArea(.all)
    }

}

struct Loadable: ViewModifier {

    @Binding var isVisible: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isVisible)
                .zIndex(0)

            if isVisible {
                Loader()
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
                    .zIndex(1)
            }
        }
    }

}

extension View {

    func loadable(_ isVisible: Binding<Bool>) -> some View {
        modifier(Loadable(isVisible: isVisible))
    }

}
