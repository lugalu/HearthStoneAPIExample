//
//  NativeService.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 14/03/23.
//

import Foundation

class NativeService: DataProviderService{
    private var internalInfo: Info? = nil
    var globalInfo: Info?{
        get{
            return internalInfo ?? getInfo()
        }
        set{
            internalInfo = newValue
        }
        
    }
    
    init() {
        self.globalInfo = self.getInfo()
    }
    
    func requestCards(request: [String : String]) async throws -> [Data] {
        
        
        
        
        return []
    }
    
    func requestCards() async throws -> [Data] {
        return []
    }
    
    func requestCardBacks() async throws -> [Data] {
        return []
    }
    
    func getInfo() async throws -> Info {
        if let globalInfo {
            return globalInfo
        }
        
        var tempInfo = Info(patch: "", classes: [], sets: [], types: [], faction: [], qualities: [], race: [], locales: ["":""])
        globalInfo = tempInfo
        return tempInfo
    }
    
    func getInfo() -> Info {
        if let globalInfo {
            return globalInfo
        }
        
        var tempInfo = Info(patch: "", classes: [], sets: [], types: [], faction: [], qualities: [], race: [], locales: ["":""])
        globalInfo = tempInfo
        return tempInfo
    }
    
}
