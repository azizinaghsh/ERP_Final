//
//  UserEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData

@objc(UserEntity)
class UserEntity: Entity {
    
    override func setupEntity(object: NSObject)
    {
        let user = object as! User
        self.fname = user.firstName as String
        self.lname = user.lastName as String
        self.username = user.username as String
        self.password = user.password as String
        self.myPermission = PermissionCatalog.getInstance().getPermissionEntity(withTitle: "Default")
        let users = self.myPermission?.mutableSetValueForKey("myUsers")
        users?.addObject(self)
    }
    
    override class func getMyType () -> String
    {
        return "User"        
    }
}
