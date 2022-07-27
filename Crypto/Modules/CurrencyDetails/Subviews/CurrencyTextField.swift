//
//  CurrencyTextField.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import SwiftUI

struct CurrencyTextField: View {

    @Binding var text: String
    let name: String

    var body: some View {
        VStack {
            HStack {
                TextField("N", text: $text)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Asset.Colors.white.swiftUIColor)
                    .textFieldStyle(PlainTextFieldStyle())
                    .placeholder(when: text.isEmpty) {
                        Text("0.0")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)
                    }
            }

            Rectangle()
                .frame(height: 1)
                .overlayLinearGradient(
                    colors: [
                        Asset.Colors.strawberryDreams.swiftUIColor,
                        Asset.Colors.watermelonJuice.swiftUIColor
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )

            HStack {
                Text("Available: N \(name)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)
                Spacer()
            }
        }
    }
}
