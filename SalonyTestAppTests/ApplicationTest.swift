//
//  ApplicationTest.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/22/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import UIKit
import XCTest
@testable import SalonyTestApp

class ApplicationTest: XCTestCase {
    
    func testDependencyInjections() {
        let networkManager = AppDelegate.resolve(NetworkManagerType.self)
        XCTAssertNotNil(networkManager, "Network manager must be assigned in AppDelegate.")
    }

}
