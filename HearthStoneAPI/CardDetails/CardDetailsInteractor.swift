//
//  CardDetailsInteractor.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 02/04/23.
//

import Foundation

class CardDetailsInteractor: CardDetailsInteractorProtocol{
    var service: CommonDataService
    
    var presenter: CardDetailsPresenterProtocol? = nil
    
    init(service: CommonDataService = NativeService()) {
        self.service = service
    }
    
    func requestCard(withID: String) {
        Task{
            
        }
    }
    
    func cardRequested(retrievedData data: Data) {
        
    }
    
    func failedToRequestCard() {
        
    }
    
    
}
