//
//  JSONDecoder+ISO.swift
//  JSONDecoder+ISO
//
//  Created by Vitor Ferraz Varela on 30/07/21.
//

import Foundation

extension JSONDecoder {
    static var isoJSONDecoder: JSONDecoder {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}

extension Decodable {
    static func decode<Model>(_ data: Data) throws -> Model where Model : Decodable  {
        do {
            return try JSONDecoder.isoJSONDecoder.decode(Model.self, from: data)
        } catch {
            throw NetworkError.decode
        }
    }
}
