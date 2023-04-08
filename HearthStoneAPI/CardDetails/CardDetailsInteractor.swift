//
//  CardDetailsInteractor.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 02/04/23.
//

import UIKit

class CardDetailsInteractor: CardDetailsInteractorProtocol{
    var decoderService: CompleteCardDecoderService
    var service: CommonDataService & CompleteCardService
    
    var presenter: CardDetailsPresenterProtocol? = nil
    
    init(service: CommonDataService & CompleteCardService = NativeService(), decoder: CompleteCardDecoderService = NativeDecoderService()) {
        self.service = service
        self.decoderService = decoder
    }
    
    func requestCard(withID id: String) {
        Task{
            do{
                let data = try await service.requestCompleteCard(withID: id)
                var card = try decoderService.decodeCompleteCard(with: data)
                try await downloadImages(card: &card)
                presenter?.cardRequested(card)
            }catch{
                print(error.localizedDescription)

                failedToRequestCard()
            }
        }
    }
    
    func downloadImages(card: inout CompleteCard) async throws{

        if let imagePath = card.img, let imageURL = URL(string: imagePath) {
            let imageData = try await service.downloadImage(imageURL)

            if let image = UIImage(data: imageData){
                card.insertImages(newImages: [image])
            }
        }

        if let goldPath = card.imgGold, let goldURL = URL(string: goldPath) {
            let goldData = try await service.downloadImage(goldURL)
            
            if let goldImage = UIImage(data: goldData){
                card.insertImages(newImages: [goldImage])
            }
        }
    }
    
    
    func failedToRequestCard() {
        print("DEU RUIM")
    }
    
    
}

