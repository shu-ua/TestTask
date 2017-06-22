//
//  AddAddressVC.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/22/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import UIKit

class AddAddressVC: BaseViewController {
    
    @IBOutlet var map: MapView!
    
    @IBOutlet var areaTextField: UITextField!
    @IBOutlet var blockTextField: UITextField!
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var buildingTextField: UITextField!
    @IBOutlet var floorTextField: UITextField!
    @IBOutlet var apartmentTextField: UITextField!
    @IBOutlet var mobileNumberTextField: UITextField!
    @IBOutlet var specialIntsructionTextView: UITextView!
    
    var address: Address?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add new address"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) //Disable title of backButton
        map.map.settings.scrollGestures = false
        fillInfo()
    }
    
    private func fillInfo() {
        if let address = address {
            areaTextField.text = address.area
            blockTextField.text = address.block
            streetTextField.text = address.street
            buildingTextField.text = address.building
            floorTextField.text = address.floor
            apartmentTextField.text = address.apartmentNo
            mobileNumberTextField.text = address.mobileNumber
        }
    }
    
    //MARK: - REST
    private func sendAddressToServer() {
        
    }

}

extension AddAddressVC: UITextFieldDelegate {
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case areaTextField:
            blockTextField.becomeFirstResponder()
        case blockTextField:
            streetTextField.becomeFirstResponder()
        case streetTextField:
            buildingTextField.becomeFirstResponder()
        case buildingTextField:
            floorTextField.becomeFirstResponder()
        case floorTextField:
            apartmentTextField.becomeFirstResponder()
        case apartmentTextField:
            mobileNumberTextField.becomeFirstResponder()
        case mobileNumberTextField:
            specialIntsructionTextView.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
    
}
