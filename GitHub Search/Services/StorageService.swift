//
//  StorageService.swift
//  GitHub Search
//
//  Created by Katerina Ulasik on 20.02.2022.
//

import Foundation


struct StorageService {
    private static let TOKEN_ID = "saved_git_token"
    
    func getToken() -> String? {
        guard let token = UserDefaults.standard.value(forKey: Self.TOKEN_ID) as? String else { return nil }
        return token
    }
    
    func setToken(token: String?) {
        UserDefaults.standard.set(token, forKey: Self.TOKEN_ID)
    }
}
