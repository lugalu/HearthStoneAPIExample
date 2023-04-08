//
//  CardSearchConformants.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 12/03/23.
//

import UIKit

protocol CardSearchViewProtocol: UIViewController{
    var presenter: CardSearchPresenterProtocol? {get set}
    
    func updateCurrentData()
    func showErrorAlert(_ message: String)
}

protocol CardSearchInteractorProtocol{
    var presenter: CardSearchPresenterProtocol? {get set}
    var dataService: (SimpleCardsService & CommonDataService) {get set}
    var decoderService: SimpleCardDecoderService {get set}
    
    func requestCardData()
    func failedToRetrieve(_ error: Error)
}

protocol CardSearchPresenterProtocol{
    var interactor: CardSearchInteractorProtocol? {get set}
    var view: CardSearchViewProtocol? {get set}
    var filteredContent: [CardSimplified] { get }
    
    func tryToGetNewData()
    func newCards(_ cards: [CardSimplified])
    func errorRetrieving(_ errorMessage: String)
    func updateFilter(newFilter: String)
}

protocol CardSearchRouterProtocol{
    static func getView() -> (CardSearchViewProtocol & TabBarConformant)?
}



