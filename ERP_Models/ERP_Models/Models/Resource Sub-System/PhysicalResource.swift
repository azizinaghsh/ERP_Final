//
//  PhysicalResource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class PhysicalResource: Resource {
    var physicalResourceCode : NSString
    var roomNumber : Int
    
    init (category : NSString, name : NSString, physicalResourceCode : NSString, roomNumber : Int, entity: NSManagedObject? = nil)
    {
        self.physicalResourceCode = physicalResourceCode
        self.roomNumber = roomNumber
        super.init(category: category, name: name, type: PhysicalResourceEntity.self, entity: entity)
    }
}
