//
//  CardSearchView + SearchBarDelegate.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 26/03/23.
//

import UIKit

extension CardSearchView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.updateFilter(newFilter: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
