//
//  ChartData.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import Foundation

struct ChartData: Decodable, Equatable, Hashable {

    var points: [Double]

    init<N: BinaryFloatingPoint>(points: [N]) {
        self.points = points.map { Double($0) }
    }
}
