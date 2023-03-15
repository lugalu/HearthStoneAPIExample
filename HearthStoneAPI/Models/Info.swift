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
    var faction: [String]
    var qualities: [String]
    var race: [String]
    var locales: [String: String]
    
}
