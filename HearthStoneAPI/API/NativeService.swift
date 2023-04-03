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
    
    func downloadImage(_ url: URL) async throws -> Data {
        let request = URLRequest(apiUrl: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return data
    }
    
    func requestCompleteCard(withID id: String) async throws -> Data {
        return Data()
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


