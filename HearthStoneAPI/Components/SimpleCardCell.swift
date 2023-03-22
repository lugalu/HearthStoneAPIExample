//
//  SimpleCardCell.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 21/03/23.
//

import UIKit

class SimpleCardCell: UITableViewCell {

    static let identifier = "SimpleCardCell"
    
    //skeleton
    private var gradientSet: [[CGColor]] = []
    private let gradient = CAGradientLayer()
    private var currentGradient: Int = 0
    private let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    private let gray = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7).cgColor
    

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
    
    func configure(withData card: CardSimplified?, cellRow: Int){
        if let card{
            configureDataConstraints()
            nameLabel.text = card.name
            effectLabel.text = card.text ?? ""
            return
        }
        
        configureSkeleton(cellNumber: cellRow)
        
    }
    
    
    private func configureDataConstraints(){
        skeletonView.removeFromSuperview()
        
        addSubview(nameLabel)
        addSubview(effectLabel)
        
        
        let nameConstraints = [
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        let effectConstraints = [
            effectLabel.topAnchor.constraint(equalTo: self.topAnchor),
            effectLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            effectLabel.leftAnchor.constraint(equalTo: self.centerXAnchor),
            effectLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(effectConstraints)
        
    }
    
    
    
    private func configureSkeleton(cellNumber: Int){
        nameLabel.removeFromSuperview()
        effectLabel.removeFromSuperview()
        
        self.addSubview(skeletonView)
        
        let skeletonConstraints = [
            skeletonView.topAnchor.constraint(equalTo: self.topAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            skeletonView.leftAnchor.constraint(equalTo: self.leftAnchor),
            skeletonView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(skeletonConstraints)
        
        createGradient(cellNumber: cellNumber)
    }
    
    private func createGradient(cellNumber: Int){
        
        gradientSet.append([gray,black,black,black,black,black,black])
        gradientSet.append([gray,gray,black,black,black,black,black])
        gradientSet.append([black,gray,gray,black,black,black,black])
        gradientSet.append([black,black,gray,gray,black,black,black])
        gradientSet.append([black,black,black,gray,gray,black,black])
        gradientSet.append([black,black,black,black,gray,gray,black])
        gradientSet.append([black,black,black,black,black,gray,gray])
        
        gradient.frame = self.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x: 0, y: 0.025)
        gradient.endPoint = CGPoint(x: 1, y: 0.1)
        gradient.drawsAsynchronously = true
        self.layer.addSublayer(gradient)

        DispatchQueue.main.asyncAfter(deadline: .now() + (Double(cellNumber) * 0.125)) {
            self.animateGradient()
        }
        
    
        
    }
    
    private func animateGradient(){
        if currentGradient >= gradientSet.count - 1 {
            currentGradient = -1
        }
        currentGradient += 1
         
        let gradientChangeAnimation = CABasicAnimation(keyPath: "color")

        gradientChangeAnimation.duration = 0.3
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = .forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientChangeAnimation.delegate = self
        gradientChangeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
        
    }
}

extension SimpleCardCell: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
                gradient.colors = gradientSet[currentGradient]
                animateGradient()
            }
    }
}
