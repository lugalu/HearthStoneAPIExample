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
    let cost: Int?
    let attack: Int?
    let health: Int?
    let text: String?
    let flavor: String?
    let artist: String?
    let collectible: Bool?
    let elite: Bool?
    let race: String?
    let img: String?
    let imgGold: String?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
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
        
        func getInfo(cardData card: CompleteCard?) -> (title: String, content: AttributedString)?{
            var text: String?
            switch self{
            case .name:
                text = card?.name
            case .cardSet:
                text = card?.cardSet
            case .type:
                text = card?.type
            case .faction:
                text = card?.faction
            case .rarity:
                text = card?.rarity
            case .health:
                text = "\(card?.health ?? 0)"
            case .cost:
                text = "\(card?.cost ?? 0)"
            case .attack:
                text = "\(card?.attack ?? 0)"
            case .text:
                text = card?.text
            case .flavor:
                text = card?.flavor
            case .artist:
                text = card?.artist
            case .collectible:
                text = "\(card?.collectible ?? false)"
            case .elite:
                text = "\(card?.elite ?? false)"
            case .race:
                text = card?.race
            default:
                return nil
            }
            
            text?.translateMarkdown()
            
            return (title: self.rawValue, content: (try? AttributedString(markdown: text ?? "**Missing Data**")) ?? AttributedString(stringLiteral: text ?? "Missing Data"))
        }
    }
    
    init( name: String, cardSet: String?, type: String?, faction: String?, rarity: String?, cost: Int?, attack: Int?, health: Int?, text: String?, flavor: String?, artist: String?, collectible: Bool?, elite: Bool?, race: String?, img: String?, imgGold: String?){
        self.name = name
        self.cardSet = cardSet
        self.type =  type
        self.faction = faction
        self.rarity = rarity
        self.cost = cost
        self.attack = attack
        self.health = health
        self.text = text
        self.flavor = flavor
        self.artist = artist
        self.collectible = collectible
        self.elite = elite
        self.race = race
        self.img = img
        self.imgGold = imgGold
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "error"
        cardSet = try values.decodeIfPresent(String.self, forKey: .cardSet)
        type =  try values.decodeIfPresent(String.self, forKey: .type)
        faction = try values.decodeIfPresent(String.self, forKey: .faction)
        rarity = try values.decodeIfPresent(String.self, forKey: .rarity)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        attack = try values.decodeIfPresent(Int.self, forKey: .attack)
        health = try values.decodeIfPresent(Int.self, forKey: .health)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        flavor = try values.decodeIfPresent(String.self, forKey: .flavor)
        artist = try values.decodeIfPresent(String.self, forKey: .artist)
        collectible = try values.decodeIfPresent(Bool.self, forKey: .collectible)
        elite = try values.decodeIfPresent(Bool.self, forKey: .elite)
        race = try values.decodeIfPresent(String.self, forKey: .race)
        img = try values.decodeIfPresent(String.self, forKey: .img)
        imgGold = try values.decodeIfPresent(String.self, forKey: .imgGold)
    }
    
    var images: [UIImage] = []
    
    mutating func insertImages(newImages images: [UIImage]){
        self.images.append(contentsOf: images)
    }
    
}
