//
//  CardBackInteractor.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 28/03/23.
//

import Foundation

class CardBackInteractor: CardBackInteractorProtocol{
    var presenter: CardBackPresenterProtocol? = nil
    
    var service: DataProviderService = NativeService()
    
    func requestCardData() {
        
    }
    
    func dataRetrieved(_ data: Data) {
        
    }
    
    func failedToRetrieve(_ error: Error) {
        
    }
    
    
}
