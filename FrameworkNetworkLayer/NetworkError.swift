//
//  NetworkError.swift
//  NetworkError
//
//  Created by Vitor Ferraz Varela on 30/07/21.
//

import Foundation
public enum NetworkError: String, Error {
    case badRequest
    case failed
    case noData
    case decode
    case notConnected
    
    var description: String {
        rawValue
    }
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest, .decode, .noData, .failed:
            return "Ops! Aconteceu um problema\n Tente novamente :)"
        case .notConnected:
            return "Ops! Parece que você está sem conexão com a internet :("
        }
    }
}
