//
//  Requirements.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Requirement: ProjectResourceRelationship {
    
    init(resource: Resource, projectHierarchy: Project, amount: Int?, estimatedUseDuration: Int, entity: Entity?)
    {
        super.init(resource: resource, projectHierarchy: projectHierarchy, amount: amount, estimatedUseDuration: estimatedUseDuration, type: RequirementEntity.self, entity: entity)   
    }
    
    func tryRequirement () -> Bool
    {
        if let allocation = resource.allocateResource(to: project, withAmount: amount, estimatedUseDuration: self.estimatedUseDuration, entity: nil)
        {
            project.allocateResource(allocation)
            return true
        }
        return false
    }
}
