//
//  AddressRestManager.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/21/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import Foundation
import Moya
import GoogleMaps

enum AddressRestService {
    case addressInfo(location: CLLocation)
}

extension AddressRestService: TargetType {
    
    var baseURL: URL { return URL(string: RestURL.BASE_URL)! }
    
    var path: String {
        switch self {
        case .addressInfo:
            return RestURL.Address.ADDRESS_INFO
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addressInfo:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .addressInfo(let location):
            return ["lat": location.coordinate.latitude, "lng": location.coordinate.longitude]
        }
    }
    
    var sampleData: Foundation.Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .addressInfo:
            return URLEncoding.default
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .request
        }
    }
    
}
