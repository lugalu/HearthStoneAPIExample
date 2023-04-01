//
//  DataProviderService.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 14/03/23.
//

import UIKit

protocol DataProviderService{
    var globalInfo: Info? {get set}
    
    func requestCards(request: [String: String]) async throws -> Data
    func requestCards() async throws -> Data
    func requestCardBacks() async throws -> Data
    func downloadImage(_ url: URL) async throws -> Data
    func getInfo() async throws -> Info
    func getInfo(handler: @escaping (Result<Info,Error>) -> Void?)
}


