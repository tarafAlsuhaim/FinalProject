//
//  BlurEffect.swift
//  FinalProject
//


import UIKit

extension UIView{
    
     func modalBlurEffect() -> UIVisualEffectView{
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
}
