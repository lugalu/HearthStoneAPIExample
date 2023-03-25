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
    
    private var content: [CardSimplified] = []
    
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        cardTable.delegate = self
        cardTable.dataSource = self
        
        configureLayout()
        
        presenter?.tryToGetNewData()
    }

    func updateCurrentData(_ newData: [CardSimplified]) {
        print("hey ho")
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

extension CardSearchView: UISearchBarDelegate{
    
}

extension CardSearchView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if content.count < 1 { return }
        
        //go to new Screen
    }
}

extension CardSearchView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count > 0 ? content.count : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCardCell.identifier, for: indexPath) as! SimpleCardCell        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cardCell = cell as! SimpleCardCell
        
        cardCell.configure(withData: content.count > 0 ? content[indexPath.row] : nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
}
