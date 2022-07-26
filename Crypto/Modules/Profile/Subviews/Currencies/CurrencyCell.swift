//
//  CurrencyCell.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI

struct ChartData: Decodable, Equatable {

    var points: [Double]

    init<N: BinaryFloatingPoint>(points: [N]) {
        self.points = points.map { Double($0) }
    }
}

struct Chart: View {

    var data: ChartData
    var percentage: Double
    var frame: CGRect

    var body: some View {
        Line(
            linePath: path.linePath,
            lineShape: percentage > 0 ? Asset.Colors.greenMana.swiftUIColor : Asset.Colors.red.swiftUIColor
        )
    }

    var stepWidth: CGFloat {
        guard data.points.count >= 2 else {
            return 0
        }
        return frame.size.width / CGFloat(data.points.count - 1)
    }
    var stepHeight: CGFloat {
        let points = data.points
        if let max = points.max(), let min = points.min() {
            return frame.size.height / CGFloat(max - min)
        } else {
            return 0
        }
    }
    var pathPoints: [CGPoint] {
        let points = data.points
        var result: [CGPoint] = []
        guard
            points.count >= 2,
            let offset = points.min()
        else {
            return result
        }
        let firstPoints = CGPoint(
            x: 0,
            y: frame.height - CGFloat(points[0] - offset) * stepHeight
        )
        result.append(firstPoints)
        for pointIndex in 1..<points.count {
            let point = CGPoint(
                x: stepWidth * CGFloat(pointIndex),
                y: frame.height - stepHeight * CGFloat(points[pointIndex] - offset)
            )
            result.append(point)
        }
        return result
    }
    var path: (linePath: Path, backgroundPath: Path) {
        let pathPoints = pathPoints
        var linePath = Path()
        var backgroundPath = Path()
        backgroundPath.move(to: CGPoint(x: 0, y: frame.height))
        linePath.move(to: pathPoints.first!)
        pathPoints.forEach { point in
            linePath.addLine(to: point)
            backgroundPath.addLine(to: point)
        }
        backgroundPath.addLine(to: CGPoint(x: pathPoints.last!.x, y: frame.height))
        backgroundPath.closeSubpath()
        return (linePath: linePath, backgroundPath: backgroundPath)
    }

}


struct CurrencyCell: View {

    let currency: Currency

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

    private var chart: some View {
        Chart(
            data: currency.data,
            percentage: currency.percentage,
            frame: CGRect(x: 0, y: 0, width: 164, height: 37)
        )
        .frame(width: 163, height: 37)
    }

    private var footer: some View {
        HStack {
            Text(currency.price)
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
