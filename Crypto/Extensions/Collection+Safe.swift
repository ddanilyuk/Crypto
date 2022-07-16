//
//  Collection+Safe.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

}
