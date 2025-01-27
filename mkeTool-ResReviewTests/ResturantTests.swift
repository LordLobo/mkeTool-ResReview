//
//  ResturantTests.swift
//  mkeTool-ResReviewTests
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import XCTest
import CoreData
@testable import Resturant_Review

class ResturantTests: XCTestCase {
    func test_count_returnsValue() {
        let request = Resturant.count()
        XCTAssertNotNil(request)
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
    
    func test_avgReview_producesAverageScoreOfReviews() {
        let name = "testResturant"
        let type = ResturantType.allResturantTypes().first
        
        let new = Resturant.createResturant(name: name, type: type!)
        
        _ = Review.createReviewFor(new, text: "", rating: 5, date: Date.init())
        _ = Review.createReviewFor(new, text: "", rating: 3, date: Date.init())
        _ = Review.createReviewFor(new, text: "", rating: 2, date: Date.init())
        _ = Review.createReviewFor(new, text: "", rating: 1, date: Date.init())
        
        print(new.avgReview())
        
        XCTAssert(new.avgReview() == 2.75)
        
        // cleanup
        new.delete()
        CoreData.stack.save()
    }
    
    // this isn't a great test because it really just 'tests core data'
    // however I wasn't totally sure this would 'just work'
    func test_editResturaunt_changesData() {
        let name = "testResturant"
        let type = ResturantType.allResturantTypes().first
        
        let new = Resturant.createResturant(name: name, type: type!)
        
        CoreData.stack.save()
        
        let newName = "newName"
        new.name = newName
        
        CoreData.stack.save()
        
        XCTAssert(new.name == newName)
        
        // cleanup
        new.delete()
        CoreData.stack.save()
    }
}
