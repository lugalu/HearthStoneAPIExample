//
//  CardBackInteractor.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 28/03/23.
//

import UIKit

class CardBackInteractor: CardBackInteractorProtocol{
    var presenter: CardBackPresenterProtocol? = nil
    
    var service: (CardBacksService & CommonDataService)
    var decoderService: CardBackDecoderService
      
    init(service: (CardBacksService & CommonDataService) = NativeService(), decoder: CardBackDecoderService = NativeDecoderService()) {
        self.service = service
        self.decoderService = decoder
    }
    
    func requestCardData() {
        Task{
            do{
                let data = try await service.requestCardBacks()
                var cards = try decoderService.decodeCardBacks(with: data)
                await downloadImages(&cards)
            }catch{
                self.failedToRetrieve(error)
            }
            
        }
    }
    
    
    func downloadImages(_ cards : inout [CardBack]) async{
        for i in 0..<cards.count{
            do{
                defer{
                    if cards[i].image != nil || cards[i].animatedImage != nil {
                        self.presenter?.appendCardBack(cards[i])
                    }
                }
            
                guard let imgPath = cards[i].img, let url = URL(string: imgPath) else { continue }
                let imgData = try await self.service.downloadImage(url)
                guard let image = UIImage(data: imgData) else { continue }
                cards[i].insertImage(image)
                    
                
                guard let animatedPath = cards[i].imgAnimated, let animURL = URL(string: animatedPath), animatedPath != imgPath else { continue }
                let animImgData = try await self.service.downloadImage(animURL)
                guard let animatedImage = UIImage(data: animImgData) else { continue }
                cards[i].insertImage(animatedImage, isAnimated: true)
                
            }catch{
                continue
            }
        }
        
    }
    
    func failedToRetrieve(_ error: Error) {
        print(error.localizedDescription)
    }
    
    
}
