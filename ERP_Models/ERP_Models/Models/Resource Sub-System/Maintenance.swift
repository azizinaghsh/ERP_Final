//
//  Maintenance.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Maintenance: NSObjectStored {
    var maintainers : Array<HumanResource> = []
    var describe : NSString = ""
    var modificationDate : NSString
    var title : NSString
    
    init (title : NSString, maintainersAre maintainers : [HumanResource], descriptionIs description: NSString, modificationDateIs date:NSString?, entity: NSManagedObject? = nil)
    {
        self.maintainers = maintainers
        self.title = title
        describe = description
        if (date == nil)
        {
            self.modificationDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        }
        else
        {
            self.modificationDate = date!
        }
        super.init(MaintenanceEntity.self, entity: entity, saveContext: false)
    }
    
    func SetModificationDate (setTo date:String)
    {
        modificationDate = date
    }
}
