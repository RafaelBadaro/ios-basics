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
                .accessibilityIdentifier("errorViewText")
            Button("Go back") {
                loginManager.dismissErrorView()
            }
            .accessibilityIdentifier("errorViewGoBackButton")
        }
    }
}

#Preview {
    ErrorView(loginManager: loginManagerMock)
}
