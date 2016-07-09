//
//  User.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class User: NSObjectStored {
    
    var userPermission : Permission
    var firstName, lastName, username, password : NSString
    
    init (withFirstName firstName : NSString, lastName : NSString, username : NSString, andPassword password : NSString, withEntity entity : UserEntity?)
    {
        userPermission = PermissionCatalog.getInstance().defaultPermission!
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
        super.init(UserEntity.self, entity : entity)
    }
    
    func setPermission (permission : Permission)
    {
        self.userPermission = permission
        (myEntity as! UserEntity).myPermission = permission.myEntity as? PermissionEntity
        do {try myEntity?.managedObjectContext?.save()}catch{fatalError("failed to set permission for user: " + (username as String))}
    }
}
