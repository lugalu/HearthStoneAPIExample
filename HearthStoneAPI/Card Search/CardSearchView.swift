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
    
    var cardTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SimpleCardCell.self, forCellReuseIdentifier: SimpleCardCell.identifier)
        
        return table
    }()
    
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        cardTable.delegate = self
        cardTable.dataSource = self
        
        configureLayout()
    }

    func updateCurrentData(_ newData: [CardCellData]) {
        
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

extension CardSearchView: UISearchBarDelegate{
    
}

extension CardSearchView: UITableViewDelegate{
    
}

extension CardSearchView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCardCell.identifier, for: indexPath) as! SimpleCardCell        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cardCell = cell as! SimpleCardCell
        
        cardCell.configure(withData: nil, cellRow: indexPath.row)
    }
}
