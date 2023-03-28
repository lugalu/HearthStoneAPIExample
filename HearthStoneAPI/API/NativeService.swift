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
            return internalInfo
        }
        set{
            internalInfo = newValue
        }
        
    }
    
    /*
     This Request could be better by creating the dict with a Enumerator so it would be constrained to the correct variables
     */
    func requestCards(request: [String: String]) async throws -> Data {
        guard let url = URL(string: APIKeys.API_ENDPOINT+"cards/search/") else { throw DataErrors.urlFail }
        var urlRequest = URLRequest(apiUrl: url)
        
        for (requestKey, requestValue) in request{
            urlRequest.addValue(requestValue, forHTTPHeaderField: requestKey)
        }

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        return data
    }
    
    func requestCards() async throws -> Data {
        guard let url = URL(string: APIKeys.API_ENDPOINT+"cards") else { throw DataErrors.urlFail }
        let request = URLRequest(apiUrl: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return data
    }
    
    func requestCardBacks() async throws -> Data {
        guard let url = URL(string: APIKeys.API_ENDPOINT+"cardbacks") else { throw DataErrors.urlFail }
        
        let request = URLRequest(apiUrl: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return data
    }
    
    func getInfo() async throws -> Info {
        if let globalInfo {
            return globalInfo
        }
        
        guard let url = URL(string: APIKeys.API_ENDPOINT+"info") else { throw DataErrors.urlFail }
        
        let request = URLRequest(apiUrl: url)
        let (data, response) = try await URLSession.shared.data(for: request)
    
        let json = JSONDecoder()
        let info = try json.decode(Info.self, from: data)
        
        
        globalInfo = info
        return info
    }
    
    func getInfo(handler: @escaping (Result<Info,Error>) -> Void?){
        if let globalInfo {
            handler(.success(globalInfo))
        }
        guard let url = URL(string: APIKeys.API_ENDPOINT+"info") else {
            handler(.failure(DataErrors.urlFail))
            return
        }
        let request = URLRequest(apiUrl: url)
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
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

extension URLRequest{
    
    init(apiUrl: URL){
        self.init(url: apiUrl)
        self.headers.add(name:"X-RapidAPI-Host" , value: APIKeys.API_HOST)
        self.headers.add(name: "X-RapidAPI-Key", value: APIKeys.API_KEY)
        self.httpMethod = "GET"
    }
}


