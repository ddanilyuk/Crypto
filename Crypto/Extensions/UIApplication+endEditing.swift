//
//  UIApplication+endEditing.swift
//  Crypto
//
//  Created by Denys Danyliuk on 27.07.2022.
//

import UIKit

extension UIApplication {

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}
