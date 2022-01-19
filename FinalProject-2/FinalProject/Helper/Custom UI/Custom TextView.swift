//
//  Custom TextView.swift
//  FinalProject
//

import UIKit

extension UITextView {
    open func setupTextView() {
        backgroundColor = .clear
        autocorrectionType = .no
        layer.cornerRadius = 13
        layer.borderWidth = 1.1
        layer.borderColor = UIColor(#colorLiteral(red: 0.9864818454, green: 0.8801614642, blue: 0.5650160313, alpha: 1)).cgColor
        clipsToBounds = true
        tintColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
