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
    
    func getSearch(searchText: String, header: [String : String]) {
        let request = Request(
            .get,
            url: URL(string: "https://api.github.com/search/code?q='\(searchText)'")!,
            header: header,
            body: nil)
        
let call = AnyCall<DataResponseParser>(request)
        session.start(call: call) { result in
            result.onSuccess { value in
              print(" success \(value)")
            }.onError { error in
                print(" error \(error)")
            }
        }
    }
}
