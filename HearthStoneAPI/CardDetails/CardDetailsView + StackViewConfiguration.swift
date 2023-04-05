//
//  CardDetailsView + StackViewCondiguration.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 04/04/23.
//

import UIKit

extension CardDetailsView{
    func fillStackView(){
        for currentCase in CompleteCard.CodingKeys.allCases{
            guard let newStack = createContentStack(forOption: currentCase) else { continue }
            self.stackView.addArrangedSubview(newStack)
        }
        stackView.layoutIfNeeded()
        imageView.layoutIfNeeded()
        scrollView.layoutIfNeeded()
        view.setNeedsUpdateConstraints()
        view.setNeedsLayout()
        

    }
    
    private func createContentStack(forOption option: CompleteCard.CodingKeys, aligment: NSLayoutConstraint.Axis = .horizontal) -> UIStackView?{
        let stack = UIStackView()
        
        guard let info = option.getInfo(cardData: presenter?.cardData) else { return nil}
        
        let titleLabel = UILabel()
        titleLabel.text = info.title
        titleLabel.textAlignment = .left
        
        let textLabel = UILabel()
        textLabel.attributedText = NSAttributedString(info.content)
        textLabel.textAlignment = .left
        textLabel.numberOfLines = .max
        
        stack.axis = aligment
        stack.distribution = .fillEqually
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(textLabel)
        
        return stack
    }
}
