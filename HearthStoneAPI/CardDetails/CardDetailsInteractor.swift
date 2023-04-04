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
                var card = try JSONDecoder().decode(CompleteCard.self, from: data)
                defer {
                    presenter?.cardRequested(card)
                }
                
                guard let imagePath = card.img, let imageURL = URL(string: imagePath) else { return }
                let imageData = try await service.downloadImage(imageURL)
                
                if let image = UIImage(data: imageData){
                    card.insertImages(newImages: [image])
                }
                
                guard let goldPath = card.imgGold, goldPath != imagePath, let goldURL = URL(string: goldPath) else{ return }
                let goldData = try await service.downloadImage(goldURL)
            
                if let goldImage = UIImage(data: goldData){
                    card.insertImages(newImages: [goldImage])
                }
                
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
