//
//  PermissionCatalog.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class PermissionCatalog: NSObject {
    
    var permissions : Array<Permission> = []
    var permissionEntities : Array<PermissionEntity> = []
    private static var instance : PermissionCatalog?
    
    var defaultPermission : Permission?
    
    
    func addDefaultPermissionToDatabase ()
    {
        let moc = DataController.getInstance().managedObjectContext
        let permissionFetch = NSFetchRequest (entityName: "Permission")
        var found = false
        do
        {
            let fetchedPermission = try moc.executeFetchRequest(permissionFetch)
            for permission in fetchedPermission
            {
                if (permission.title! == "Default")
                {
                    found = true
                }
            }
        }
        catch
        {
            fatalError("Failed to fetch employees: \(error)")
        }
        if (!found)
        {
            let permissionEntity = NSEntityDescription.insertNewObjectForEntityForName("Permission", inManagedObjectContext: moc) as! PermissionEntity
            permissionEntity.setupEntity(defaultPermission!)
            do
            {
                try moc.save()
            }
            catch
            {
                fatalError("Failed to save Dafault permission: \(error)")
            }
            
        }
    }
    
    
    static func getInstance () -> PermissionCatalog
    {
        if (instance == nil)
        {
            instance = PermissionCatalog ()
            instance!.defaultPermission = instance!.createPermission(permissionTitle: "Default", canCreateProject: false, canCreateUser: false, canCreateRequriement: false, canCreateResource: false, canCreatePermission: false, permissionEntity: nil)
            instance!.fetchPermissionsFromDatabase()
        }
        return instance!
    }
    
    func createPermission (permissionTitle title : NSString, canCreateProject : Bool, canCreateUser : Bool, canCreateRequriement : Bool, canCreateResource : Bool, canCreatePermission : Bool, permissionEntity : PermissionEntity?) -> Permission
    {
        let newPermission = Permission (permissionTitle: title, canCreateProject: canCreateProject, canCreateUser: canCreateUser, canCreateRequriement: canCreateRequriement, canCreateResource: canCreateResource, canCreatePermission: canCreatePermission, permissionEntity: permissionEntity)
        permissions.append(newPermission)
        return newPermission
    }
    
    func getPermissionEntity (withTitle title : NSString) -> PermissionEntity?
    {
        for permission in permissionEntities
        {
            if permission.title == title
            {
                return permission
            }
        }
        return nil
    }
    
    func getPermission (withTitle title : NSString) -> Permission?
    {
        for permission in permissions
        {
            if permission.title == title
            {
                return permission
            }
        }
        return nil
    }
    
    func removePermission (permission : Permission) -> Bool
    {
        if let index = permissions.indexOf(permission)
        {
            permissions.removeAtIndex(index)
            return true
        }
        return false
    }
    
    func fetchPermissionsFromDatabase () -> [Permission]
    {
        let moc = DataController.getInstance().managedObjectContext

        let PermissionsFetch = NSFetchRequest(entityName: "Permission")
        do
        {
            permissionEntities = try moc.executeFetchRequest(PermissionsFetch) as! [PermissionEntity]
            permissions = []
            for permissionEntity in permissionEntities
            {
                createPermission(permissionTitle: permissionEntity.title!, canCreateProject: permissionEntity.can_create_project!.boolValue, canCreateUser : permissionEntity.can_create_user!.boolValue, canCreateRequriement : permissionEntity.can_create_requirement!.boolValue, canCreateResource : permissionEntity.can_create_resource!.boolValue, canCreatePermission : false, permissionEntity : permissionEntity)
            }
        } catch
        {
            fatalError("Failed to fetch permissions: \(error)")
        }
        return permissions
    }
    
}
