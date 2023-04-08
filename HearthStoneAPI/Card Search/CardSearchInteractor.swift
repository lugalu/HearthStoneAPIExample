//
//  CardSearchInteractor.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 12/03/23.
//

import UIKit

class CardSearchInteractor: CardSearchInteractorProtocol{
    var presenter: CardSearchPresenterProtocol?
    
    var dataService: (SimpleCardsService & CommonDataService)
    var decoderService: SimpleCardDecoderService
    
    init(presenter: CardSearchPresenterProtocol, service:  (SimpleCardsService & CommonDataService) = NativeService(), decoder: SimpleCardDecoderService = NativeDecoderService()){
        self.presenter = presenter
        self.dataService = service
        self.decoderService = decoder
    }
    
    func requestCardData() {
        Task{
            do{
                let data = try await dataService.requestCards()
                let cards = try decoderService.decodeCards(with: data)
                presenter?.newCards(cards)
            }catch{
                failedToRetrieve(DataErrors.downloadFail)
            }
        }
    }
    
    func failedToRetrieve(_ error: Error) {
        print("failed \n\(error) \n\(error.localizedDescription)")
        presenter?.errorRetrieving(error.localizedDescription)
    }
    
}

