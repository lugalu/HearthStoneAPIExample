//
//  CardBackView.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 10/03/23.
//

import UIKit

class CardBackView: UIViewController, CardBackViewProtocol, TabBarConformant {
    var presenter: CardBackPresenterProtocol? = nil
    
    var titleKey: String = "Card Back"
    var image: String = "doc.fill"
    
    var cardBackCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170, height: 270)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 15
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardBackCell.self, forCellWithReuseIdentifier: CardBackCell.identifier)
        
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardBackCollection.delegate = self
        cardBackCollection.dataSource = self
        configureConstraints()
        presenter?.tryToGetNewData()
    }
    
    func updateCurrentData() {
        self.cardBackCollection.reloadData()
    }
    
    func showErrorAlert(_ message: String) {
        
    }
    
}


extension CardBackView{
    func configureConstraints(){
        addCollectionConstraints()
    }
    
    private func addCollectionConstraints(){
        view.addSubview(cardBackCollection)
        
        let constraints = [
            cardBackCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            cardBackCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            cardBackCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardBackCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension CardBackView: UICollectionViewDelegate{
    
}

extension CardBackView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter else { return 10}
        return presenter.content.count > 0 ? presenter.content.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardBackCell.identifier, for: indexPath) as! CardBackCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cardCell = cell as! CardBackCell
        guard let presenter else { return }
        cardCell.configure(presenter.content.count > 0 ? presenter.content[indexPath.row] : nil)
        
    }
    
}
