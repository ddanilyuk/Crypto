//
//  LineView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI

struct Line: View {

    var linePath: Path
    var lineShape: Color

    @State private var showAnimation: Bool = false

    var body: some View {
        linePathView
            .onAppear {
                showAnimation = true
            }
            .onDisappear {
                showAnimation = false
            }
    }

    private var linePathView: some View {
        linePath
            .trim(from: 0, to: showAnimation ? 1 : 0)
            .stroke(
                lineShape,
                style: StrokeStyle(
                    lineWidth: 3,
                    lineCap: .round,

                    lineJoin: .round
                )
            )
            .animation(.easeOut(duration: 0.5).delay(0.35), value: showAnimation)
    }

}
