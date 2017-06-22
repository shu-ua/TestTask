//
//  BaseViewController.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/21/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import UIKit
import KVNProgress

class BaseViewController: UIViewController {

    lazy var networkManager = {
        return AppDelegate.resolve(NetworkManagerType.self)
    }()

    //MARK: - Helper UI methods
    func showLoadingMask() {
        KVNProgress.show()
    }
    
    func dismissLoadingMask() {
        KVNProgress.dismiss()
    }
    
    func displayAlert(_ title:String = "TestApp", message:String, buttonText: String = "Ok") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
