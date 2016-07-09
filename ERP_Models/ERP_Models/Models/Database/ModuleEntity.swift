//
//  ModuleEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class ModuleEntity: ResourceEntity {
    
    override func setupEntity(object: NSObject) {
        let module = object as! Module
        self.name = module.name as String
        self.moduleDescription = module.moduleDescription as String
        self.dateAdded = module.dateAdded as String
        
        let cat : ModuleCategoriesEntity = (ResourceCatalog.getInstance().getResourceEntitiesCategories(resourceClassName: String(Module), categoryName: module.getCategory() as String)?[0] as? ModuleCategoriesEntity)!
        cat.modules?.setByAddingObject(self)
        self.category = cat
        let creators: NSMutableSet = self.mutableSetValueForKey("creators")
        for humanResource in module.creators
        {
            creators.addObject(ResourceCatalog.getInstance().findResource(HumanResource.self, name: humanResource.name)[0].myEntity!)
        }
    }
    
    override class func getMyType () -> String
    {
        return "Module"
    }
}
