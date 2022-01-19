//
//  Custom Button.swift
//  FinalProject
//
import UIKit

extension UIButton {
    
    open func setupButton(with title: String) {
        backgroundColor = UIColor(#colorLiteral(red: 0.9864818454, green: 0.8801614642, blue: 0.5650160313, alpha: 1))
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 13
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
