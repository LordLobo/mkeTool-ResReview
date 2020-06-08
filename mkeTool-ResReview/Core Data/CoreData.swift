//
//  CoreData.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import CoreData

class CoreData: NSObject {
    // Singleton
    static let stack = CoreData()
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {        
        let container = NSPersistentContainer(name: "mkeTool_ResReview")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let nserror = error as NSError? {
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        })
        
        return container
    }()
    
    public var context: NSManagedObjectContext {
        get {
            return self.persistentContainer.viewContext
        }
    }
    
    // MARK: - Core Data Saving support
    
    public func save() {
        if self.context.hasChanges {
            do {
                try self.context.save()
                //print("In CoreData.stack.save()")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Database setup
    
    public class func initialDbSetup() -> Void {
        if (ResturantType.count() == 0) {
            let _ = ResturantType.createResturantType(resturantType: "Italian")
            let _ = ResturantType.createResturantType(resturantType: "Chinese")
            let _ = ResturantType.createResturantType(resturantType: "Mexican")
        }
    }
    
    // MARK: - Managed Object Helpers
    
    class func executeBlockAndCommit(_ block: @escaping () -> Void) {
        block()
        CoreData.stack.save()
    }
    
}

