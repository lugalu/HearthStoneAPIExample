//
//  Cards.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 21/03/23.
//

import UIKit

struct CardSimplified: Decodable{
    let name: String
    let cardSet: String
    let type: String
    let text: String?
    let playerClass: String
}

struct CompleteCard: Decodable{
    let name: String
    let cardSet: String
    let type: String
    let faction: String
    let rarity: String
    let health: Int
    let armor: String
    let playerClass: String
    let img: String?
    let imgGold: String?
    
    enum CodingKeys: CodingKey {
        case name
        case cardSet
        case type
        case faction
        case rarity
        case health
        case armor
        case playerClass
        case img
        case imgGold
    }
    
    var images: [UIImage] = []
    
    mutating func insertImages(newImages: [UIImage]){
        self.images.append(contentsOf: newImages)
    }
    
}
