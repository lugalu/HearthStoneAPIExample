//
//  CardCollectionCell.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 13/03/23.
//

import UIKit

class CardBackCell: UICollectionViewCell, Skeletonable{
    static let identifier = "CardBackCell"
    
    lazy var imageGradient: CAGradientLayer =  CAGradientLayer()
    lazy var nameGradient: CAGradientLayer = CAGradientLayer()
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "pencil")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        return label
    }()
    
    func configure(_ cardBack: CardBack? = nil){
        setup()
        configureConstraints()
        
        if let cardBack {
            nameLabel.text = cardBack.name
            imageView.image = cardBack.image
            
            imageGradient.removeFromSuperlayer()
            nameGradient.removeFromSuperlayer()
            return
        }
        
    }

    
}

extension CardBackCell{
    
    func configureConstraints(){
        configureImageConstraints()
        configureNameLabelConstraints()
    }
    
    
    private func configureImageConstraints(){
        addSubview(imageView)
        
        let imageConstraints = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
    }
    
    private func configureNameLabelConstraints() {
        addSubview(nameLabel)

        let nameConstraints = [
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16),
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
    }
    
    func setup() {
        
        nameGradient.startPoint = CGPoint(x: 0, y: 0.5)
        nameGradient.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabel.layer.addSublayer(nameGradient)
        
        imageGradient.startPoint = CGPoint(x: 0, y: 0.5)
        imageGradient.endPoint = CGPoint(x: 1, y: 0.5)
        imageView.layer.addSublayer(imageGradient)
        
        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        nameGradient.add(titleGroup, forKey: "backgroundColor")
        
        let yearGroup = makeAnimationGroup(previousGroup: titleGroup)
        imageGradient.add(yearGroup, forKey: "backgroundColor")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameGradient.frame = nameLabel.bounds
        nameGradient.cornerRadius = nameLabel.bounds.height/2
        
        imageGradient.frame = imageView.bounds
        imageGradient.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameGradient.removeFromSuperlayer()
        imageGradient.removeFromSuperlayer()
        
    }
    
    
}
