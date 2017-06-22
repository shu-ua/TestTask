//
//  BaseViewController.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/21/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import UIKit
import KVNProgress

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {

    var tap: UITapGestureRecognizer!
    
    lazy var networkManager = {
        return AppDelegate.resolve(NetworkManagerType.self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) //Disable title of backButton
        navigationController?.navigationBar.topItem?.title = ""
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeyboardChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeKeyboardChanges()
    }

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
    
    //MARK: - Keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK:- Keyboard's dismissing control
    func subscribeKeyboardChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(registerPopGestureRecognizer), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(releasePopGestureRecognizer), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func unsubscribeKeyboardChanges() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func registerPopGestureRecognizer() {
        view.addGestureRecognizer(tap!)
    }
    
    func releasePopGestureRecognizer() {
        view.removeGestureRecognizer(tap!)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
}
