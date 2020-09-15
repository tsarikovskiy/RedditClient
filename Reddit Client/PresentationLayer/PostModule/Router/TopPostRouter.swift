//
//  TopPostRouter.swift
//  Reddit Client
//
//  Created by Anna on 15.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

final class TopPostRouter {
    
    // MARK: - Properties
    weak var controller: UIViewController?
}

// MARK: - TopPostRouterInput
extension TopPostRouter: TopPostRouterInput {
    
    func showAlert(title: String, actionButtonTitle: String) {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: nil))
        controller?.present(alert, animated: true, completion: nil)
    }
}
