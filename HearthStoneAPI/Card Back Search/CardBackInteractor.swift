//
//  CardBackInteractor.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 28/03/23.
//

import UIKit

class CardBackInteractor: CardBackInteractorProtocol{
    var presenter: CardBackPresenterProtocol? = nil
    
    var service: DataProviderService
      
    init(service: DataProviderService = NativeService()) {
        self.service = service
    }
    
    func requestCardData() {
        Task{
            do{
                let data = try await service.requestCardBacks()
                self.dataRetrieved(data)
            }catch{
                self.failedToRetrieve(error)
            }
            
        }
    }
    
    func dataRetrieved(_ data: Data) {
        do{
            let json = JSONDecoder()
            let cards = try json.decode([CardBack].self, from: data) as [CardBack]
            downloadImages(cards)
        }catch{
            self.failedToRetrieve(error)
        }
    }
    
    func downloadImages(_ cards : [CardBack]){
        Task{
            let cardsCopy = cards
            for i in 0..<cardsCopy.count{
                
                defer{
                    if cardsCopy[i].image != nil || cardsCopy[i].animatedImage != nil {
                        self.presenter?.appendCardBack(cardsCopy[i])
                    }
                }
                
                do{
                
                    guard let imgPath = cardsCopy[i].img, let url = URL(string: imgPath) else { continue }
                    let imgData = try await self.service.downloadImage(url)
                    guard let image = UIImage(data: imgData) else { continue }
                    cardsCopy[i].insertImage(image)
                        
                    
                    guard let animatedPath = cardsCopy[i].imgAnimated, let animURL = URL(string: animatedPath), animatedPath != imgPath else { continue }
                    let animImgData = try await self.service.downloadImage(animURL)
                    guard let animatedImage = UIImage(data: animImgData) else { continue }
                    cardsCopy[i].insertImage(animatedImage, isAnimated: true)
                    
                }catch{
                    continue
                }
            }
        }
    }
    
    func failedToRetrieve(_ error: Error) {
        print(error.localizedDescription)
    }
    
    
}
