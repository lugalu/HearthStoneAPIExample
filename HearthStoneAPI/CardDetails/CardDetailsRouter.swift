//
//  CardDetailsRouter.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 02/04/23.
//

import Foundation

class CardDetailsRouter: CardDetailsRouterProtocol{
    static func getView(withCard card: CardSimplified) -> CardDetailsViewProtocol {
        let view: CardDetailsViewProtocol = CardDetailsView()
        var presenter: CardDetailsPresenterProtocol = CardDetailsPresenter(card: card)
        var interactor: CardDetailsInteractorProtocol = CardDetailsInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    

}
