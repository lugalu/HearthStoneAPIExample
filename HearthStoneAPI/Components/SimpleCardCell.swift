//
//  SimpleCardCell.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 21/03/23.
//

import UIKit

class SimpleCardCell: UITableViewCell, Skeletonable {
    
    static let identifier = "SimpleCardCell"
    
    lazy var nameGradient: CAGradientLayer =  CAGradientLayer()
    lazy var effectGradient: CAGradientLayer = CAGradientLayer()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        
        return label
    }()
    
    let effectLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        
        return label
    }()
    
    func configure(withData card: CardSimplified? ) {
        setup()
        configureDataConstraints()
        if let card {
            nameLabel.text = card.name
            do {
                let attributedText = try NSAttributedString(markdown: card.text ?? "")
                effectLabel.attributedText = attributedText
            }catch {
                effectLabel.attributedText = NSAttributedString(string: card.text ?? "")
            }
            
            nameGradient.removeFromSuperlayer()
            effectGradient.removeFromSuperlayer()
            return
        }
    }
    
    
    private func configureDataConstraints(){
        addSubview(nameLabel)
        addSubview(effectLabel)
        
        
        let nameConstraints = [
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        let effectConstraints = [
            effectLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            effectLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            effectLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 64),
            effectLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(effectConstraints)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameGradient.frame = nameLabel.bounds
        nameGradient.cornerRadius = nameLabel.bounds.height/2
        
        effectGradient.frame = effectLabel.bounds
        effectGradient.cornerRadius = effectLabel.bounds.height / 2
        
    }
    
    func setup() {
        
        nameGradient.startPoint = CGPoint(x: 0, y: 0.5)
        nameGradient.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabel.layer.addSublayer(nameGradient)
        
        effectGradient.startPoint = CGPoint(x: 0, y: 0.5)
        effectGradient.endPoint = CGPoint(x: 1, y: 0.5)
        effectLabel.layer.addSublayer(effectGradient)
        
        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        nameGradient.add(titleGroup, forKey: "backgroundColor")
        
        let yearGroup = makeAnimationGroup(previousGroup: titleGroup)
        effectGradient.add(yearGroup, forKey: "backgroundColor")
    }
    

    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameGradient.removeFromSuperlayer()
        effectGradient.removeFromSuperlayer()
        
    }
    
    
}



