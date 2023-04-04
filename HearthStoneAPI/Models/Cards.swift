//
//  Cards.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 21/03/23.
//

import UIKit

struct CardSimplified: Decodable, Hashable{
    let cardId: String
    let name: String
    let cardSet: String?
    let type: String?
    var text: String?
    let playerClass: String?
}

struct CompleteCard: Decodable{
    let name: String
    let cardSet: String?
    let type: String?
    let faction: String?
    let rarity: String?
    let health: Int?
    let armor: String?
    let playerClass: String?
    let img: String?
    let imgGold: String?
    
    enum CodingKeys: String, CodingKey {
        case cardId
        case name
        case cardSet
        case type
        case faction
        case rarity
        case cost
        case attack
        case health
        case text
        case flavor
        case artist
        case collectible
        case elite
        case race
        case img
        case imgGold
        case locale
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "error"
        cardSet = "" //try values.decodeIfPresent(String.self, forKey: .cardSet)
        type =  ""//try values.decodeIfPresent(String.self, forKey: .type)
        faction = ""//try values.decodeIfPresent(String.self, forKey: .faction)
        rarity = ""//try values.decodeIfPresent(String.self, forKey: .rarity)
        health = 10//try values.decodeIfPresent(Int.self, forKey: .health)
        armor = ""//try values.decodeIfPresent(String.self, forKey: .armor)
        playerClass = ""//try values.decodeIfPresent(String.self, forKey: .playerClass)
        img = ""//try values.decodeIfPresent(String.self, forKey: .img)
        imgGold = ""//try values.decodeIfPresent(String.self, forKey: .imgGold)
    }
    
    var images: [UIImage] = []
    
    mutating func insertImages(newImages: [UIImage]){
        self.images.append(contentsOf: newImages)
    }
    
}
