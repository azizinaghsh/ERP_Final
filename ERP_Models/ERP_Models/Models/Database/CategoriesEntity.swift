//
//  CategoriesEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/6/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class CategoriesEntity : NSManagedObject {
    static func addCategory (category : String) -> CategoriesEntity
    {
        let moc = DataController.getInstance().managedObjectContext
        let newCategory = NSEntityDescription.insertNewObjectForEntityForName(getMyType(), inManagedObjectContext: moc) as! CategoriesEntity
        newCategory.category = category
        do
        {
            try moc.save()
            return newCategory
        }
        catch
        {
            print ("failed to create resource category")
            fatalError()
        }
    }
    
    static func removeCategory (categoriesEntity: CategoriesEntity) -> CategoriesEntity?
    {
        let moc = DataController.getInstance().managedObjectContext
        moc.deleteObject(categoriesEntity)
        do
        {
            try moc.save()
        }
        catch
        {
            print (error)
            fatalError("failed to remove category")
        }
        return categoriesEntity
    }
    
    class func getMyType () -> String
    {
        return "CategoriesEntity"
    }
}
