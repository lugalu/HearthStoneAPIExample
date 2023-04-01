//
//  CardBackRouter.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 28/03/23.
//

import Foundation

class CardBackRouter: CardBackRouterProtocol{
    static func getView() -> (CardBackViewProtocol & TabBarConformant)? {
        let view: CardBackViewProtocol & TabBarConformant = CardBackView()
        var presenter: CardBackPresenterProtocol = CardBackPresenter()
        var interactor: CardBackInteractorProtocol = CardBackInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static func getConfigurationView() {
        
    }
    
    
}
