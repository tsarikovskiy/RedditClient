//
//  TopPostsListRouter.swift
//  Reddit Client
//
//  Created by Anna on 15.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

final class TopPostsListRouter {
    
    // MARK: - Properties
    weak var controller: UIViewController?
}

// MARK: - TopPostsListRouterInput
extension TopPostsListRouter: TopPostsListRouterInput {
    func openTopPost() {
        let topPostController = TopPostAssembly().makeController()
        controller?.navigationController?.pushViewController(topPostController, animated: true)
    }
}
