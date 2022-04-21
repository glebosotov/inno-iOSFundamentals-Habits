//
//  APIRequest.swift
//  Habits
//
//  Created by Gleb Osotov on 4/21/22.
//

import Foundation
import UIKit

protocol APIRequest {
    associatedtype Response
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var request: URLRequest { get }
    var postData: Data? { get }
}

extension APIRequest {
    var host: String { "localhost" }
    var port: Int { 8080 }
}

extension APIRequest {
    var queryItems: [URLQueryItem]? { nil }
    var postData: Data? { nil }
}

extension APIRequest {
    var request: URLRequest {
        var components = URLComponents()
        
        components.scheme = "http"
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        
        if let data = postData {
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
        }
        
        return request
    }
}

enum APIRequestError: Error {
    case itemsNotFound
    case requestFailed
}

extension APIRequest where Response: Decodable {
    func send() async throws -> Response {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIRequestError.itemsNotFound
        }
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Response.self, from: data)
        
        return decoded
    }
}

enum ImageRequestError: Error {
    case couldNotInitializeFromData
}

extension APIRequest where Response == UIImage {
    func send(completion: @escaping (Result<Self.Response, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(ImageRequestError.couldNotInitializeFromData))
            }
        }.resume()
    }
}

extension APIRequest {
    func send() async throws -> Void {
        let (_, response) = try await URLSession.shared.data(for: request)
       
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIRequestError.requestFailed
        }
    }
}
