//
//  CardBack.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 21/03/23.
//

import UIKit

class CardBack: Decodable {
    
    let cardBackId: Int
    let name: String?
    let description: String?
    let img: String?
    let imgAnimated:String?
    
    enum CodingKeys: CodingKey {
        case cardBackId
        case name
        case description
        case img
        case imgAnimated
    }
    
    var image:UIImage? = nil
    var animatedImage: UIImage? = nil
    
    init(cardId: Int,name: String, description: String, imgPath: String, imgAnimated: String) {
        self.cardBackId = cardId
        self.name = name
        self.description = description
        self.img = imgPath
        self.imgAnimated = imgAnimated
    }
    
    func insertImage(_ image: UIImage, isAnimated: Bool = false){
        if isAnimated{
            self.animatedImage = image
            return
        }
        self.image = image
    }
}
