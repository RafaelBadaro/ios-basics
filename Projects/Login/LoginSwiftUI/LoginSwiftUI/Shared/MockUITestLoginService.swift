//
//  MockUITestLoginService.swift
//  LoginSwiftUIUITests
//
//  Created by Rafael Badaró on 12/12/25.
//

import Foundation

struct MockUITestLoginService: LoginServiceProtocol {
    public enum Behavior: String {
        case success
        case authError
        case networkError
        case timeout
    }
    
    let behavior: Behavior
    
    func login() async throws -> ServerResponse {
        switch behavior {
        case .success:
            return ServerResponse()
        case .authError:
            throw LoginError.authFailed("Mock auth error")
        case .networkError:
            throw LoginError.networkError("Mock network error")
        case .timeout:
            throw LoginError.timeout
        }
    }
}
