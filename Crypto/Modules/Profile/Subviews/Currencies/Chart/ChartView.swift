//
//  ChartView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import SwiftUI

struct ChartView: View {

    let data: ChartData
    let percentage: Double
    let frame: CGRect

    var body: some View {
        LineView(
            linePath: path.linePath,
            lineShape: percentage > 0
                ? Asset.Colors.greenMana.swiftUIColor
                : Asset.Colors.red.swiftUIColor
        )
        .frame(width: frame.width, height: frame.height)
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
