//
//  HomeCell.swift
//  FinalProject
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    static let id = "123456"
    
    var cardImageView   = UIImageView()
    var cardTitleLabel  = UILabel()
    var proLabel = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(cardImageView)
        addSubview(cardTitleLabel)
        addSubview(proLabel)
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

    func setCell(card: HomeData){
        
        cardImageView.image = card.image
        cardTitleLabel.text = card.subCategory
        proLabel.text = card.category
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
        self.backgroundColor = .clear
    }
    private func configureImageView(){
        
        cardImageView.contentMode = .scaleAspectFill
        cardImageView.layer.cornerRadius = 13
        cardImageView.layer.masksToBounds = true
        cardImageView.sizeToFit()
    }
    
    private func configureCardLabel(){
        cardTitleLabel.numberOfLines                = 0
        cardTitleLabel.backgroundColor              = .clear
        cardTitleLabel.font                         = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 26, weight: .bold))
        cardTitleLabel.textColor                    = .white
    }
    
    private func setLabelConstraints() {
        cardTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cardTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19).isActive = true
        cardTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80).isActive = true
        
    }
    private func setImageConstraints() {
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        cardImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        
    }
    private func configureProLabel(){
        proLabel.numberOfLines                = 0
        proLabel.backgroundColor              = UIColor.black.withAlphaComponent(0.25)
        proLabel.font                         = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 13, weight: .bold))
        proLabel.textColor                    = .white
        proLabel.textAlignment                = .center
        proLabel.layer.cornerRadius           = 5
        proLabel.layer.cornerCurve            = .continuous
        proLabel.clipsToBounds                = true
    }
    
    private func setProLabelConstraints() {
        proLabel.translatesAutoresizingMaskIntoConstraints = false
        proLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        proLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13).isActive = true
        proLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        proLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
    }
    
}
