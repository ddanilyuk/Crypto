//
//  SwiftGen+Ext.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI

typealias Colors = Asset.Colors

extension ColorAsset {

    var swiftUIColor: SwiftUI.Color {
        SwiftUI.Color(self.color)
    }

}

extension ImageAsset {

    var swiftUI: SwiftUI.Image {
        SwiftUI.Image(uiImage: self.image)
    }

}

extension ImageAsset: Equatable {

    static func == (lhs: ImageAsset, rhs: ImageAsset) -> Bool {
        lhs.name == rhs.name
    }
    
}
