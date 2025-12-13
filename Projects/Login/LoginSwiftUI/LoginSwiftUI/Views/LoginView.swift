//
//  LoginView.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import SwiftUI

struct LoginView: View {
    let loginManager: LoginManager
    
    var body: some View {
        VStack {
            Text("LoginView")
                .accessibilityIdentifier("loginViewText")
            Button("Login") {
                Task {
                    await loginManager.login()
                }
            }
                .accessibilityIdentifier("loginViewButton")
        }
    }
}

#Preview {
    LoginView(loginManager: loginManagerMock)
}
