//
//  ResturantTypeTests.swift
//  mkeTool-ResReviewTests
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import XCTest
import CoreData
@testable import mkeTool_ResReview

class ResturantTypeTests: XCTestCase {
    func test_count_returnsSeededValue() {
        let request = ResturantType.count()
        XCTAssertNotNil(request)
        XCTAssert(request == 3)
    }
    
    func test_allResturantTypes_returnsSeededValues() {
        let data = ResturantType.allResturantTypes()

        XCTAssertNotNil(data)
        XCTAssert(data[0].resturantType == "Italian")
        XCTAssert(data[1].resturantType == "Chinese")
        XCTAssert(data[2].resturantType == "Mexican")
    }
    
    func test_newResturantType_returnsResturantType() {
        let new = ResturantType.newResturantType()
        XCTAssertNotNil(new)
    }
    
    func test_createResturantType_returnsResturantType() {
        let name = "myType"
        let new = ResturantType.createResturantType(resturantType: name)

        XCTAssertNotNil(new)
        XCTAssert(new.resturantType == name)

        // cleanup
        new.delete()
        CoreData.stack.save()
    }
    
    func test_delete_deletesRow() {
        let name = "myType"
        let new = ResturantType.createResturantType(resturantType: name)

        // cleanup
        new.delete()
        CoreData.stack.save()

        let data = ResturantType.allResturantTypes().filter { f -> Bool in
            return f.resturantType == name
        }

        XCTAssert(data.count == 0)
    }
}
