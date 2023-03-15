//
//  DataProviderService.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 14/03/23.
//

import Foundation

protocol DataProviderService{
    var globalInfo: Info? {get set}
    
    func requestCards(request: [String: String]) async throws -> [Data]
    func requestCards() async throws -> [Data]
    func requestCardBacks() async throws -> [Data]
    func getInfo() async throws -> Info
    func getInfo() -> Info
}
