//
//  Address.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/21/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import Foundation
import ObjectMapper

final class Address: Mappable {
    
    var addressName: String?
    var area: String?
    var appartmentType: String?
    var block: String?
    var street: String?
    var building: String?
    var floor: String?
    var apartmentNo: String?
    var mobileNumber: String?
    var specialInstructions: String?
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    //MARK: - Mapping
    
    func mapping(map: Map) {
        addressName <- map["preview"]
        block <- map["block"]
        street <- map["street"]
        area <- map["area"]
    }
    
}
