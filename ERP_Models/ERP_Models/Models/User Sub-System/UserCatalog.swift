//
//  UserCatalog.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class UserCatalog: NSObject {
    
    var users : Array<User> = []
    var userEntities : Array<UserEntity> = []
    
    static var instance : UserCatalog?
    
    var currentUser : User?
    
    private override init ()
    {
        super.init()
    }
    
    static func getInstance () -> UserCatalog
    {
        if (instance == nil)
        {
            instance = UserCatalog ()
            instance!.fetchUsersFromDatabase()
        }
        return instance!
    }
    
    func login (username : NSString, password : NSString) -> Bool
    {
        if let user = FindUser(username)
        {
            if user.password == password
            {
                currentUser = user
                return true
            }
        }
        return false
    }
    
    func logout ()
    {
        currentUser = nil
    }
    
    func addUser (withFirstName firstName : NSString, lastName : NSString, andUserName username : NSString, withPassword password : NSString, entity: UserEntity?) -> User?
    {
        if (FindUser(username) == nil)
        {
            let newUser = User (withFirstName: firstName, lastName: lastName, username: username, andPassword: password, withEntity: entity)
            users.append(newUser)
            return newUser
        }
        return nil
    }
    
    func removeUser (user : User) -> Bool
    {
        if let index = users.indexOf(user)
        {
            users.removeAtIndex(index)
            DataController.getInstance().managedObjectContext.deleteObject(user.myEntity!)
            return true
        }
        return false
    }
    
    func FindUser (username : NSString?) -> User?
    {
        for user in users
        {
            if user.username == username
            {
                return user
            }
        }
        return nil
    }
    
    func FindUserEntity (username : NSString?) -> UserEntity?
    {
        for user in userEntities
        {
            if user.username == username
            {
                return user
            }
        }
        return nil
    }
    
    func fetchUsersFromDatabase () -> Array<User>
    {
        let moc = DataController.getInstance().managedObjectContext
        let usersFetch = NSFetchRequest(entityName: "User")
        do
        {
            userEntities = try moc.executeFetchRequest(usersFetch) as! Array<UserEntity>
            for userEntity in userEntities
            {
                let newUser = addUser(withFirstName: userEntity.fname!, lastName: userEntity.lname!, andUserName: userEntity.username!, withPassword: userEntity.password!, entity: userEntity)
                newUser?.setPermission(PermissionCatalog.getInstance().getPermission(withTitle: userEntity.myPermission!.title!)!)
                
            }
            
        } catch
        {
            fatalError("Failed to fetch users: \(error)")
        }
        
        return users
    }
    
    func getSampleUsers () -> [User]
    {
        return [User(withFirstName: "حسین", lastName: "عزیزی", username: "hosseinazizi", andPassword: "44647454", withEntity: nil)]
    }
}
