//
//  FeedRepository.swift
//  TMobileRedditApp
//
//  Created by Mohammed Abbas on 11/11/21.
//

import Foundation

class FeedRepository: BaseRepository, DecodeJSON, FeedRepositoryService{
    
    func getFeedImage(from thumbnail: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        networkManager.run(baseURL: thumbnail, path: "", parameters: [:], requestType: RequestType.get) { data, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(.errorWith(message: error!.localizedDescription)))
                return
            }
            completionHandler(.success(data))
        }
    }
    
    func searchFeed<T>(after: String?, modelType: T.Type, completionHandler: @escaping Completion<T>) where T : Decodable {
        
        networkManager.run(baseURL: EndPoint.URL + (after ?? ""), path: "", parameters: [:], requestType: RequestType.get) {[weak self] data, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(.errorWith(message: error!.localizedDescription)))
                return
            }
            
            if let result = self?.decodeObject(input: data, type: modelType.self) {
                completionHandler(.success(result))
            }
            else {
                completionHandler(.failure(.parsingFailed(message: "")))
            }
        }
    }
}

protocol FeedRepositoryService {
    
    func searchFeed<T:Decodable>(after: String?, modelType: T.Type, completionHandler: @escaping Completion<T>)
    
    func getFeedImage(from thumbnail: String, completionHandler:@escaping CompletionData)
}
