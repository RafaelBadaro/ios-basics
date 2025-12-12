//
//  LoginManager.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import Foundation
import Observation

@Observable
class LoginManager {
    private(set) var viewState: ViewState = .loggedOff
    let loginService: LoginServiceProtocol
    
    init(loginService: LoginServiceProtocol = LoginService()) {
        self.loginService = loginService
    }
    
    func login() async {
        viewState = .loading
        do {
            let response = try await loginService.login()
            viewState = .success(response)
        } catch let error as LoginError {
            viewState = .error(error)
        } catch {
            viewState = .error(.unknown(error.localizedDescription))
        }
    }
    
    func dismissErrorView() {
        viewState = .loggedOff
    }
    
    func logout() {
        viewState = .loggedOff
    }
}
