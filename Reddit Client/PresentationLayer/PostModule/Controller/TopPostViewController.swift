//
//  TopPostViewController.swift
//  Reddit Client
//
//  Created by Anna on 15.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

final class TopPostViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK: - Properties
    var imageUrl: URL?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureIndicatorView()
        setupImage()
    }
    
    private func configureIndicatorView() {
        activityIndicatorView.center = view.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
    }
    
    private func setupImage() {
        guard let url = imageUrl else {
            return
        }
        imageView.load(url: url) { [weak self] isSuccess in
            self?.activityIndicatorView.stopAnimating()
        }
    }
    
}
