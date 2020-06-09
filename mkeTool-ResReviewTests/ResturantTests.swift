//
//  ResturantTests.swift
//  mkeTool-ResReviewTests
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import XCTest
import CoreData
@testable import mkeTool_ResReview

class ResturantTests: XCTestCase {
    func test_count_returnsValue() {
        CoreData.stack.setup(storeType: NSInMemoryStoreType) {
            let request = Resturant.count()
            XCTAssertNotNil(request)
        }
    }
    
    func test_allResturants_returnsValue() {
        let data = Resturant.allResturants()
        XCTAssertNotNil(data)
    }
    
    func test_newResturant_returnsResturant() {
        let new = Resturant.newResturant()
        XCTAssertNotNil(new)
    }
    
    func test_createResturant_returnsResturant() {
        let name = "testResturant"
        let type = ResturantType.allResturantTypes().first
        
        let new = Resturant.createResturant(name: name, type: type!)

        XCTAssertNotNil(new)
        XCTAssert(new.name == name)
        XCTAssert(new.type == type)
        
        // cleanup
        new.delete()
        CoreData.stack.save()
    }
    
    func test_delete_deletesRow() {
        let name = "testResturant"
        let type = ResturantType.allResturantTypes().first
        
        let new = Resturant.createResturant(name: name, type: type!)

        XCTAssertNotNil(new)
        XCTAssert(new.name == name)
        XCTAssert(new.type == type)
        
        new.delete()
        CoreData.stack.save()
        
        let data = Resturant.allResturants().filter { f -> Bool in
            return f.name == name
        }
        
        XCTAssert(data.count == 0)
    }
    
    func test_avgReview_producesZeroIfNoreviews() {
        let name = "testResturant"
        let type = ResturantType.allResturantTypes().first
        
        let new = Resturant.createResturant(name: name, type: type!)
        
        XCTAssert(new.avgReview() == 0)
        
        // cleanup
        new.delete()
        CoreData.stack.save()
    }
}
