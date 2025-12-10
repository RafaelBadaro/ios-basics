//
//  LoginService.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import Foundation

struct LoginService {
    
    // Call to API -> api/v1/login
    func login() async throws -> ServerResponse {

        // Sleep
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        let randomNumber = Int.random(in: 1...10)
        if randomNumber % 2 == 0 {
            return ServerResponse()
        } else {
            throw LoginError.authenticationFailed("Erro de autenticacao")
        }
        
    }
}
