//
//  Collections.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 02/04/23.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
