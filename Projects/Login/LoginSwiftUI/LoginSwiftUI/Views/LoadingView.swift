//
//  LoadingView.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .accessibilityIdentifier("loadingViewIndicator")
    }
}

#Preview {
    LoadingView()
}
