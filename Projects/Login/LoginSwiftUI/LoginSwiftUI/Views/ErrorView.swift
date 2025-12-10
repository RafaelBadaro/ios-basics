//
//  ErrorView.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import SwiftUI

struct ErrorView: View {
    @Binding var loginManager: LoginManager
    
    var body: some View {
        VStack {
            Text("ErrorView")
            Button("Go back") {
                loginManager.setViewState(value: .loggedOff)
            }
        }
    }
}

#Preview {
    ErrorView(loginManager: .constant(loginManagerMock))
}
