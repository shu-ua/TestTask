//
//  BaseViewController.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/21/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    lazy var networkManager = {
        return AppDelegate.resolve(NetworkManagerType.self)
    }()

}
