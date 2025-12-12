//
//  TestError.swift
//  LoginSwiftUI
//
//  Created by Rafael Badaró on 12/12/25.
//

import Foundation

// O Error em Swift não pode ser criado tipo Error("Mensagem")
struct TestError: LocalizedError {
    let message: String
    
    var errorDescription: String? {
        message
    }
}
