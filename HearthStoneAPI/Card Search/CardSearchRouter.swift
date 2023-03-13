//
//  CardSearchRouter.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 12/03/23.
//

import Foundation

class CardSearchRouter: CardSearchRouterProtocol{
    static func getView() -> (CardSearchViewProtocol & TabBarConformant)? {
        let view: CardSearchViewProtocol & TabBarConformant = CardSearchView()
        var presenter: CardSearchPresenterProtocol = CardSearchPresenter()
        let interactor: CardSearchInteractorProtocol = CardSearchInteractor(presenter: CardSearchPresenter())
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        
        return view
    }
    
    static func getCardDetails() -> CardDetailsViewProtocol? {
        //TODO: Elaborate this
        return Temp()
    }
    
    static func getConfigurationView() {
        //TODO: MAke this
    }
    
    
}


class Temp: CardDetailsViewProtocol{
    
}
