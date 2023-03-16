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
        let native = NativeService()
        Task{
            do{
                print("here")
                let info = try await native.getInfo()
                //native.globalInfo = info
                print("VALUE \(info)")
            }catch{
                print("Error in init \(error.localizedDescription)")
            }
            
        }
        
        
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
