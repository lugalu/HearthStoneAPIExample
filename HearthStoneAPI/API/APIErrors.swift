//
//  APIErrors.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 27/03/23.
//

import Foundation

enum DataErrors: Error{
    case urlFail
    case downloadFail
    case decodeFail
    
}

extension DataErrors: LocalizedError{
    var errorDescription: String?{
        switch self{
        case .urlFail:
            return NSLocalizedString("Failed to Generate URL.", comment: "")
        case .downloadFail:
            return NSLocalizedString("Failed to download the requested data", comment: "")
        case .decodeFail:
            return NSLocalizedString("Failed to decode the downloaded data", comment: "")
        }
    }
}
