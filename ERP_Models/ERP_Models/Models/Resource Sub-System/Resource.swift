//
//  Resource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Resource: NSObjectStored {
    
    private var allocations : [Allocation] = []
    private var category : NSString
    var dateAdded : NSString
    var name : NSString
    
    init<T where T: ResourceEntity> (category : NSString, name : NSString, type : T.Type, entity: NSManagedObject? = nil)
    {
        dateAdded = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        self.category = category
        self.name = name
        super.init(type, entity: entity)
    }
    
    func getIsAvailable () -> Bool
    {
        for allocation in allocations
        {
            if allocation.isCurrent
            {
                return false
            }
        }
        return true
    }
    
    func getCategory () -> NSString
    {
        return category
    }
    
    func setCategory (category : String)
    {
        self.category = category
    }
    
    func getEstimatedRelease () -> NSString?
    {
        if allocations.count == 0
        {
            return nil
        }
        let formatter : NSDateFormatter = NSDateFormatter ()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        
        var bestAllocation : Allocation = allocations[0]
        for allocation in allocations
        {
            if (allocation.isCurrent)
            {
                if (NSDate.stringToDate(bestAllocation.estimatedReleaseTime as String)!.isGreaterThanDate(NSDate.stringToDate(allocation.estimatedReleaseTime as String)!))
                {
                    bestAllocation = allocation
                }
            }
        }
        return bestAllocation.estimatedReleaseTime
    }
    
    func allocateResource (to projectHierarchy : Project, withAmount amount : Int?, estimatedUseDuration : Int, entity: AllocationEntity?) -> Allocation?
    {
        if (!getIsAvailable())
        {
            return nil
        }
        else
        {
            let newAllocation = Allocation (resource: self, projectHierarchy: projectHierarchy, amount: amount, estimatedUseDuration: estimatedUseDuration, entity: entity)
            allocations.append(newAllocation)
            return newAllocation
        }
    }
    
    func freeResource (fromAllocation allocation : Allocation)
    {

    }
    
}
