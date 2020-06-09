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
public class Review: NSManagedObject, Identifiable {
    class func count() -> Int {
        let fetchRequest: NSFetchRequest<Review> = Review.fetchRequest()
        
        do {
            let count = try CoreData.stack.context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    class func allReviews() -> [Review] {
        let data = CoreDataSource<Review>(sort: "date")
        return data.fetch()
    }
    
    class func newReview() -> Review {
        return Review(context: CoreData.stack.context)
    }
    
    class func createReviewFor(_ resturant: Resturant, text: String, rating: Int, date: Date) -> Review {
        let new = Review.newReview()
        new.review = text
        new.rating = Int16(rating)
        new.resturant = resturant
        new.date = date
        
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
    @NSManaged public var rating: Int16
    @NSManaged public var resturant: Resturant?
}
