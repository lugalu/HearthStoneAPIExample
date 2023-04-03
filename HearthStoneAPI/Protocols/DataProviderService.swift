//
//  DataProviderService.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 14/03/23.
//

import UIKit

protocol CommonDataService{
    func downloadImage(_ url: URL) async throws -> Data
}

protocol SimpleCardsService{
    func requestCards(request: [String: String]) async throws -> Data
    func requestCards() async throws -> Data
}

protocol CardBacksService{
    func requestCardBacks() async throws -> Data
}

protocol CompleteCardService{
    func requestCompleteCard(withID id: String) async throws-> Data
}

protocol DataProviderService: SimpleCardsService, CardBacksService, CompleteCardService, CommonDataService {}


