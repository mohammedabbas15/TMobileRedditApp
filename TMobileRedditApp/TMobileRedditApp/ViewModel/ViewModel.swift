//
//  ViewModel.swift
//  TMobileRedditApp
//
//  Created by Mohammed Abbas on 11/11/21.
//

import UIKit
import Foundation

class ViewModel: ViewModelType {
    
    private var repository: FeedRepositoryService?
    private var imagesCache = [String: Data]()
    
    init(repository: FeedRepositoryService = FeedRepository()) {
        self.repository = repository
    }
    
    var feedBinding: Published<[ChildData]>.Publisher {$feeds}
    var updateRowBinding: Published<Int>.Publisher {$updateRow}
    var errorBinding: Published<String?>.Publisher {$errorMessage}
    var numberOfItems: Int {return feeds.count}
    @Published private var updateRow = 0
    @Published private var searchResults: [RedditFeedResponse] = []
    @Published private var feeds = [ChildData]()
    @Published private var errorMessage: String?
    var after: String?
    
    func getFeeds() {

        repository?.searchFeed(after: self.after, modelType: RedditFeedResponse.self, completionHandler: { result in
            
            switch result {
                case .success(let response):
                    let dataResponse = response.data
                    let children = dataResponse.children
                    let feeds = children.map { child in
                        return child.data
                    }
                    self.feeds.append(contentsOf: feeds)
                    self.after = dataResponse.after
                print("After = \(dataResponse.after)")
                case .failure(let error):
                    print(error.localizedDescription)
                    self.errorMessage = error.localizedDescription
            }
        })
    }
    
    func getScore(at row: Int) -> String {
        "Score: \(feeds[row].score)"
    }
    
    func getTitle(at row: Int) -> String {
        feeds[row].title
    }
    
    func getCommentNumber(at row: Int) -> String {
        "Comments: \(feeds[row].numComments)"
    }
    
    func getImageData(at row: Int) -> Data? {
        
        let thumbnail = feeds[row].thumbnail
        if let data = imagesCache[thumbnail] {return data}
        
        repository?.getFeedImage(from: thumbnail, completionHandler: {[weak self]
            result in
            switch result {
                case .success(let data):
                    self?.imagesCache[thumbnail] = data
                    self?.updateRow = row
                case .failure(let error):
                print(error.localizedDescription)
            }
        })
        return nil
    }
}

protocol ViewModelType {
    
    var numberOfItems: Int {get}
    var updateRowBinding: Published<Int>.Publisher {get}
    var errorBinding: Published<String?>.Publisher {get}
    var feedBinding: Published<[ChildData]>.Publisher {get}
    
    func getImageData(at row: Int) -> Data?
    func getFeeds()
    func getTitle(at row: Int) -> String
    func getScore(at row: Int) -> String
    func getCommentNumber(at row: Int) -> String
    
}
