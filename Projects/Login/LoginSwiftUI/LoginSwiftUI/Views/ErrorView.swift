//
//  ErrorView.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import SwiftUI

struct ErrorView: View {
    let loginManager: LoginManager
    
    var body: some View {
        VStack {
            Text("ErrorView")
                .font(.headline)
                .accessibilityIdentifier("errorViewText")
            
            if case .error(let loginError) = loginManager.viewState {
                Text(errorMessage(from: loginError))
                    .foregroundColor(.red)
                    .accessibilityIdentifier("errorViewMessage")
            }
            
            Button("Go back") {
                loginManager.dismissErrorView()
            }
            .accessibilityIdentifier("errorViewGoBackButton")
        }
    }
    
    private func errorMessage(from error: LoginError) -> String {
        switch error {
        case .authFailed(let message): return message
        case .networkError(let message): return message
        case .timeout: return "Request timed out"
        case .unknown(let message): return message
        }
    }

}

#Preview {
    ErrorView(loginManager: loginManagerMock)
}
