//
//  NewsRow.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI

struct NewsRow: View {

    let news: Article

    var body: some View {
        HStack(spacing: 23) {
            Image(news.image)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(6)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(news.title)

                    Circle()
                        .frame(width: 5, height: 5)

                    Text(news.published)
                }
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)

                Text(news.preview)
                    .lineLimit(3)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Asset.Colors.white.swiftUIColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 80)
    }

}
