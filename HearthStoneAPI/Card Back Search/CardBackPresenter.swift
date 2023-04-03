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
        interactor?.requestCardData()
    }
    
    func newCards(_ cards: [CardBack]) {
        
    }
    
    func appendCardBack(_ card: CardBack) {
        content.append(card)
        content.sort(by: { $0.cardBackId < $1.cardBackId })
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateCurrentData()
        }
    }
    
    func errorRetrieving(_ errorMessage: String) {
        
    }
    
    
}
