//
//  ProductsCell.swift
//  FinalProject
//
//


import UIKit

class ProductsCell: UICollectionViewCell {
    
    static let id = "ProductsCell"
    
    var cardImageView   = UIImageView()
    var cardTitle  = UILabel()
    var cardDescription = UILabel()
    var cardNameOfSeller = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(cardImageView)
        addSubview(cardTitle)
        addSubview(cardDescription)
        addSubview(cardNameOfSeller)
        configureCardLabel()
        setImageConstraints()
        setLabelConstraints()
        configureProLabel()
        setProLabelConstraints()
        configureImageView()
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCell(card: Product, image: UIImage){
        
        cardTitle.text = card.title
        cardDescription.text = card.description
        cardImageView.image = image
        cardNameOfSeller.text = card.nameOfSeller
        configureCell(.black)
    }
    
    
    func configureCell(_ color: UIColor) {
        self.backgroundColor = color
        self.layer.cornerRadius = 13
        self.layer.shadowColor = color.withAlphaComponent(0.35).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        self.layer.shadowRadius = 13
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 13).cgPath
        self.layer.cornerCurve  = .continuous
        self.backgroundColor = .AppBackground
    }
    private func configureImageView(){
        
        cardImageView.contentMode = .scaleAspectFill
        cardImageView.layer.cornerRadius = 13
        cardImageView.layer.masksToBounds = true
        cardImageView.sizeToFit()
    }
    
    private func configureCardLabel(){
        cardTitle.numberOfLines = 0
        cardTitle.backgroundColor = .clear
        cardTitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 26, weight: .bold))
        cardTitle.textColor = .white
        
        cardDescription.numberOfLines = 0
        cardDescription.backgroundColor = .clear
        cardDescription.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        cardDescription.textColor = .white
        cardDescription.textAlignment = .left
    }
    
    private func setLabelConstraints() {
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        cardTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19).isActive = true
        cardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80).isActive = true
        
        cardDescription.translatesAutoresizingMaskIntoConstraints = false
        cardDescription.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 18).isActive = true
        cardDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19).isActive = true
        cardDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19).isActive = true
        
    }
    private func setImageConstraints() {
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        cardImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        
    }
    private func configureProLabel(){
        cardNameOfSeller.numberOfLines = 0
        cardNameOfSeller.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        cardNameOfSeller.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 13, weight: .bold))
        cardNameOfSeller.textColor = .white
        cardNameOfSeller.textAlignment = .center
        cardNameOfSeller.layer.cornerRadius = 5
        cardNameOfSeller.layer.cornerCurve = .continuous
        cardNameOfSeller.clipsToBounds = true
    }
    
    private func setProLabelConstraints() {
        cardNameOfSeller.translatesAutoresizingMaskIntoConstraints = false
        cardNameOfSeller.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        cardNameOfSeller.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13).isActive = true
        cardNameOfSeller.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
}
