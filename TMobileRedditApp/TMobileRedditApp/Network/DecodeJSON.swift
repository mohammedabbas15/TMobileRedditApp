//
//  DecodeJSON.swift
//  TMobileRedditApp
//
//  Created by Mohammed Abbas on 11/11/21.
//

import Foundation
import UIKit

protocol DecodeJSON {
    func decodeObject <T: Decodable> (input: Data, type: T.Type) -> T?
    func decodeArray  <T: Decodable> (input: Data, type: T.Type) -> [T]?
}

extension DecodeJSON {
    func decodeObject <T: Decodable> (input: Data, type: T.Type) -> T? {
        return try? JSONDecoder().decode(T.self, from: input)
    }
    func decodeArray <T: Decodable> (input: Data, type: T.Type) -> [T]? {
        return try? JSONDecoder().decode([T].self, from: input)
    }
}
