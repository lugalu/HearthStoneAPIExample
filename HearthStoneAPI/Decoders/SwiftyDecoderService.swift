//
//  SwiftyDecoderService.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 07/04/23.
//

import Foundation
import SwiftyJSON

class SwiftyDecoderService: DecoderService{
    func decodeCards(with data: Data) throws -> [CardSimplified] {
        let json = try JSON(data: data)
        var cards: [CardSimplified] = []
        for (_, value) in json.dictionaryValue {
            guard let cardsJSONArr = value.array else {
                continue
            }
            for cardJSON in cardsJSONArr{
                let card = CardSimplified.getFrom(json: cardJSON)
                cards.append(card)
            }
        }
        let cardSet = Set(arrayLiteral: cards)
        
        return Array(cardSet).flatMap({ $0 }).sorted(by: { $0.name < $1.name })
    }
    
    func decodeCardBacks(with data: Data) throws -> [CardBack] {
        let json = try JSON(data: data)
        var cards: [CardBack] = []
        for (_, value) in json{
            let card = CardBack.getFrom(json: value)
            cards.append(card)
        }
        
        return cards
    }
    
    func decodeCompleteCard(with data: Data) throws -> CompleteCard {
        let json = try JSON(data: data)
        guard let cardJson = json.arrayValue.first else { print("zuum?")
            fatalError("Ops")
        }
        print(json,cardJson)
        return CompleteCard.getFrom(json: cardJson)
    }
    

    
}

fileprivate extension CardSimplified{
    static func getFrom(json: JSON) -> CardSimplified{
        let id:String = json["cardId"].stringValue
        let name: String = json["name"].stringValue
        let cardSet = json["cardSet"].string
        let type = json["type"].string
        let text = json["text"].string
        let playerClass = json["playerClass"].string
        return CardSimplified(cardId: id, name: name, cardSet: cardSet, type: type, text: text, playerClass: playerClass)
        
    }
}

fileprivate extension CardBack{
    static func getFrom(json:JSON) -> CardBack{
        let cardBackId = json["cardBackId"].intValue
        let name = json["name"].string
        let description = json["description"].string
        let img = json["img"].string
        let imgAnimated = json["imgAnimated"].string
        return CardBack(cardId: cardBackId, name: name, description: description, imgPath: img, imgAnimated: imgAnimated)
    }
   
}

fileprivate extension CompleteCard{
    static func getFrom(json: JSON) -> CompleteCard{
        let name = json["name"].stringValue
        let cardSet = json["cardSet"].string
        let type = json["type"].string
        let faction = json["faction"].string
        let rarity = json["rarity"].string
        let cost = json["cost"].int
        let attack = json["attack"].int
        let health = json["health"].int
        let text = json["text"].string
        let flavor = json["flavor"].string
        let artist = json["artist"].string
        let collectible = json["collectible"].bool
        let elite = json["elite"].bool
        let race = json["race"].string
        let img = json["img"].string
        let imgGold = json["imgGold"].string
        
        
        return CompleteCard(name: name, cardSet: cardSet, type: type, faction: faction, rarity: rarity, cost: cost, attack: attack, health: health, text: text, flavor: flavor, artist: artist, collectible: collectible, elite: elite, race: race, img: img, imgGold: imgGold)
    }
}
