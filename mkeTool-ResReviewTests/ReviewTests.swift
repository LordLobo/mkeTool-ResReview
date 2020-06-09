//
//  ReviewTests.swift
//  mkeTool-ResReviewTests
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import XCTest
import CoreData
@testable import Resturant_Review

class ReviewTests: XCTestCase {
    func test_count_returnsValue() {
        let request = Review.count()
        XCTAssertNotNil(request)
    }
    
    func test_allReviews_returnsValue() {
        let data = Review.allReviews()
        XCTAssertNotNil(data)
    }
    
    func test_newResturante_returnsResturant() {
        let new = Review.newReview()
        XCTAssertNotNil(new)
    }
    
    func test_createReviewFor_returnsReview() {
        let dive = Resturant.createResturant(name: "testResturant",
                                             type: ResturantType.allResturantTypes().first!)
        
        let revText = "is a dive"
        let myRating = 1
        let new = Review.createReviewFor(dive, text: revText, rating: myRating, date: Date.init())
        
        XCTAssertNotNil(new)
        XCTAssert(new.review == revText)
        XCTAssert(new.rating == Int16(myRating))
        XCTAssertNotNil(new.date)
        
        // cleanup
        new.delete()
        dive.delete()
        CoreData.stack.save()
    }
    
    func test_delete_deletesRow() {
        let dive = Resturant.createResturant(name: "testResturant",
                                             type: ResturantType.allResturantTypes().first!)
        
        let new = Review.createReviewFor(dive, text: "is a dive", rating: 1, date: Date.init())
        CoreData.stack.save()
        
        new.delete()
        CoreData.stack.save()
        
        XCTAssert(dive.reviews?.count == 0)
        
        dive.delete()
        CoreData.stack.save()
    }
}
