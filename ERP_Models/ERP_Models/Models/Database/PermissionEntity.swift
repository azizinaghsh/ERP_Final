//
//  PermissionEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/5/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class PermissionEntity: Entity {  
    
    override func setupEntity (object : NSObject)
    {
        let permission = object as! Permission
        self.title = permission.title as String
        self.can_create_user = permission.canCreateUser
        self.can_create_resource = permission.canCreateResource
        self.can_create_requirement = permission.canCreateRequriement
        self.can_create_project = permission.canCreateProject
    }
    
    override class func getMyType () -> String
    {
        return "Permission"
    }
}
