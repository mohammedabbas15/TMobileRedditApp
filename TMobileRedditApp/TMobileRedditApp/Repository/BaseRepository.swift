//
//  BaseRepository.swift
//  TMobileRedditApp
//
//  Created by Mohammed Abbas on 11/11/21.
//

import Foundation

class BaseRepository {
    
    var networkManager:Networkable

    init(networkManager:Networkable = NetworkManager()) {
        
        self.networkManager = networkManager
    }
}

typealias Completion<T:Decodable> = ((Result<T, NetworkError>) -> Void)
typealias CompletionData = ((Result<Data, NetworkError>) -> Void)
