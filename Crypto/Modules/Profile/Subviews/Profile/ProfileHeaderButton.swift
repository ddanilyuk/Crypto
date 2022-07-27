//
//  ProfileHeaderButton.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI

struct ProfileHeaderButton: View {

    let title: String
    let action: () -> Void

    var body: some View {
        Button(
            action: { action() },
            label: {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Asset.Colors.white.swiftUIColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
            }
        )
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
                        endPoint: .leading
                    ),
                    lineWidth: 1
                )
        )
    }

}
