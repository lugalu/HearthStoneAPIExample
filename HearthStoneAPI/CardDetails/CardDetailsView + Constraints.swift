//
//  CardDetailsView + Constraints.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 04/04/23.
//

import UIKit

extension CardDetailsView{
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = CGSize(width: contentRect.width, height: contentRect.height)
        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
    
    func configureConstraints(){
        addSubviews()
        addScrollConstraints()
        addSegmentConstraints()
        addImageConstraints()
        addStackConstraints()
        view.setNeedsLayout()
    }
    
    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(changeImage)
        scrollView.addSubview(imageView)
        scrollView.addSubview(stackView)
    }
    
    private func addScrollConstraints(){
        let constraints = [
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addSegmentConstraints(){
        let constraints = [
            changeImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            changeImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addImageConstraints(){
        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 375),
            imageView.heightAnchor.constraint(equalToConstant: 518),
            imageView.topAnchor.constraint(equalTo: changeImage.bottomAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addStackConstraints(){
        let constraints = [
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}


