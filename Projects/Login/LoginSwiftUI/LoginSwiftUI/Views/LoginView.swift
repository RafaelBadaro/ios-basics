//
//  LoginView.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import SwiftUI

struct LoginView: View {
    var loginManager: LoginManager
    
    var body: some View {
        VStack {
            Text("LoginView")
            Button("Login") {
                Task {
                    await loginManager.login()
                }
            }
        }
    }
}

#Preview {
    LoginView(loginManager: loginManagerMock)
}
