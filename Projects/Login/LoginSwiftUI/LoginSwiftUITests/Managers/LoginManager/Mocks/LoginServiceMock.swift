//
//  LoginServiceMock.swift
//  LoginSwiftUITests
//
//  Created by Rafael Badaró on 12/12/25.
//

import Foundation
@testable import LoginSwiftUI

struct LoginServiceMock: LoginServiceProtocol {
    
    let result: Result<ServerResponse, Error>
    
    func login() async throws -> ServerResponse {
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
