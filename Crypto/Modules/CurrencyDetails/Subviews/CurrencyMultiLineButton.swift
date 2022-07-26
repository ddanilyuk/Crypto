//
//  CurrencyMultiLineButton.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import SwiftUI

struct CurrencyMultiLineButton: View {

    let title: String
    let subtitle: String

    var body: some View {
        Button {
            print(title)
        } label: {
            VStack(spacing: 10) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                Text(subtitle)
                    .font(.system(size: 12, weight: .regular))

            }
            .foregroundColor(Asset.Colors.white.swiftUIColor)
            .frame(maxWidth: .infinity)
            .frame(height: 70)
        }
        .background(Asset.Colors.latinCharm.swiftUIColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [
                            Asset.Colors.watermelonJuice.swiftUIColor,
                            Asset.Colors.strawberryDreams.swiftUIColor
                        ],
                        startPoint: .trailing,
                        endPoint: .leading),
                    lineWidth: 1
                )
        )
    }
}
