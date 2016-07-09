//
//  Allocation.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Allocation: ProjectResourceRelationship {
    var releaseTime : NSString?
    var isCurrent : Bool = true
    var estimatedReleaseTime : NSString
        {
        get
        {
            let formatter : NSDateFormatter = NSDateFormatter ()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            let date : NSDate = formatter.dateFromString(createdAt)!
            return formatter.stringFromDate(date.addDays(estimatedUseDuration))
        }
    }
    
    init(resource: Resource, projectHierarchy: Project, amount: Int?, estimatedUseDuration: Int, entity: Entity?) {
        super.init(resource: resource, projectHierarchy: projectHierarchy, amount: amount, estimatedUseDuration: estimatedUseDuration, type: AllocationEntity.self, entity: entity)
    }
    
    
    func freeResource ()
    {
        if (isCurrent)
        {
            releaseTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
            resource.freeResource (fromAllocation: self)
            isCurrent = false
            
            let allocationEntity = myEntity as! AllocationEntity
            allocationEntity.isCurrent = false
            allocationEntity.releaseTime = self.releaseTime as String?
            do {
                try allocationEntity.managedObjectContext?.save()
            }
            catch {
                fatalError("Could not remove free allocation")
            }
        }
    }
    
    func getReleaseTime () -> NSString
    {
        if isCurrent
        {
            return estimatedReleaseTime
        }
        return releaseTime!
    }
}
