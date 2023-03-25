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
                print(data)
                let cards = try json.decode([String: [CardSimplified]].self, from: data)
                var cardSet: Set<CardSimplified> = Set<CardSimplified>()
                
                for (_,value) in cards{
                    cardSet.formUnion(value)
                }
                print(cardSet.count)
                let sortedCards = Array(cardSet).sorted(by: { $0.name < $1.name })
                presenter?.newCards(sortedCards)
            }catch{
                print("error in request: \(error.localizedDescription)")
            }
        }
    }
    
    func dataRetrieved(_ data: Data) {
        
    }
    
    func failedToRetrieve(_ error: Error) {
        
    }
    
}

