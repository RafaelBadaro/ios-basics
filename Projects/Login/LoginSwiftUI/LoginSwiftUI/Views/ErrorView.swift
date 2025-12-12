//
//  ErrorView.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import SwiftUI

struct ErrorView: View {
    var loginManager: LoginManager
    
    var body: some View {
        VStack {
            Text("ErrorView")
            Button("Go back") {
                loginManager.dismissErrorView()
            }
        }
    }
}

#Preview {
    ErrorView(loginManager: loginManagerMock)
}
