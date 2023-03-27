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
    
    var content: [CardSimplified] = []
    
    var filteredContent: [CardSimplified]{
        get{
            if let text = self.searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty{
                return content.filter({ $0.name.contains(text)})
            }
            
            return content
        }
    }
    
    var searchBar: UISearchBar = {
       var search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        
        return search
    }()
    
    var cardTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SimpleCardCell.self, forCellReuseIdentifier: SimpleCardCell.identifier)
        table.rowHeight = 50
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        cardTable.delegate = self
        cardTable.dataSource = self
        
        configureLayout()
        
        presenter?.tryToGetNewData()
    }

    func updateCurrentData(_ newData: [CardSimplified]) {
        self.content = newData
        DispatchQueue.main.async {
            self.cardTable.reloadData()
        }
    }
    
    func showErrorAlert(_ message: String) {
        
    }

}

extension CardSearchView {
    
    func configureLayout(){
        addSearchConstraints()
        addTableConstraints()
        
    }
    
    private func addSearchConstraints(){
        view.addSubview(searchBar)
        
        let constraints = [
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addTableConstraints(){
        view.addSubview(cardTable)
        
        let constraints = [
            cardTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            cardTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}



