//
//  LoadingView.swift
//  FinalProject
//

import UIKit

fileprivate var someView: UIView?

extension UIViewController {
    
    func showUIActivityIndicator() {
        someView = UIView(frame: self.view.frame)
        someView?.backgroundColor = UIColor.white.withAlphaComponent(0.56)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = UIColor(#colorLiteral(red: 0.9864818454, green: 0.8801614642, blue: 0.5650160313, alpha: 1))
        spinner.center = someView!.center
        spinner.startAnimating()
        someView?.addSubview(spinner)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        view.addSubview(someView!)
    }
    
    func hideUIActivityIndicator() {
        someView?.removeFromSuperview()
        someView = nil
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
