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
        
        imageGradient.removeFromSuperlayer()
        stackGradient.removeFromSuperlayer()
    }
    
    @objc private func onSelectorUpdate(){
        imageView.image = changeImage.selectedSegmentIndex == 0 ? presenter?.cardData?.images.first : presenter?.cardData?.images.last
    }
    
}

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
