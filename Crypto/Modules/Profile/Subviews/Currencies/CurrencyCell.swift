//
//  CurrencyCell.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI

struct CurrencyCell: View {

    let currency: Currency
    let isRedacted: Bool

    var body: some View {
        VStack {
            header
            chart
            footer
        }
        .padding(16)
        .background(Asset.Colors.white.swiftUIColor.opacity(0.12))
        .cornerRadius(18)
    }

    private var header: some View {
        HStack(spacing: 10) {
            Image(currency.image)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)

            VStack(alignment: .leading) {
                Text(currency.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Asset.Colors.white.swiftUIColor)

                Text(currency.symbol.uppercased())
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Asset.Colors.white.swiftUIColor.opacity(0.6))
            }

            Spacer()
        }
        .frame(height: 36)
    }

    @ViewBuilder
    private var chart: some View {
        if isRedacted {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white.opacity(0.2))
                .frame(width: 164, height: 37)
        } else {
            ChartView(
                data: currency.data,
                percentage: currency.percentage,
                frame: CGRect(x: 0, y: 0, width: 164, height: 37)
            )
        }
    }

    private var footer: some View {
        HStack {
            Text(currency.price.priceString)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Asset.Colors.white.swiftUIColor)

            Spacer()

            if currency.percentage > 0 {
                Asset.Images.Common.up.swiftUI
            } else {
                Asset.Images.Common.drop.swiftUI
            }

            Text(currency.percentageString + "%")
                .font(.system(size: 10, weight: .medium))
        }
        .foregroundColor(currency.percentage > 0 ? Asset.Colors.greenMana.swiftUIColor : Asset.Colors.red.swiftUIColor )

    }
    
}
