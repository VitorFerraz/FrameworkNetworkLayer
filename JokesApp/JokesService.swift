//
//  JokesService.swift
//  JokesService
//
//  Created by Vitor Ferraz Varela on 02/08/21.
//

import Foundation
import FrameworkNetworkLayer

struct Joke: Codable {
  let value: String
}

enum JokesService: Service {
    case randomJoke

    var baseURL: URL {
        guard let url = URL(string:  "https://api.chucknorris.io") else {
            fatalError("Error to create url")
        }
        return url
    }
    
    var path: String {
        "/jokes/random"
    }
    
    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "category", value: "dev")]
    }
}
