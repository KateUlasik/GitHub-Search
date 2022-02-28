//
//  NetworkService.swift
//  GitHub Search
//
//  Created by Katerina Ulasik on 22.02.2022.
//

import Foundation
import Endpoints

class NetworkService {
   private let client = AnyClient(baseURL: URL(string: "https://api.github.com")!)
   private lazy var session = Session(with: client)
    
    func getSearch(searchText: String, storageService: StorageService, completion: @escaping (GitResponse?) -> ()) {
        
        if let token = storageService.getToken() {
            let header = ["Authorization" : "token \(token)"]
            
            let request = Request(
                .get,
                url: URL(string: "https://api.github.com/search/code?q='\(searchText)'")!,
                header: header,
                body: nil)
            
    let call = AnyCall<DataResponseParser>(request)
            
            session.start(call: call) { result in
                result.onSuccess { data in
                    do {
                let jsonDecoder = JSONDecoder()
                let objectFromJson = try jsonDecoder.decode(GitResponse.self, from: data)
                   
                let txt = String(data: data, encoding: .utf8)
                completion(objectFromJson)
                } catch {
                completion(nil)
                }
                    
                }.onError { error in
                    completion(nil)
                }
        }
        } else {
//            error
        }
    }
}
