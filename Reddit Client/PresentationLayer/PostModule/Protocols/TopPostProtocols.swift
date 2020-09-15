//
//  TopPostProtocols.swift
//  Reddit Client
//
//  Created by Anna on 15.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

protocol TopPostRouterInput: class {
    func showAlert(title: String, actionButtonTitle: String)
}
