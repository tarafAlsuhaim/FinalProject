//
//  HomeCellHeaderView.swift
//  FinalProject
//

import UIKit

class HomeCellHeaderView: UICollectionReusableView {
    let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        lbl.textColor = .colorGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
       
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
   
}
