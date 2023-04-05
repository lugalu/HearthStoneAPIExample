//
//  CardDetailsView.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 02/04/23.
//

import UIKit

class CardDetailsView: UIViewController, CardDetailsViewProtocol{
    
    var presenter: CardDetailsPresenterProtocol? = nil
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    let changeImage: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.insertSegment(withTitle: "normal", at: 0, animated: true)
        segment.insertSegment(withTitle: "animated", at: 1, animated: true)
        
        segment.isHidden = true
        
        return segment
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.down")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 25
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        changeImage.addTarget(self, action: #selector(onSelectorUpdate), for: .valueChanged)
        configureConstraints()
        presenter?.requestCard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = presenter?.card.name
    }
    
    func updateViewWithData() {
        self.imageView.image = presenter?.cardData?.images.first ?? UIImage(systemName: "x.square")!
        fillStackView()
        if presenter?.cardData?.images.count ?? 0 > 1{
            self.changeImage.isHidden = false
        }
    }
    
    @objc private func onSelectorUpdate(){
        imageView.image = changeImage.selectedSegmentIndex == 0 ? presenter?.cardData?.images.first : presenter?.cardData?.images.last
    }
    
}
