//
//  TestRepo.swift
//  TMobileRedditAppTests
//
//  Created by Mohammed Abbas on 11/11/21.
//

import Foundation
@testable import TMobileRedditApp

class TestRepo: BaseRepository, FeedRepositoryService {
    
    func getFeedImage(from thumbnail: String, completionHandler: @escaping CompletionData) {
        print("Are we here yet?")
    }
    

    func searchFeed<T>(after: String?, modelType: T.Type, completionHandler: @escaping Completion<T>) where T: Decodable {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: {
            
            if after == nil {
                
                completionHandler(.failure(NetworkError.errorWith(message: " ")))
            }
            
            if let path = Bundle(for: TMobileRedditAppTests.self).path(forResource: "Sample", ofType: "json") {
                
                let url = URL(fileURLWithPath: path)
                
                do {
                    let data = try Data(contentsOf: url)
                    let model = try JSONDecoder().decode(modelType, from: data)
                    completionHandler(.success(model))
                }
                catch {
                    completionHandler(.failure(NetworkError.parsingFailed(message: error.localizedDescription)))
                }
                
            }
            else {
            
                completionHandler(.failure(NetworkError.errorWith(message: "Mock Forced Error")))
            }
        })
    }
}
