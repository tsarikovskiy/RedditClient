//
//  TopPostViewController.swift
//  Reddit Client
//
//  Created by Anna on 15.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

final class TopPostViewController: UIViewController {
    
    // MARK: - Constants
    enum C {
        static let saveButtonTitles = "Save Image"
        static let imageSavedSuccessfullyTitle = "Image saved"
        static let imageSavedFailTitle = "Fail while saving image"
        static let okTitle = "OK"
    }

    // MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK: - Properties
    var router: TopPostRouterInput?
    var imageUrl: URL?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
        configureIndicatorView()
        setupImage()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceOrientationDidChange),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc private func deviceOrientationDidChange() {
        activityIndicatorView.center = view.center
    }
    
    private func configureButton() {
        saveButton.setTitle(C.saveButtonTitles, for: .normal)
        saveButton.isEnabled = false
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
            
            if isSuccess {
                self?.saveButton.isEnabled = true
            }
        }
    }
    
    // MARK: - Actions
    @IBAction private func saveImageTapped() {
        guard let imageToSave = imageView.image else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            UIImageWriteToSavedPhotosAlbum(imageToSave,
                                           self,
                                           #selector(self.imageSavingCompletion),
                                           nil)
        }
    }
    
    @objc private func imageSavingCompletion(_ image: UIImage,
                                             didFinishSavingWithError error: Error?,
                                             contextInfo: UnsafeRawPointer) {
        
        let alertTitile = error == nil ? C.imageSavedSuccessfullyTitle : C.imageSavedFailTitle
        router?.showAlert(title: alertTitile, actionButtonTitle: C.okTitle)
    }
}
