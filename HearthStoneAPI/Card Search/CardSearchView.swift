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
    
    var searchBar: UISearchBar = {
       var search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.returnKeyType = .done
        search.enablesReturnKeyAutomatically = false
        
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

    func updateCurrentData() {
        DispatchQueue.main.async {
            self.cardTable.reloadData()
        }
    }
    
    func showErrorAlert(_ message: String) {
        
    }

}




