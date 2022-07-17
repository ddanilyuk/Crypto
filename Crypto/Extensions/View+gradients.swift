//
//  View+gradients.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI

extension View {

    // TODO: Refactor?
    func linearGradientForeground(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint
    ) -> some View {
        overlay(
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
        )
        .mask(self)
    }
    
    func radianGradientForeground(
        colors: [Color],
        center: UnitPoint,
        startRadius: CGFloat,
        endRadius: CGFloat
    ) -> some View {
        overlay(
            RadialGradient(
                colors: colors,
                center: center,
                startRadius: startRadius,
                endRadius: endRadius
            )
        )
        .mask(self)
    }
}
