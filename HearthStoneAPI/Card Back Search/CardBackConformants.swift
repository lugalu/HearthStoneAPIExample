//
//  CardBackConformants.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 28/03/23.
//

import UIKit

protocol CardBackViewProtocol: UIViewController{
    var presenter: CardBackPresenterProtocol? {get set}
    func updateCurrentData()
    func showErrorAlert(_ message: String)
}

protocol CardBackInteractorProtocol{
    var presenter: CardBackPresenterProtocol? {get set}
    var service: DataProviderService {get set}

    func requestCardData()
    func dataRetrieved(_ data: Data)
    func failedToRetrieve(_ error: Error)
}

protocol CardBackPresenterProtocol{
    var interactor: CardBackInteractorProtocol? {get set}
    var view: CardBackViewProtocol? {get set}
    var content: [CardBack] { get }

    func tryToGetNewData()
    func newCards(_ cards: [CardBack])
    func appendCardBack(_ card: CardBack)
    func errorRetrieving(_ errorMessage: String)
    func updateFilter(newFilter: String)
}

protocol CardBackRouterProtocol{
    static func getView() -> (CardBackViewProtocol & TabBarConformant)?
    static func getConfigurationView()
}
