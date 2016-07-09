//
//  ProjectResourceRelationship.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ProjectResourceRelationship: NSObjectStored {
    
    let resource : Resource
    let project : Project
    var amount : Int?
    var createdAt : String
    var estimatedUseDuration : Int
    
    init<T : Entity>(resource : Resource, projectHierarchy : Project, amount : Int?, estimatedUseDuration : Int, type: T.Type, entity: Entity?)
    {
        self.resource = resource
        self.project = projectHierarchy
        self.amount = amount
        self.estimatedUseDuration = estimatedUseDuration
        createdAt = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        super.init(type, entity: entity)
    }
}
