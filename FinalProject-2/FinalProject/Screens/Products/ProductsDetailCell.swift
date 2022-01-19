//
//  ProductsDetailCell.swift
//  FinalProject
//
//

import UIKit

class ProductsDetailCell: UITableViewCell {

    static let id = "ProductsDetailCell"
    let nameOfUser: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.backgroundColor = .clear
        lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 11, weight: .bold))
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let comment: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.backgroundColor = .clear
        lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 11, weight: .regular))
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(nameOfUser)
        addSubview(comment)
        
        NSLayoutConstraint.activate([
        
            nameOfUser.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameOfUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameOfUser.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            comment.topAnchor.constraint(equalTo: nameOfUser.bottomAnchor, constant: 5),
            comment.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            comment.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        
        ])
    }
    
}
