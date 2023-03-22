//
//  CardSearchInteractor.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 12/03/23.
//

import UIKit

class CardSearchInteractor: CardSearchInteractorProtocol{
    var presenter: CardSearchPresenterProtocol?
    
    var service: DataProviderService
    
    init(presenter: CardSearchPresenterProtocol, service: DataProviderService = NativeService()){
        self.presenter = presenter
        self.service = service
        Task{
            do{
                let info = try await self.service.getInfo()
                self.service.globalInfo = info
            }catch{
                print("Error in init \(error.localizedDescription)")
            }
            
        }
        
    }
    
    func requestCardData() {
        Task{
            do{
                let data = try await service.requestCards()
                let json = JSONDecoder()
                let cards = try json.decode([CardSimplified].self, from: data) as [CardSimplified]
            }catch{
                
            }
        }
    }
    
    func dataRetrieved(_ data: Data) {
        
    }
    
    func failedToRetrieve(_ error: Error) {
        
    }
    
}



