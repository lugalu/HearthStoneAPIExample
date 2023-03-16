//
//  AlamoFireService.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 14/03/23.
//

import Alamofire
import SwiftyJSON

class AlamoFireService: DataProviderService{
    private var internalInfo: Info? = nil
    var globalInfo: Info?{
        get{
            return internalInfo
        }
        set{
            internalInfo = newValue
        }
        
    }
    
    init() {
        Task{
            do{
                let info = try await self.getInfo()
                globalInfo = info
            }catch{
                print("Error \(error.localizedDescription)")
            }
            
        }
    }
    
    func requestCards(request: [String : String]) async throws -> Data {
        
        
        
        
        return Data()
    }
    
    func requestCards() async throws -> Data {
        return Data()
    }
    
    func requestCardBacks() async throws -> Data {
        return Data()
    }
    
    func getInfo() async throws -> Info {
        if let globalInfo {
            return globalInfo
        }
        
        var tempInfo = Info(patch: "", classes: [], sets: [], types: [], factions: [], qualities: [], races: [], locales: ["":""])
        globalInfo = tempInfo
        return tempInfo
    }
    
    func getInfo(handler: @escaping (Result<Info,Error>) -> ()?){
        if let globalInfo {
            handler(.success(globalInfo))
        }
        guard let url = URL(string: APIKeys.API_ENDPOINT+"info") else {
            handler(.failure(DataErrors.urlFail))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            if let error, data == nil{
                handler(.failure(error))
            }
            
            do{
                let info = try JSONDecoder().decode(Info.self, from: data!) as Info
                self.globalInfo = info
                handler(.success(info))
                
            }catch{
                handler(.failure(DataErrors.decodeFail))
            }
            
        })
    
    }
    
    
}






