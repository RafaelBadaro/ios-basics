//
//  ViewState.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 08/12/25.
//

import Foundation

enum ViewState {
    case loggedOff
    case loading
    case success(ServerResponse)
    case error(Error)
}
