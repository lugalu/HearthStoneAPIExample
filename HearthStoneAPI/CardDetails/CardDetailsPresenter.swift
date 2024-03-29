//
//  CardDetailsPresenter.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 02/04/23.
//

import Foundation

class CardDetailsPresenter: CardDetailsPresenterProtocol{
    var view: CardDetailsViewProtocol? = nil
    var interactor: CardDetailsInteractorProtocol? = nil
    
    var card: CardSimplified
    var cardData: CompleteCard? = nil
    
    init(card: CardSimplified){
        self.card = card
    }
    
    func requestCard() {
        interactor?.requestCard(withID: card.cardId)
    }
    
    func cardRequested(_ card: CompleteCard) {
        self.cardData = card
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateViewWithData()
        }
    }
    
    
}
