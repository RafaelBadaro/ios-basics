//
//  ContentView.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var loginManager = LoginManager()
   
    var body: some View {
        ZStack {
            switch loginManager.viewState {
            case .loggedOff:
                LoginView(loginManager: loginManager)
            case .loading:
                LoadingView()
            case .success:
                HomeView(loginManager: loginManager)
            case .error:
                ErrorView(loginManager: loginManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
