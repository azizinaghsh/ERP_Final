//
//  PhysicalResourceEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class PhysicalResourceEntity: ResourceEntity {

    override func setupEntity(object: NSObject) {
        let physicalResource = object as! PhysicalResource
        self.myCategory = (ResourceCatalog.getInstance().getResourceEntitiesCategories(resourceClassName: String(PhysicalResource), categoryName: (physicalResource.getCategory() as String))?[0]) as? PhysicalResourceCategoriesEntity
        self.name = physicalResource.name as String
        self.dateAdded = physicalResource.dateAdded as String
        self.roomNumber = physicalResource.roomNumber
        self.resourceCode = physicalResource.physicalResourceCode as String
    }
    
    override class func getMyType () -> String
    {
        return "PhysicalResource"
    }
}
