//
//  TopPostTableViewCell.swift
//  Reddit Client
//
//  Created by Anna on 15.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

final class TopPostTableViewCell: UITableViewCell {
    
    // MARK: - View Model
    struct ViewModel {
        let title: String
        let author: String
        let time: String
        let imageURL: URL
        let commentsCount: String
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = UIImage(named: "placeholder-reddit")
    }
    
    func configure(using viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        timeLabel.text = viewModel.time
        thumbnailImageView.load(url: viewModel.imageURL)
        commentsCountLabel.text = viewModel.commentsCount
    }
}
