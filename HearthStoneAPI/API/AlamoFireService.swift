//
//  AlamoFireService.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 14/03/23.
//

import Alamofire

class AlamoFireService: DataProviderService{
    func requestCards(request: [String : String]) async throws -> Data {
        return try await baseRequest(urlEnd: "cards", parameters: request)
    }
    
    func requestCards() async throws -> Data {
        return try await baseRequest(urlEnd: "cards")
    }
    
    func requestCardBacks() async throws -> Data {
       return try await baseRequest(urlEnd: "cardbacks")
    }
    
    func downloadImage(_ url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation{ continuation in
            let request = AF.request(url)
            
            request.responseData{ response in
                switch response.result{
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error.underlyingError ?? DataErrors.downloadFail)
                }
            }
        }
    }
    
    func requestCompleteCard(withID id: String) async throws -> Data {
        return try await baseRequest(urlEnd: "cards/\(id)")
    }
    
    
    private func baseRequest(urlEnd: String, parameters: [String: String] = [:]) async throws -> Data{
        return try await withCheckedThrowingContinuation{ continuation in
            let request = AF.request(APIKeys.API_ENDPOINT+urlEnd,headers: getHeaders())
            
            request.response{ response in
                switch response.result{
                case .success(let data):
                    guard let data else {
                        continuation.resume(throwing: DataErrors.downloadFail)
                        return
                    }
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
                
            }
        }
    }
    
    
    private func getHeaders() -> HTTPHeaders{
        let headers: HTTPHeaders = HTTPHeaders(["X-RapidAPI-Key" : APIKeys.API_KEY,
                                      "X-RapidAPI-Host" : APIKeys.API_HOST
                                        ])
        return headers
    }
    
    private func getParameters(from dict: [String: String]) -> Parameters{
        var parameters: Parameters = Parameters()
        for (requestKey, requestValue) in dict{
            parameters[requestKey] = requestValue
        }
        return parameters
    }
    
    
}






