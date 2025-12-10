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
    let loginService: LoginService
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    func setViewState(value newState: ViewState) {
        self.viewState = newState
    }
    
    func login() async {
        setViewState(value: .loading)
        do {
            let response = try await loginService.login()
            setViewState(value: .success(response))
        } catch {
            setViewState(value: .error(error))
        }
    }

}
