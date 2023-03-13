//
//  CardSearchConformants.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 12/03/23.
//

import UIKit

protocol CardSearchViewProtocol: UIViewController{
    var presenter: CardSearchPresenterProtocol? {get set}
    
    func updateCurrentData(_ newData: [CardCellData])
    func showErrorAlert(_ message: String)
}

protocol CardSearchInteractorProtocol{
    var presenter: CardSearchPresenterProtocol? {get set}
    var service: DataProviderService {get set}
    
    func requestCardData()
    func dataRetrieved(_ data: Data)
    func failedToRetrieve(_ error: Error)
}

protocol CardSearchPresenterProtocol{
    var interactor: CardSearchInteractorProtocol? {get set}
    var view: CardSearchViewProtocol? {get set}
    
    func tryToGetNewData()
    func newCards(_ cards: CardCellData)
    func errorRetrieving(_ errorMessage: String)
}

protocol CardSearchRouterProtocol{
    static func getView() -> (CardSearchViewProtocol & TabBarConformant)?
    static func getCardDetails() -> CardDetailsViewProtocol?
    static func getConfigurationView()
}

protocol CardDetailsViewProtocol{
    
}


protocol DataProviderService{
    
}
