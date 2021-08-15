//
//  Constants.swift
//  Constants
//
//  Created by Vitor Ferraz Varela on 30/07/21.
//

import Foundation
public struct Constants {
    public struct HTTPHeaderField {
        static var contentType = "Content-Type"
        static var acceptType = "Accept"
        static var acceptEncoding = "Accept-Encoding"
    }
    
    public struct ContentType {
        static var json = "application/json"
    }
    
    public struct URLs {
        static var base: String {
            get {
                guard let stringURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
                    fatalError("Set your BASE_URL on info.plist")
                }
                return stringURL
            }
        }
    }
}
