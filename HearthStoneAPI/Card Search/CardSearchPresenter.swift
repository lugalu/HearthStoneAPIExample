//
//  CardSearchPresenter.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 12/03/23.
//

import Foundation

class CardSearchPresenter: CardSearchPresenterProtocol{
    var interactor: CardSearchInteractorProtocol? = nil
    var view: CardSearchViewProtocol? = nil
    
    private var content: [CardSimplified] = []
    var filteredContent: [CardSimplified]{
        get{
            if filter.trimmingCharacters(in: .whitespaces).isEmpty{
                return content
            }
            
            return content.filter({$0.name.contains(filter)})
        }
    }
    var filter: String = ""
    
    func tryToGetNewData() {
        interactor?.requestCardData()
    }
    
    func newCards(_ cards: [CardSimplified]) {
        var cardsCopy = cards
        for i in 0..<cards.count {
            cardsCopy[i].text?.translateMarkdown()
        }
    
        cardsCopy.removeAll(where: {$0.name.contains("???")})
        
        self.content = cardsCopy
        view?.updateCurrentData()
    }
    
    func errorRetrieving(_ errorMessage: String) {
        
    }
    
    func updateFilter(newFilter: String = "") {
        self.filter = newFilter
        view?.updateCurrentData()
    }
    
    
}

