//
//  CardSearchView + Constraints.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 27/03/23.
//

import UIKit

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
