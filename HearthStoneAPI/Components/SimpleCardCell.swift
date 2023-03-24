    //
    //  SimpleCardCell.swift
    //  HearthStoneAPI
    //
    //  Created by Lugalu on 21/03/23.
    //

    import UIKit

    class SimpleCardCell: UITableViewCell {

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
        
        let skeletonView:UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        func configure(withData card: CardSimplified? ){
            setup()
            configureDataConstraints()
            if let card{
                nameLabel.text = card.name
                effectLabel.text = card.text ?? " "
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
                //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
                
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
        
        func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
                let animDuration: CFTimeInterval = 1.5
                let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
                anim1.fromValue = UIColor.lightGray.cgColor
                anim1.toValue = UIColor.darkGray.cgColor
                anim1.duration = animDuration
                anim1.beginTime = 0.0

                let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
                anim2.fromValue = UIColor.darkGray.cgColor
                anim2.toValue = UIColor.lightGray.cgColor
                anim2.duration = animDuration
                anim2.beginTime = anim1.beginTime + anim1.duration

                let group = CAAnimationGroup()
                group.animations = [anim1, anim2]
                group.repeatCount = .greatestFiniteMagnitude // infinite
                group.duration = anim2.beginTime + anim2.duration
                group.isRemovedOnCompletion = false

                if let previousGroup = previousGroup {
                    // Offset groups by 0.33 seconds for effect
                    group.beginTime = previousGroup.beginTime + 0.33
                }

                return group
            }
        
       
        
    }
