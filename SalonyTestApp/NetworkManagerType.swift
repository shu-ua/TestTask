//
//  NetworkManagerType.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/21/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import Foundation
import GoogleMaps
import Moya
import ObjectMapper

typealias AddressSearchCompletion = (_ address: Address?, _ errorMessage: String?) -> Void

protocol NetworkManagerType {
    func requestAddressInfo(withLocation location: CLLocation, completionHandler: @escaping AddressSearchCompletion)
}

//Moya network manager
class MoyaNetworkManager: NetworkManagerType {
    
    let addressMapper = Mapper<Address>()
    
    fileprivate lazy var provider:MoyaProvider<AddressRestService> = {
        MoyaProvider<AddressRestService>()
    }()
    
    func requestAddressInfo(withLocation location: CLLocation, completionHandler: @escaping AddressSearchCompletion) {
        
        provider.request(.addressInfo(location: location)) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = (try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as! [String : Any])["address"]  as? [String : Any] {
                        let address = self.addressMapper.map(JSON: json)
                        completionHandler(address, nil)
                    } else {
                        completionHandler(nil, "Wrong JSON")
                    }
                } catch {
                    completionHandler(nil, "Internal Error")
                }
            case let .failure(error):
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
}

