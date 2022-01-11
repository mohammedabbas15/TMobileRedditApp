//
//  TableViewCell.swift
//  TMobileRedditApp
//
//  Created by Mohammed Abbas on 11/11/21.
//

import UIKit
import Foundation

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    lazy private var mainStackView: UIStackView = {
        
        let mainStackView = UIStackView(frame: .zero)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.spacing = 8
        return mainStackView
    }()
    
    lazy private var feedImageView: UIImageView = {
        let feedImageView = UIImageView(frame: .zero)
        feedImageView.translatesAutoresizingMaskIntoConstraints = false
        feedImageView.contentMode = .scaleAspectFit
        return feedImageView
    }()
    
    lazy private var feedTitleLabel: UILabel = {
        let feedTitleLabel = UILabel(frame: .zero)
        feedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        feedTitleLabel.numberOfLines = 0
        feedTitleLabel.textAlignment = .left
        feedTitleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        feedTitleLabel.lineBreakMode = .byWordWrapping
        return feedTitleLabel
    }()
    
    lazy private var feedCommentNumberLabel: UILabel = {
        let feedCommentNumberLabel = UILabel(frame: .zero)
        feedCommentNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        feedCommentNumberLabel.numberOfLines = 0
        feedCommentNumberLabel.textAlignment = .left
        feedCommentNumberLabel.font = UIFont.preferredFont(forTextStyle: .body)
        feedCommentNumberLabel.lineBreakMode = .byWordWrapping
        feedCommentNumberLabel.textColor = .blue
        return feedCommentNumberLabel
    }()
    
    lazy private var feedScoreLabel: UILabel = {
        let feedScoreLabel = UILabel(frame: .zero)
        feedScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        feedScoreLabel.numberOfLines = 0
        feedScoreLabel.textAlignment = .left
        feedScoreLabel.font = UIFont.preferredFont(forTextStyle: .body)
        feedScoreLabel.lineBreakMode = .byWordWrapping
        feedScoreLabel.textColor = .darkText
        return feedScoreLabel
    }()
    
    private func setUpUI() {
        
        mainStackView.addArrangedSubview(feedImageView)
        mainStackView.addArrangedSubview(feedCommentNumberLabel)
        mainStackView.addArrangedSubview(feedScoreLabel)
        mainStackView.addArrangedSubview(feedTitleLabel)
        contentView.addSubview(mainStackView)
        
        let safeArea = contentView.safeAreaLayoutGuide
        feedImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8.0).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8.0).isActive = true
    }
    
    func configureCell(title: String?, commentNumber: String?, score: String?, imageData: Data?) {
        setUpUI()
        feedTitleLabel.text = title
        feedCommentNumberLabel.text = commentNumber
        feedScoreLabel.text = score
        feedImageView.image = UIImage(named: "Image Not Found")
        if let data = imageData {
            feedImageView.image = UIImage(data: data)
        }
    }
}
