//
//  Module.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Module: Resource {
    var creators : Array<HumanResource> = []
    var maintenances : Array<Maintenance> = []
    var moduleDescription : NSString
    
    private var maintenanceIndex : Int = 0
    
    init (moduleName name : NSString, withDescription description : NSString, moduleCreators creators : [HumanResource], category : NSString, entity: ModuleEntity?)
    {
        self.creators = creators as Array<HumanResource>
        self.moduleDescription = description
        super.init(category: category, name : name, type: ModuleEntity.self, entity: entity)
    }
    
    func addMaintenance (TitleIs title : NSString, withMaintainers maintainers : [HumanResource], description : NSString, andDate date: NSString)
    {
        let newMaintenance = Maintenance(title: title, maintainersAre: maintainers, descriptionIs: description, modificationDateIs: date)
        maintenances.append(newMaintenance)
        let entityMaintenances = myEntity?.mutableSetValueForKey("maintenances")
        entityMaintenances?.addObject(newMaintenance.myEntity!)
        (newMaintenance.myEntity as! MaintenanceEntity).myModule = myEntity as? ModuleEntity
        do
        {
            try myEntity?.managedObjectContext?.save()
        }
        catch
        {
            print (error)
            fatalError("coudn't add maintenance")
        }
    }
    
    func removeMaintenance (theMaintenance maintenance : Maintenance)
    {
        if let index = maintenances.indexOf(maintenance)
        {
            maintenances.removeAtIndex(index)
        }
    }
}
