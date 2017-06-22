//
//  AddAddressVC.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/22/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import UIKit

class AddAddressVC: BaseViewController {
    
    var address: Address?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add new address"
        
        print(address)
    }

}
