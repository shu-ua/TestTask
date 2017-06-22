//
//  AddressTests.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/22/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import SalonyTestApp

class AddressTests: XCTestCase {
    
    let mockJson = "{\"address\":{\"preview\":\"Mirqab, Block 1, Munawer Mutlaq Al Musailem\",\"block\":\"Block 1\",\"province\":\"Al Asimah Governate\",\"street\":\"Munawer Mutlaq Al Musailem\",\"area_id\":14,\"area\":\"Mirqab\"}}"
    
    func testParsing() {
        let addressMapper = Mapper<Address>()

        let jsonDictionary = convertToDictionary(text: mockJson)
        XCTAssertNotNil(jsonDictionary, "Mock json can't be parsed.")
        XCTAssertNotNil(jsonDictionary?["address"], "Mock json does not have 'address' key.")
        
        var address: Address? = nil
        
        if let addressJson = jsonDictionary!["address"] as? [String : Any] {
            address = addressMapper.map(JSON: addressJson)
        }
        
        XCTAssertNotNil(address, "Address object == nil.")
        XCTAssertNotNil(address?.addressName, "'preview' key not parsed.")
        XCTAssertNotNil(address?.block, "'block' key not parsed.")
        XCTAssertNotNil(address?.street, "'street' key not parsed.")
        XCTAssertNotNil(address?.area, "'area' key not parsed.")
        //TODO: Add more variables.
    }
    
    //MARK: - Helping methods
    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
