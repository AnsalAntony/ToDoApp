//
//  UIView+Extensions.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 11/11/22.
//

import Foundation
import UIKit

extension UIView {
    func setBackgroundShadow(setColor: UIColor) {
        //MARK:- Shade a view
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1.0)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = setColor.cgColor
        self.layer.masksToBounds = false
    }
}
