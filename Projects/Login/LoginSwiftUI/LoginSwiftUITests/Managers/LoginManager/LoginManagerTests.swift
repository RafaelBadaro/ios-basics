//
//  LoginManagerTests.swift
//  LoginSwiftUITests
//
//  Created by Rafael Badaró on 12/12/25.
//

import Testing
@testable import LoginSwiftUI

struct LoginManagerTests {

    @Test @MainActor
    func login_success() async throws {
        // Arrange
        let serverResponseExpected = ServerResponse()
        let mock = LoginServiceMock(result: .success(serverResponseExpected))
        let loginManager = LoginManager(loginService: mock)
        
        // Act
        await loginManager.login()
        
        // Assert
        #expect(loginManager.viewState == ViewState.success(serverResponseExpected))
    }
    
    @Test @MainActor
    func login_error_authenticationFailed() async throws {
        // Arrange
        let errorMessage = "Authentication Failed"
        let error = LoginError.authFailed(errorMessage)
        
        let mock = LoginServiceMock(result: .failure(error))
        let loginManager = LoginManager(loginService: mock)
        
        // Act
        await loginManager.login()
        
        // Assert
        #expect(loginManager.viewState == ViewState.error(.authFailed(errorMessage)))
    }
    
    @Test @MainActor
    func login_error_networkError() async throws {
        // Arrange
        let errorMessage = "Network Error"
        let error = LoginError.networkError(errorMessage)
        
        let mock = LoginServiceMock(result: .failure(error))
        let loginManager = LoginManager(loginService: mock)
        
        // Act
        await loginManager.login()
        
        // Assert
        #expect(loginManager.viewState == ViewState.error(.networkError(errorMessage)))
    }
    
    @Test @MainActor
    func login_error_timeout() async throws {
        // Arrange
        let error = LoginError.timeout
        
        let mock = LoginServiceMock(result: .failure(error))
        let loginManager = LoginManager(loginService: mock)
        
        // Act
        await loginManager.login()
        
        // Assert
        #expect(loginManager.viewState == ViewState.error(.timeout))
    }
    
    @Test @MainActor
    func login_error_unknown_as_loginError_unknown() async throws {
        // Arrange
        let errorMessage = "Unknown Error"
        let error = LoginError.unknown(errorMessage)
        
        let mock = LoginServiceMock(result: .failure(error))
        let loginManager = LoginManager(loginService: mock)
        
        // Act
        await loginManager.login()
        
        // Assert
        #expect(loginManager.viewState == ViewState.error(.unknown(errorMessage)))
    }
    
    @Test @MainActor
    func login_error_unknown_with_generic_error() async throws {
        // Arrange
        let errorMessage = "Unknown generic Error"
        let error = TestError(message: errorMessage)
        
        let mock = LoginServiceMock(result: .failure(error))
        let loginManager = LoginManager(loginService: mock)
        
        // Act
        await loginManager.login()
        
        // Assert
        #expect(loginManager.viewState == ViewState.error(.unknown(errorMessage)))
    }
}
