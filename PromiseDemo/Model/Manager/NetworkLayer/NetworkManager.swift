//
//  NetworkManager.swift
//  PromiseDemo
//
//  Created by eslam mohamed on 02/08/2022.
//

import Foundation
import PromiseKit

enum ErrorMessages:Error{
    
    case invalidUrl
    case noInternet
    case invalidResponse
    case invalidData
    case invalidDataAfterDecoding
}

protocol INetworkManager{
    func fetchDataFromApi<B:Codable>(urlString: String, baseModel: B.Type)-> Promise<B>
    
}

class NetworkManager:INetworkManager{
    
    
    static let shared = NetworkManager()
    private init(){}
    
    func fetchDataFromApi<B>(urlString: String, baseModel: B.Type) -> Promise<B> where B : Decodable, B : Encodable {
        let endpoint = urlString
        
        return Promise { seal in
            guard let url = URL(string: endpoint) else{
                seal.reject(ErrorMessages.invalidUrl)
                return
            }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let _ = error {
                    seal.reject(ErrorMessages.noInternet)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    seal.reject(ErrorMessages.invalidResponse)

                    return
                }
                guard let data = data else {
                    seal.reject(ErrorMessages.invalidData)
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let resultData = try decoder.decode(B.self, from: data)
                    seal.fulfill(resultData)
                }catch{
                    print(error.localizedDescription)
                    seal.reject(ErrorMessages.invalidDataAfterDecoding)
                }
            }
            task.resume()
        }
        

    }
    
    
}
