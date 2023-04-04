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
        
        segment.addTarget(CardDetailsView.self, action: #selector(onSelectorUpdate), for: .valueChanged)
        segment.insertSegment(withTitle: "normal", at: 0, animated: true)
        segment.insertSegment(withTitle: "animated", at: 1, animated: true)
        
        segment.isHidden = true
        
        return segment
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        return stack
    }()
    
    lazy var imageGradient: CAGradientLayer =  CAGradientLayer()
    lazy var stackGradient: CAGradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureConstraints()
        presenter?.requestCard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = presenter?.card.name
    }
    
    func updateViewWithData() {
        self.imageView.image = presenter?.cardData?.images.first
        fillStackView()
        if presenter?.cardData?.images.count ?? 0 > 1{
            self.changeImage.isHidden = false
        }
    }
    
    @objc private func onSelectorUpdate(){
        imageView.image = changeImage.selectedSegmentIndex == 0 ? presenter?.cardData?.images.first : presenter?.cardData?.images.last
    }
    
}

extension CardDetailsView: Skeletonable{
    
    func setup() {
        stackGradient.startPoint = CGPoint(x: 0, y: 0.5)
        stackGradient.endPoint = CGPoint(x: 1, y: 0.5)
        stackView.layer.addSublayer(stackGradient)
        
        imageGradient.startPoint = CGPoint(x: 0, y: 0.5)
        imageGradient.endPoint = CGPoint(x: 1, y: 0.5)
        imageView.layer.addSublayer(imageGradient)
        
        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        stackGradient.add(titleGroup, forKey: "backgroundColor")
        
        let yearGroup = makeAnimationGroup(previousGroup: titleGroup)
        imageGradient.add(yearGroup, forKey: "backgroundColor")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackGradient.frame = stackView.bounds
        stackGradient.cornerRadius = stackView.bounds.height/2
        imageGradient.frame = imageView.bounds
        imageGradient.cornerRadius = 5
        
        
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }
    
    
    func configureConstraints(){
        addSubviews()
        addScrollConstraints()
        addSegmentConstraints()
        addImageConstraints()
        addStackConstraints()
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
            changeImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            changeImage.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            changeImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addImageConstraints(){
        let constraints = [
            imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: changeImage.bottomAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addStackConstraints(){
        let constraints = [
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}


extension CardDetailsView{
    
    private enum ViewOptions: String, CaseIterable{
        case cardSet = "Set"
        case type = "Type"
        case faction = "Faction"
        case rarity = "Rarity"
        case health = "Health"
        case armor = "Armor"
        case playerClass = "Class"
        
        func getInfo(cardData card: CompleteCard?) -> (title: String, content: AttributedString){
            var text: String?
    
            switch self{
            case .cardSet:
                text = card?.cardSet
            case .type:
                text = card?.type
            case .faction:
                text = card?.faction
            case .rarity:
                text = card?.rarity
            case .health:
                text = "\(card?.health ?? 0)"
            case .armor:
                text = card?.armor
            case .playerClass:
                text = card?.playerClass
            }
            
            return (title: self.rawValue, content: AttributedString(stringLiteral: text ?? "none"))
        }
    }
    
    func fillStackView(){
        for currentCase in ViewOptions.allCases{
            self.stackView.addArrangedSubview(createContentStack(forOption: currentCase))
        }
    }
    
    private func createContentStack(forOption option: ViewOptions, aligment: NSLayoutConstraint.Axis = .vertical) -> UIStackView{
        let stack = UIStackView()
        let info = option.getInfo(cardData: presenter?.cardData)
        
        let titleLabel = UILabel()
        titleLabel.text = info.title
        
        let textLabel = UILabel()
        textLabel.attributedText = NSAttributedString(info.content)
        
        stack.axis = aligment
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(textLabel)
        
        
        return UIStackView()
    }
}
