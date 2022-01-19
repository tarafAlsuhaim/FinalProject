//
//  SectionHeader.swift
//  FinalProject
//

import UIKit



class ProfileSectionHeader: UICollectionReusableView {
    
    static var reuseIdentifier = "ProfileSectionHeader"
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.57)
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Your Advertisements"
        return lbl
    }()

     override init(frame: CGRect) {
         super.init(frame: frame)

         addSubview(label)

         label.translatesAutoresizingMaskIntoConstraints = false
         label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
         label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
         label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

