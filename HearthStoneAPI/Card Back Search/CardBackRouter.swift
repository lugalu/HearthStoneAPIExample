//
//  CardBackRouter.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 28/03/23.
//

import Foundation

class CardBackRouter: CardBackRouterProtocol{
    static func getView() -> (CardBackViewProtocol & TabBarConformant)? {
        return CardBackView()
    }
    
    static func getConfigurationView() {
        
    }
    
    
}
