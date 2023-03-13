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
        
    }
    
    func newCards(_ cards: CardCellData) {
        
    }
    
    func errorRetrieving(_ errorMessage: String) {
        
    }
    
    
}
