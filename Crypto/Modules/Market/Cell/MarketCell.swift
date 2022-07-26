//
//  MarketCell.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import SwiftUI

struct MarketCell: View {

    var currency: Currency

    var body: some View {
        HStack {
            Image(currency.image)

            VStack(alignment: .leading) {
                Text(currency.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Asset.Colors.white.swiftUIColor)

                Spacer()

                Text(currency.symbol)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)
            }

            Spacer()

            VStack(alignment: .trailing) {

                Text(currency.price.priceString)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)
                Spacer()

                Text(currency.percentageString + "%")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(
                        currency.percentage > 0
                            ? Asset.Colors.greenMana.swiftUIColor
                            : Asset.Colors.red.swiftUIColor
                    )
            }
        }
        .frame(height: 46)
        .padding(20)
    }
}
