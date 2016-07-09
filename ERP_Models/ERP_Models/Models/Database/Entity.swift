//
//  Entity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/5/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Entity : NSManagedObject {
    
    static func addEntity(object: NSObject, saveContext : Bool = true) -> NSManagedObject {
        let moc = DataController.getInstance().managedObjectContext
        let newResourceEntity = NSEntityDescription.insertNewObjectForEntityForName(getMyType(), inManagedObjectContext: moc) as! Entity
        newResourceEntity.setupEntity(object)
        if (saveContext)
        {
            do
            {
                try moc.save()
            }
            catch
            {
                print (error)
                fatalError("failed to create")
            }
        }
        return newResourceEntity
    }
    
    func setupEntity(object: NSObject) {
        preconditionFailure("This method must be overridden")
    }
    
    class func getMyType () -> String
    {
        preconditionFailure("This method must be overridden")
    }
}