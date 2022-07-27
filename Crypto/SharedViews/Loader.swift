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
            Color.white.opacity(0.05)

            ProgressView("Loading...")
                .foregroundColor(Asset.Colors.watermelonJuice.swiftUIColor)
                .font(.caption)
                .scaleEffect(1.5)
                .progressViewStyle(.circular)
                .modify { view in
                    if #available(iOS 15.0, *) {
                        view
                            .tint(Asset.Colors.watermelonJuice.swiftUIColor)
                            .controlSize(.large)
                    } else {
                        view
                    }
                }
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
