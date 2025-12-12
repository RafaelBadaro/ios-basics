//
//  HomeView.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import SwiftUI

struct HomeView: View {
    var loginManager: LoginManager
    
    var body: some View {
        VStack {
            Text("Logged In")
            Button("Logout") {
                loginManager.logout()
            }
        }
    }
}

#Preview {
    HomeView(loginManager: loginManagerMock)
}
