//
//  AppDelegate.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/21/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import UIKit
import GoogleMaps
import Swinject
import SwinjectStoryboard
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var container: Container = {
        let container = Container()
        container.register(NetworkManagerType.self) { _ in MoyaNetworkManager() }
        Container.loggingFunction = nil //Disabled to prevent spamming in log. (https://github.com/Swinject/Swinject/issues/218#issuecomment-273816311)

        return container
    }()

    //MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(Credential.GOOGLE_MAPS_APIKEY)
        self.window?.rootViewController = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container).instantiateInitialViewController()
        self.setupNavigationBarStyle()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        return true
    }

    class func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK: - UI Styling
    func setupNavigationBarStyle() {
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        //UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red:0.62, green:0.12, blue:0.38, alpha:1.0)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().clipsToBounds = false
        UINavigationBar.appearance().backgroundColor = UIColor(red:0.62, green:0.12, blue:0.38, alpha:1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
    
    //MARK: - Dependency Injection methods
    
    class func resolve<ObjectType>(_ type: ObjectType.Type) -> ObjectType? {
        return self.sharedInstance().container.resolve(type)
    }
    
}

