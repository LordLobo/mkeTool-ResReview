//
//  Review.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import Foundation
import CoreData

@objc(Review)
public class Review: NSManagedObject {
    class func count() -> Int {
        let data = CoreDataSource<Review>()
        return data.fetch().count
    }
    
    class func allReviews() -> [Review] {
        let data = CoreDataSource<Review>()
        return data.fetch()
    }
    
    class func newReview() -> Review {
        return Review(context: CoreData.stack.context)
    }
    
    class func createReviewFor(_ resturant: Resturant, text: String) -> Review {
        let new = Review.newReview()
        new.review = text
        new.resturant = resturant
        new.date = Date.init()
        
        CoreData.stack.save()
        
        return new
    }
    
    public func delete() {
        CoreData.stack.context.delete(self)
    }
}

extension Review {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var date: Date?
    @NSManaged public var review: String?
    @NSManaged public var resturant: Resturant?
}
