//
//  NetworkManager.swift
//  TMobileRedditApp
//
//  Created by Mohammed Abbas on 11/11/21.
//

import Foundation

class NetworkManager: Networkable {
    
    func run (baseURL: String, path: String, parameters: [String: String], requestType: RequestType, completionHandler: @escaping NetworkSuccessful) {
        guard var URLComoponents = URLComponents(string: baseURL.appending(path)) else {
            completionHandler(nil, .missingURL(message: "Missing URL"))
            return
        }
        
        if requestType == .get {
            
            var items: [URLQueryItem] = []
            
            for (key, value) in parameters {
                items.append(URLQueryItem(name: key, value: value))
            }
            URLComoponents.queryItems = items
        }
        
        guard let URL = URLComoponents.url else {
            completionHandler(nil, .missingURL(message: "Missing URL"))
            return
        }
        
        var request = URLRequest(url: URL)
        
        switch requestType {
        case .get:
            request.httpMethod = RequestType.get.rawValue
        case .post:
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
                request.httpMethod = RequestType.post.rawValue
            }
            catch {
                completionHandler(nil, .missingURL(message: "Missing URL"))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let _response = response as? HTTPURLResponse, _response.statusCode == 200 else {
                completionHandler(nil, .errorWith(message: "Error with response"))
                return
            }
            
            guard let data = data, error == nil else {
                completionHandler(nil, .errorWith(message: "Error with data"))
                return
            }
            completionHandler(data, nil)
        }.resume()
    }
}

enum RequestType: String {
case get = "GET"
case post = "POST"
}

enum NetworkError: Error {
case parsingFailed(message: String)
case errorWith(message: String)
case networkNotAvailable(message: String)
case missingURL(message: String)
}

typealias NetworkSuccessful =
    (Data?, NetworkError?) -> Void

protocol Networkable {
    func run (baseURL: String, path: String, parameters: [String: String], requestType: RequestType, completionHandler: @escaping NetworkSuccessful)
}
