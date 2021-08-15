//
//  Service.swift
//  Service
//
//  Created by Vitor Ferraz Varela on 30/07/21.
//

import Foundation


public enum HTTPTask {
    case request(bodyParameters: Parameters? = nil)
}

public typealias Parameters  = [String: Any]
public typealias HTTPHeaders = [String: String]
public typealias ResultCompletion<T> = (Result<T, Error>) -> Void



public protocol Service {
    var baseURL:    URL { get }
    var path:       String { get }
    var httpMethod: HTTPMethod { get }
    var task:       HTTPTask { get }
    var headers:    HTTPHeaders? { get }
    var queryItems: [URLQueryItem] { get }
}

public extension Service {
    var baseURL: URL {
        guard let url = URL(string: Constants.URLs.base) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders? {
        [Constants.HTTPHeaderField.contentType: Constants.ContentType.json]
    }
    
    var queryItems: [URLQueryItem] {
        []
    }
    
    var task: HTTPTask {
        .request()
    }
    
    func createRequest() throws -> URLRequest {
        try buildRequestFrom(self)
    }
    
    func createUrl(_ service: Service) throws -> URL {
        var baseUrl: URL = service.baseURL
        
        if !service.path.isEmpty {
            baseUrl = service.baseURL.appendingPathComponent(service.path)
        }
        
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
            throw NetworkError.badRequest
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.badRequest
        }
        return url
    }
    
    func buildRequestFrom(_ service: Service) throws -> URLRequest {
        do {
            let reachability = try Reachability()
            if reachability.connection == .unavailable {
                throw NetworkError.notConnected
            }
            
            let baseUrl = try createUrl(service)
            
            var request: URLRequest = URLRequest(url: baseUrl,
                                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                                 timeoutInterval: 10)
            request.httpMethod = service.httpMethod.rawValue
            request.allHTTPHeaderFields = service.headers
            
            switch task {
            case .request(let bodyParameters):
                if let body = bodyParameters {
                    try JSONParameterEncoder.encode(urlRequest: &request, with: body)
                }
            }
            
            return request
        } catch let error {
            throw error
        }
    }
}
