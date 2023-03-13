//
//  CardSearchInteractor.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 12/03/23.
//

import Foundation

class CardSearchInteractor: CardSearchInteractorProtocol{
    var presenter: CardSearchPresenterProtocol?
    
    var service: DataProviderService
    
    init(presenter: CardSearchPresenterProtocol, service: DataProviderService = DefaultImplementation()){
        self.presenter = presenter
        self.service = service
    }
    
    func requestCardData() {
        
    }
    
    func dataRetrieved(_ data: Data) {
        
    }
    
    func failedToRetrieve(_ error: Error) {
        
    }
    
    
}

class DefaultImplementation: DataProviderService {
    
}
