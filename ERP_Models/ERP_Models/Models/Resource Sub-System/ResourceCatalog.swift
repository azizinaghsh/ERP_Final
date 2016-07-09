//
//  ResourceCatalog.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ResourceCatalog: NSObject {
    
    private var resources : Array<Resource> = []
    private var resourceEntities : Array<ResourceEntity> = []
    static var instance : ResourceCatalog!
    
    var categories : [String : [String]]
    var categoriesEntities : [String : [CategoriesEntity]]
    
    private override init ()
    {
        categories = [String(HumanResource): [],
                      String(FinancialResource) : [],
                      String(Module) : [],
                      String(PhysicalResource) : []]
        
        categoriesEntities = [String(HumanResource): [],
                              String(FinancialResource): [],
                              String(Module): [],
                              String(PhysicalResource): []]
        
        super.init()
    }
    
    static func getInstance () -> ResourceCatalog
    {
        if (instance == nil)
        {
            instance = ResourceCatalog()
            ResourceBuilder.BuildResources()
        }
        return instance
    }
    
    func addResource (resource : Resource)
    {
        resources.append(resource)
        resourceEntities.append(resource.myEntity as! ResourceEntity)
    }
    
    func removeResource (resource : Resource) -> Bool
    {
        if let index = resources.indexOf(resource)
        {
            resources.removeAtIndex(index)
            resource.myEntity?.managedObjectContext?.deleteObject(resource.myEntity!)
            do {try DataController.getInstance().managedObjectContext.save()}catch{fatalError("failed to delete resource")}
            return true
        }
        return false
    }
    
    
    func getAllResources () -> Array<Resource>
    {
        return self.resources
    }
    
    
    func addCategory(resourceClassName : String, newCategory : String)
    {
        let resourceCategoriesEntityClass = "ERP_Models." + resourceClassName + "CategoriesEntity"
        let categoriesEntity = (NSClassFromString(resourceCategoriesEntityClass) as! CategoriesEntity.Type)
        categories[resourceClassName]?.append(newCategory)
        categoriesEntities[resourceClassName]?.append(categoriesEntity.addCategory(newCategory))
    }
    
    func removeCategory(resourceClassName : String, category : String) -> Bool
    {
        let resourceCategoriesEntityClass = "ERP_Models." + resourceClassName + "CategoriesEntity"
        
        if let index : Int = categories[resourceClassName]?.indexOf((category))
        {
            categories[resourceClassName]?.removeAtIndex(index)
            let categoriesEntityType = (NSClassFromString(resourceCategoriesEntityClass) as! CategoriesEntity.Type)
            let categoriesEntityToRemove = getResourceEntitiesCategories(resourceClassName: resourceClassName, categoryName: category)![0]
            categoriesEntityType.removeCategory(categoriesEntityToRemove)
            if let index : Int = categoriesEntities[resourceClassName]?.indexOf(categoriesEntityToRemove)
            {
                categoriesEntities[resourceClassName]?.removeAtIndex(index)
            }
            return true
        }
        return false
    }
    
    func getCategories (resourceClassName : String) -> [String]
    {
        return categories[resourceClassName]!
    }
    
    func getResourceEntitiesCategories (resourceClassName className : String, categoryName: String? = nil) -> [CategoriesEntity]?
    {
        if (categoryName == nil)
        {
            return categoriesEntities[className]!
        }
        else
        {
            for categoryEntity in categoriesEntities[className]!
            {
                if (categoryEntity.category! == categoryName)
                {
                    return [categoryEntity]
                }
            }
            return nil
        }
    }
    
    func findResource<T where T : Resource> (type : T.Type, name : NSString? = nil) -> [T]
    {
        var result : [T] = []
        for resource in resources
        {
            if (resource is T && (resource.name == name || name == nil))
            {
                result.append(resource as! T)
            }
            
        }
        return result
    }
}
