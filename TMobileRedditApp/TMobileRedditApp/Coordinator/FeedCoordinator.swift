//
//  Main.swift
//  TMobileRedditApp
//
//  Created by Mohammed Abbas on 11/11/21.
//

import UIKit
import Foundation

class FeedCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let viewController = ViewController()
        viewController.viewModel = ViewModel()
        navigationController.pushViewController(viewController, animated: false)
    }
}

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController {get set}
    func start()
}
