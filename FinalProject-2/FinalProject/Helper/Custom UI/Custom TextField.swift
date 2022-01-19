//
//  Custom TextField.swift
//  FinalProject
//


import UIKit

extension UITextField {
    open func setupTextField(with placeholder: NSAttributedString) {
        backgroundColor = .clear
        autocorrectionType = .no
        layer.cornerRadius = 13
        layer.borderWidth = 1.1
        layer.borderColor = UIColor(#colorLiteral(red: 0.9864818454, green: 0.8801614642, blue: 0.5650160313, alpha: 1)).cgColor
        clipsToBounds = true
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        attributedPlaceholder = placeholder
        tintColor = .label
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
    }

}
