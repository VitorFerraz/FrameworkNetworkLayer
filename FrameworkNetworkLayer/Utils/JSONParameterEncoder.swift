//
//  JSONParameterEncoder.swift
//  JSONParameterEncoder
//
//  Created by Vitor Ferraz Varela on 30/07/21.
//

import Foundation

struct JSONParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            
            if urlRequest.value(forHTTPHeaderField: Constants.HTTPHeaderField.contentType) == nil {
                urlRequest.setValue(Constants.ContentType.json, forHTTPHeaderField: Constants.HTTPHeaderField.contentType)
            }
        } catch {
            throw NSError(domain: "Bad encoder", code: NSURLErrorUnknown, userInfo: nil)
        }
    }
}
