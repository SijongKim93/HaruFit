//
//  UIApplication+Extension.swift
//  HaruFit
//
//  Created by 김시종 on 3/16/25.
//

import UIKit

extension UIApplication {
    func dismissKeyboard() {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

