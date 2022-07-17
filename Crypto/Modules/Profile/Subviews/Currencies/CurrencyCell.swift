//
//  CurrencyCell.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI

struct CurrencyCell: View {

    let coin: Currency

    var body: some View {
        VStack {
            header
            image
            footer
        }
        .padding(16)
        .background(Asset.Colors.white.swiftUIColor.opacity(0.12))
        .cornerRadius(18)
    }

    private var header: some View {
        HStack(spacing: 10) {
            Image(coin.image)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)

            VStack(alignment: .leading) {
                Text(coin.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Asset.Colors.white.swiftUIColor)

                Text(coin.symbol.uppercased())
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Asset.Colors.white.swiftUIColor.opacity(0.6))
            }

            Spacer()
        }
        .frame(height: 36)
    }

    private var image: some View {
        // TODO: Chart
        Rectangle()
            .fill(.orange.opacity(0.5))
            .frame(width: 164, height: 37)
    }

    private var footer: some View {
        HStack {
            Text(coin.price)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Asset.Colors.white.swiftUIColor)

            Spacer()

            Asset.Images.Common.drop.swiftUI
                .foregroundColor(Asset.Colors.greenMana.swiftUIColor)

            Text(coin.percentageString + "%")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(Color.red)
        }
    }
    
}
