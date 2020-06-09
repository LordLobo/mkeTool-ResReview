//
//  ResturantType.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import Foundation
import CoreData

@objc(ResturantType)
public class ResturantType: NSManagedObject, Identifiable {
    class func count() -> Int {
        let fetchRequest: NSFetchRequest<ResturantType> = ResturantType.fetchRequest()
        
        do {
            let count = try CoreData.stack.context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    class func allResturantTypes() -> [ResturantType] {
        let data = CoreDataSource<ResturantType>(sort: "resturantType")
        return data.fetch()
    }
    
    class func newResturantType() -> ResturantType {
        return ResturantType(context: CoreData.stack.context)
    }
    
    class func createResturantType(resturantType: String) -> ResturantType {
        let new = ResturantType.newResturantType()
        new.resturantType = resturantType
        
        CoreData.stack.save()
        
        return new
    }
    
    public func delete() {
        CoreData.stack.context.delete(self)
    }
}

extension ResturantType {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResturantType> {
        return NSFetchRequest<ResturantType>(entityName: "ResturantType")
    }

    @NSManaged public var resturantType: String?
    @NSManaged public var resturants: Resturant?
}
