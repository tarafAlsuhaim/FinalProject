//
//  HomeCollectionViewCell.swift
//  FinalProject
//
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static var id = "CollectionViewCell"
    //MARK: - icon
    lazy var icon: UIImageView = {
//        $0.image = UIImage(systemName: "person")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    //MARK: - title
     lazy var title: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        $0.textAlignment = .left
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    //MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 6
        setupUIElements()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -
    private func setupUIElements() {
        addSubview(icon)
        addSubview(title)
    }
    //MARK: - Constraint
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            icon.topAnchor.constraint(equalTo: title.topAnchor,constant: 10),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 120),
            icon.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}
