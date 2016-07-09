//
//  MaintenanceEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class MaintenanceEntity: Entity {

    override func setupEntity(object: NSObject) {
        let maintenance = object as! Maintenance
        self.title = maintenance.title as String
        self.describe = maintenance.describe as String
        self.modificationDate = maintenance.modificationDate as String
        let maintainers = self.mutableSetValueForKey("maintainers")
        for human in maintenance.maintainers
        {
            maintainers.addObject(human.myEntity!)
        }
    }
    
    override class func getMyType () -> String
    {
        return "Maintenance"
    }
}
