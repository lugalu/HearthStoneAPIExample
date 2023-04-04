//
//  CardDetailsConformants.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 02/04/23.
//

import UIKit

protocol CardDetailsViewProtocol: UIViewController {
    var presenter: CardDetailsPresenterProtocol? {get set}
    
    func updateViewWithData()
    
}

protocol CardDetailsPresenterProtocol {
    var view: CardDetailsViewProtocol? {get set}
    var interactor: CardDetailsInteractorProtocol? {get set}
    
    var card: CardSimplified {get set}
    var cardData: CompleteCard? {get set}
    
    func requestCard()
    func cardRequested(_ card: CompleteCard)
    
}

protocol CardDetailsInteractorProtocol {
    var service: CommonDataService & CompleteCardService {get set}
    var presenter: CardDetailsPresenterProtocol? {get set}
    
    func requestCard(withID id: String)
    func cardRequested(retrievedData data: Data)
    func failedToRequestCard()
    
}

protocol CardDetailsRouterProtocol {
    static func getView(withCard card: CardSimplified) -> CardDetailsViewProtocol
}

