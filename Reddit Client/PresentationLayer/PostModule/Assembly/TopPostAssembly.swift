//
//  TopPostAssembly.swift
//  Reddit Client
//
//  Created by Anna on 15.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

struct TopPostAssembly {

    func makeController(using url: URL) -> UIViewController {
        let storyboard = UIStoryboard(name: "TopPostViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! TopPostViewController
        let router = TopPostRouter()
        router.controller = vc
        
        vc.router = router
        vc.imageUrl = url
        
        return vc
    }
}

