//
//  HomeView.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import SwiftUI

struct HomeView: View {
    let loginManager: LoginManager
    
    var body: some View {
        VStack {
            Text("Logged In!")
                .accessibilityIdentifier("homeViewloggedInText")
            Button("Logout") {
                loginManager.logout()
            }
            .accessibilityIdentifier("homeViewLogoutButton")
        }
    }
}

#Preview {
    HomeView(loginManager: loginManagerMock)
}
