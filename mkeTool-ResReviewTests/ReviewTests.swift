//
//  ReviewTests.swift
//  mkeTool-ResReviewTests
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import XCTest
import CoreData
@testable import mkeTool_ResReview

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
        let new = Review.createReviewFor(dive, text: revText)

        XCTAssertNotNil(new)
        XCTAssert(new.review == revText)
        XCTAssertNotNil(new.date)
        
        // cleanup
        new.delete()
        dive.delete()
        CoreData.stack.save()
    }
    
    func test_delete_deletesRow() {
        let dive = Resturant.createResturant(name: "testResturant",
                                             type: ResturantType.allResturantTypes().first!)
        
        let revText = "is a dive"
        let new = Review.createReviewFor(dive, text: revText)
        CoreData.stack.save()
        
        new.delete()
        CoreData.stack.save()
        
        XCTAssert(dive.reviews?.count == 0)
        
        dive.delete()
        CoreData.stack.save()
    }
}
