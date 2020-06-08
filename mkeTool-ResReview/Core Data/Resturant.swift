//
//  Resturant.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import Foundation
import CoreData

@objc(Resturant)
public class Resturant: NSManagedObject {
    class func count() -> Int {
        let data = CoreDataSource<Resturant>()
        return data.fetch().count
    }
    
    class func allResturants() -> [Resturant] {
        let data = CoreDataSource<Resturant>()
        return data.fetch()
    }
    
    class func newResturant() -> Resturant {
        return Resturant(context: CoreData.stack.context)
    }
    
    class func createResturant(name: String, type: ResturantType) -> Resturant {
        let new = Resturant.newResturant()
        new.name = name
        new.type = type
        new.id = UUID.init()
        
        CoreData.stack.save()
        
        return new
    }
    
    public func delete() {
        CoreData.stack.context.delete(self)
    }
}

extension Resturant {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Resturant> {
        return NSFetchRequest<Resturant>(entityName: "Resturant")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var reviews: NSSet?
    @NSManaged public var type: ResturantType?
}

// MARK: Generated accessors for reviews
extension Resturant {
    @objc(addReviewsObject:)
    @NSManaged public func addToReviews(_ value: Review)

    @objc(removeReviewsObject:)
    @NSManaged public func removeFromReviews(_ value: Review)

    @objc(addReviews:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReviews:)
    @NSManaged public func removeFromReviews(_ values: NSSet)
}
