//
//  NativeDecodeService.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 07/04/23.
//

import Foundation

class NativeDecoderService: DecoderService{
    func decodeCards(with data: Data) throws -> [CardSimplified] {
        let json = JSONDecoder()
        
        let cards = try json.decode([String: [CardSimplified]].self, from: data)
        var cardSet: Set<CardSimplified> = Set<CardSimplified>()
        
        for (_,value) in cards{
            cardSet.formUnion(value)
        }
        return Array(cardSet).sorted(by: { $0.name < $1.name })
    }
    
    func decodeCardBacks(with data: Data) throws -> [CardBack] {
        let json = JSONDecoder()
        return try json.decode([CardBack].self, from: data) as [CardBack]
    }
    
    func decodeCompleteCard(with data: Data) throws -> CompleteCard {
        let cards = try JSONDecoder().decode([CompleteCard].self, from: data) as [CompleteCard]
        guard let card = cards.first else { throw(DataErrors.decodeFail) }
        return card
    }
    
    
}
