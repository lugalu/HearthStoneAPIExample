//
//  CardBackPresenter.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 28/03/23.
//

import Foundation

class CardBackPresenter: CardBackPresenterProtocol{
    var interactor: CardBackInteractorProtocol? = nil
    
    var view: CardBackViewProtocol? = nil

    var content: [CardBack] = []
    
    func tryToGetNewData() {
        
    }
    
    func newCards(_ cards: [CardBack]) {
        
    }
    
    func errorRetrieving(_ errorMessage: String) {
        
    }
    
    func updateFilter(newFilter: String) {
        
    }
    
    
}
