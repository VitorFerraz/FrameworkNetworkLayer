//
//  URLSessionNetworkLayer.swift
//  URLSessionNetworkLayer
//
//  Created by Vitor Ferraz Varela on 30/07/21.
//

import Foundation

public protocol NetworkLayer: AnyObject {
    func request<Model>(service: Service) async throws -> Model where Model : Decodable
}

public final class URLSessionNetworkLayer: NetworkLayer {
    private let session: URLSession = .shared
    
    public init() { }
    
    public func request<Model>(service: Service) async throws -> Model where Model : Decodable  {
        let (data, response) = try await session.data(for: service.createRequest())
        guard
          let httpResponse = response as? HTTPURLResponse,
          200...299 ~= httpResponse.statusCode
        else {
            throw NetworkError.failed
        }
        do {
            return try Model.decode(data)
        }
        catch {
            throw error
        }
    }
}
