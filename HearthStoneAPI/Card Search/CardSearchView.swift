//
//  ViewController.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 09/03/23.
//

import UIKit

class CardSearchView: UIViewController, TabBarConformant, CardSearchViewProtocol {
    var presenter: CardSearchPresenterProtocol?
    var titleKey: String = "Cards"
    var image: String = "doc.text.fill"
    
    var filter: String = ""
    
    private var content: [String] = []
    
    var contentAccess: [String]{
        get{
            return content.filter({ $0.contains(filter) })
        }
    }
    
    
    //UI Components
    var searchBar: UISearchBar = {
       var search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        
        return search
    }()
    
    var cardCollection: CardCollectionComponent = {
        let cell = CardCollectionCell()
        cell.identifier = "CardSearchCell"
        
        let collection = CardCollectionComponent(cellConfiguration: cell)
        
        return collection
    }()
    
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        cardCollection.delegate = self
        cardCollection.dataSource = self
    }

    func updateCurrentData(_ newData: [CardCellData]) {
        
    }
    
    func showErrorAlert(_ message: String) {
        
    }

}

extension CardSearchView: UISearchBarDelegate{
    
}

extension CardSearchView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //ZOOOO
    }
}

extension CardSearchView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCollection.cellConfiguration?.identifier ?? "", for: indexPath) as! CellConformant
        
        struct Temp: CardCellData{
            var cardImage: UIImage = UIImage(systemName: "pencil")!
            var cardTitle: String = "Test"
        }
        
        cell.configure(with: Temp())
        return cell
    }
    
    
}
