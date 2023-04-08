//
//  DecoderService.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 07/04/23.
//

import Foundation

protocol SimpleCardDecoderService {
    func decodeCards(with data: Data) throws -> [CardSimplified]
}

protocol CardBackDecoderService {
    func decodeCardBacks(with data: Data) throws -> [CardBack]
}

protocol CompleteCardDecoderService {
    func decodeCompleteCard(with data: Data) throws -> CompleteCard
}

protocol DecoderService: SimpleCardDecoderService, CardBackDecoderService, CompleteCardDecoderService{
}
