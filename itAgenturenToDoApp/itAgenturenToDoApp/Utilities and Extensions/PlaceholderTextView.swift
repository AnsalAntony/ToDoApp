//
//  UIView+Extensions.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 11/11/22.
//

import Foundation
import UIKit

extension UITextView{
    
    func setTextViewPlaceholder(placeHolderText: String) {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeHolderText
        placeholderLabel.font = .systemFont(ofSize: (self.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !self.text.isEmpty
        self.addSubview(placeholderLabel)
        
    }
    
    func checkTextViewPlaceholder() {
        let placeholderLabel = self.viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }
}
