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
    
    func tryToGetNewData() {
        interactor?.requestCardData()
    }
    
    func newCards(_ cards: [CardSimplified]) {
        var cardsCopy = cards
        for i in 0..<cards.count {
            cardsCopy[i].text?.replace("<b>", with: "**")
            cardsCopy[i].text?.replace("</b>", with: "**")
            cardsCopy[i].text?.replace("<i>", with: "*")
            cardsCopy[i].text?.replace("</i>", with: "*")
            cardsCopy[i].text?.replace("[x]", with: "")
            cardsCopy[i].text?.replace("[X]", with: "*")
        }
    
        cardsCopy.removeAll(where: {$0.name.contains("???")})
        
        view?.updateCurrentData(cardsCopy)
    }
    
    func errorRetrieving(_ errorMessage: String) {
        
    }
    
    
}
