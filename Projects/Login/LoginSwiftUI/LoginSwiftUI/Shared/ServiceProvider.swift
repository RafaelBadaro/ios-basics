//
//  ServiceProvider.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 12/12/25.
//

import Foundation

class ServiceProvider {
    static let shared = ServiceProvider()
        
    private init() { }
    
    func makeLoginService() -> LoginServiceProtocol {
        if let behavior = ProcessInfo.processInfo.mockLoginBehavior {
            return MockUITestLoginService(behavior: behavior)
        }
        return LoginService()
    }
}

extension ProcessInfo {
    var mockLoginBehavior: MockUITestLoginService.Behavior? {
        guard let value = environment["MOCK_LOGIN_BEHAVIOR"] else {
            return nil
        }
        return MockUITestLoginService.Behavior(rawValue: value)
    }
}
