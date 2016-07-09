//
//  Permission.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Permission: NSObjectStored {
    var title : NSString = ""
    
    var canCreateProject, canCreateResource, canCreateRequriement, canCreatePermission, canCreateUser : Bool
    
    init (permissionTitle title : NSString, canCreateProject : Bool, canCreateUser : Bool, canCreateRequriement : Bool, canCreateResource : Bool, canCreatePermission : Bool, permissionEntity : PermissionEntity?)
    {
        self.title = title
        self.canCreateProject = canCreateProject
        self.canCreateUser = canCreateUser
        self.canCreateRequriement = canCreateRequriement
        self.canCreatePermission = canCreatePermission
        self.canCreateResource = canCreateResource
        super.init(PermissionEntity.self, entity: permissionEntity)
    }
    
    func setPermissionTitle (title : String)
    {
        self.title = title
    }
}




