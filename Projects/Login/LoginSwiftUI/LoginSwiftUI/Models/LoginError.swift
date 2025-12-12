//
//  LoginError.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 09/12/25.
//

// MARK:
// Em Swift o Error é um protocolo e não pode ser lançado por si só
// Então uma boa prática é criar um enum que extende ele e tem seus próprios casos
enum LoginError: Error, Equatable {
    case authenticationFailed(String)
    case networkError(String)
    case timeout
    case unknown(String)
}
