//
//  CardDetailsInteractor.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 02/04/23.
//

import UIKit

class CardDetailsInteractor: CardDetailsInteractorProtocol{
    var service: CommonDataService & CompleteCardService
    
    var presenter: CardDetailsPresenterProtocol? = nil
    
    init(service: CommonDataService & CompleteCardService = NativeService()) {
        self.service = service
    }
    
    func requestCard(withID id: String) {
        Task{
            do{
                let data = try await service.requestCompleteCard(withID: id)
                cardRequested(retrievedData: data)
            }catch{
                print(error.localizedDescription)

                failedToRequestCard()
            }
        }
    }
    
    func cardRequested(retrievedData data: Data) {
        Task{
            do{
                var cards = try JSONDecoder().decode([CompleteCard].self, from: data) as [CompleteCard]
                guard var card = cards.first else {
                    failedToRequestCard()
                    return
                }
                
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

                presenter?.cardRequested(card)
                
            }catch{
                print(error.localizedDescription)
                failedToRequestCard()
            }
        }
    }
    
    func failedToRequestCard() {
        print("DEU RUIM")
    }
    
    
}

