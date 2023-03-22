//
//  CardBack.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 21/03/23.
//

import UIKit

class CardBack: Decodable {
    let cardId: String
    let name: String
    let description: String
    let imgPath: String
    let imgAnimated:String?
    
    enum CodingKeys: CodingKey {
        case cardId
        case name
        case description
        case imgPath
        case imgAnimated
    }
    
    var image:UIImage? = nil
    var animatedImage: UIImage? = nil
    
    init(cardId: String,name: String, description: String, imgPath: String, imgAnimated: String) {
        self.cardId = cardId
        self.name = name
        self.description = description
        self.imgPath = imgPath
        self.imgAnimated = imgAnimated
        self.downloadImages()
    }
    
    private func downloadImages(){
        Task{
            guard let imageURL = URL(string: self.imgPath) else { return }
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            let image = UIImage(data: data)
            self.image = image ?? UIImage(systemName: "x.square")!
            
            guard let animatedPath = self.imgAnimated,
                  let animatedURL = URL(string: animatedPath) else { return }
            let (animatedData, _) = try await URLSession.shared.data(from: animatedURL)
            let animatedImage = UIImage(data: animatedData)
            self.animatedImage = animatedImage ?? UIImage(systemName: "x.square")
            
        }
    }
}
