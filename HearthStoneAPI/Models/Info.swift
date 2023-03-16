//
//  Info.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 14/03/23.
//

import Foundation

struct Info: Decodable{
    var patch: String
    var classes: [String]
    var sets: [String]
    var types: [String]
    var factions: [String]
    var qualities: [String]
    var races: [String]
    var locales: [String: String]
    
}
