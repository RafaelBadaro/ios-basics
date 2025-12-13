//
//  LoginSwiftUIUITests.swift
//  LoginSwiftUIUITests
//
//  Created by Rafael Badaró on 08/12/25.
//

import XCTest
@testable import LoginSwiftUI

final class LoginSwiftUIUITests: XCTestCase {
    
    enum Constants {
        enum LoginView {
            static let loginViewText = "loginViewText"
            static let loginViewButton = "loginViewButton"
        }
        
        enum LoadingView {
            static let loadingViewIndicator = "loadingViewIndicator"
        }
        
        enum HomeView {
            static let homeViewloggedInText = "homeViewloggedInText"
            static let homeViewLogoutButton = "homeViewLogoutButton"
        }
        
        enum ErrorView {
            static let errorViewText = "errorViewText"
            static let errorViewGoBackButton = "errorViewGoBackButton"
        }
        
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }
    
    private func launchApp(mockBehavior: MockUITestLoginService.Behavior) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchEnvironment = ["MOCK_LOGIN_BEHAVIOR": mockBehavior.rawValue]
        app.launch()
        return app
    }

    @MainActor
    func test_login_success() throws {
        let app = launchApp(mockBehavior: .success)
        
        // 1. Check LoginView
        XCTAssert(app.staticTexts[Constants.LoginView.loginViewText].exists)
        XCTAssert(app.buttons[Constants.LoginView.loginViewButton].exists)
        
        // 2. Tap the button
        app.buttons[Constants.LoginView.loginViewButton].tap()
        
        // MARK: Here we could check if the ProgressView() is showing, but the only way to make that happen is to add a delay to MockUITestLoginService, which I don't like to do
//        let loadingExists = app.activityIndicators[Constants.LoadingView.loadingViewIndicator]
//            .waitForExistence(timeout: 2)
//        XCTAssert(loadingExists, "Loading view should appear")
        
        // 3. Check HomeView
        // MARK: Here we could check directly: XCTAssert(app.staticTexts["homeViewloggedInText"].exists) but Claude says it could fail randomly because SwiftUI takes some milliseconds to setup the View, the timeout here is to prevent this behavior
        let homeViewExists = app.staticTexts[Constants.HomeView.homeViewloggedInText]
            .waitForExistence(timeout: 3)
        XCTAssert(homeViewExists, "Home view should appear after loading")
        XCTAssert(app.buttons[Constants.HomeView.homeViewLogoutButton].exists)
    }

    @MainActor
    func test_login_error_authError() throws {
        let app = launchApp(mockBehavior: .authError)
        
        // 1. Check LoginView
        XCTAssert(app.staticTexts[Constants.LoginView.loginViewText].exists)
        XCTAssert(app.buttons[Constants.LoginView.loginViewButton].exists)
        
        // 2. Tap the button
        app.buttons[Constants.LoginView.loginViewButton].tap()
        
        // 3. Check ErrorView
        let errorViewExists = app.staticTexts[Constants.ErrorView.errorViewText]
            .waitForExistence(timeout: 3)
        XCTAssert(errorViewExists, "Error view should appear after loading")
        XCTAssert(app.buttons[Constants.ErrorView.errorViewGoBackButton].exists)
    }
    
    @MainActor
    func test_login_error_authError_goBack() throws {
        let app = launchApp(mockBehavior: .authError)
        
        // 1. Check LoginView
        XCTAssert(app.staticTexts[Constants.LoginView.loginViewText].exists)
        XCTAssert(app.buttons[Constants.LoginView.loginViewButton].exists)
        
        // 2. Tap the button
        app.buttons[Constants.LoginView.loginViewButton].tap()
        
        // 3. Check ErrorView
        let errorViewExists = app.staticTexts[Constants.ErrorView.errorViewText]
            .waitForExistence(timeout: 3)
        XCTAssert(errorViewExists, "Error view should appear after loading")
        XCTAssert(app.buttons[Constants.ErrorView.errorViewGoBackButton].exists)
        
        app.buttons[Constants.ErrorView.errorViewGoBackButton].tap()
        
        let loginViewExists = app.staticTexts[Constants.LoginView.loginViewText]
              .waitForExistence(timeout: 3)
        XCTAssert(loginViewExists, "Should return to login view")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
