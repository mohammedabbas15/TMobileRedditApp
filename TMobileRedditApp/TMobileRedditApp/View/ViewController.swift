//
//  ViewController.swift
//  TMobileRedditApp
//
//  Created by Mohammed Abbas on 11/11/21.
//

import UIKit
import Combine
import Foundation

class ViewController: UIViewController, UITableViewDataSourcePrefetching, UITableViewDataSource {
    
    var viewModel: ViewModelType?
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataBinding()
        viewModel?.getFeeds()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
        
    private func setupUI() {
        
        self.view.addSubview(tableView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:0.0).isActive = true
    }
    
    private func configureDataBinding() {
        viewModel?.feedBinding.dropFirst().receive(on: DispatchQueue.main).sink
        {
            [weak self] _ in
            print("reloading view")
            self?.tableView.reloadData()
        }.store(in: &cancellable)
        
        viewModel?.errorBinding.dropFirst().receive(on: DispatchQueue.main).sink
        { _ in
            print("Error binding data")
        }.store(in: &cancellable)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        let title = viewModel?.getTitle(at: row)
        let comment = viewModel?.getCommentNumber(at: row)
        let score = viewModel?.getScore(at: row)
        let imageData = viewModel?.getImageData(at: row)
        cell.configureCell(title: title, commentNumber: comment, score: score, imageData: imageData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(row: (viewModel?.numberOfItems ?? 1) - 1, section: 0)
        
        guard indexPaths.contains(lastIndexPath) else {return}
        viewModel?.getFeeds()
    }
}
