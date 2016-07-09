//
//  Resource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Project: NSObjectStored {
    
    var allocations : Array<Allocation> = []
    var products : Array<Product> = []
    var subProjects : [Project] = []
    var requirements : Array<Requirement> = []
    var projectManager : User?
    var startDate : NSString
    var endDate : NSString?
    var projectName : NSString
    var projectDescription : NSString?
    var humanResourceLimit : Int?
    var budgetLimit : Int?
    var category : NSString
    var isProject : Bool
    
    init (isProjectRoot isProject: Bool, withName name : NSString, category : NSString, description: NSString?, budgetLimitIs budgetLimit : Int?, humanResourceLimitIs humanResourceLimit : Int?, isManagedBy manager : User?, entity: ProjectEntity?)
    {
        self.startDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        self.projectName = name
        self.projectManager = manager
        self.projectDescription = description
        self.budgetLimit = budgetLimit
        self.humanResourceLimit = humanResourceLimit
        self.category = category
        self.isProject = isProject
        super.init(ProjectEntity.self, entity: entity)
    }
    
    
    func createProduct (withName name : NSString, withDescription description : NSString, productCreatorsAre creators : [HumanResource], category: NSString, entity: ProductEntity?)
    {
        let newProduct = Product(withName: name, withDescription: description, productCreatorsAre: creators, category: category, entity: entity)
        (newProduct.myEntity as! ProductEntity).project = myEntity as? ProjectEntity
        do { try myEntity?.managedObjectContext?.save() } catch { fatalError("failed to add prodict") }
        products.append(newProduct)
    }
    
    func createRequirement (forResource resource : Resource, withAmount amount : Int?, estimatedToBeUsed estimate : Int, entity: RequirementEntity?) -> Requirement
    {
        let requirement = Requirement(resource : resource, projectHierarchy : self, amount: amount, estimatedUseDuration: estimate, entity: entity)
        requirements.append(requirement)
        return requirement
    }
    
    func addSubSystem (withName name: NSString, category: NSString, description: NSString?, budgetLimit: Int?, humanResourceLimit: Int?, managedBy manager : User?, entity: ProjectEntity?) -> Project
    {
        let newSubProject = Project (isProjectRoot: false,withName: name, category: category, description: description, budgetLimitIs: budgetLimit, humanResourceLimitIs: humanResourceLimit, isManagedBy: manager, entity: entity)
        subProjects.append(newSubProject)
        let newSubProjectEntity = (newSubProject.myEntity as! ProjectEntity)
        newSubProjectEntity.superProject = myEntity as? ProjectEntity
        do
        {
            try myEntity?.managedObjectContext?.save()
        }
        catch
        {
            fatalError("failed to modify subSystem")
        }
        return newSubProject
    }
    
    func allocateResource (allocation : Allocation)
    {
        allocations.append(allocation)
    }
    
    func freeResource (allocatedResource : Allocation)
    {
        allocatedResource.freeResource()
    }
    
    func getResources<T where T:Resource> (type : T.Type, onlyCurrent : Bool = false) -> [Allocation]
    {
        var requestedAllocations : [Allocation] = []
        for allocation in allocations
        {
            if (allocation.resource is T)
            {
                if (!onlyCurrent || allocation.isCurrent)
                {
                    requestedAllocations.append(allocation)
                }
            }
        }
        return requestedAllocations
    }
    
    func getBudget () -> Int
    {
        var budget : Int = 0
        for allocation : Allocation in allocations
        {
            if (allocation.resource is FinancialResource && allocation.isCurrent)
            {
                budget += allocation.amount!
            }
        }
        return budget
    }
    
    func getHumanResourcesCount() -> Int
    {
        return getResources(HumanResource.self, onlyCurrent: true).count
    }
    
    
    func checkRequirements ()
    {
        var toBeRemoved : [Requirement] = []
        for requirement in requirements
        {
            if (requirement.tryRequirement())
            {
                toBeRemoved.append(requirement)
            }
        }
        for requirement in toBeRemoved
        {
            myEntity?.managedObjectContext?.deleteObject(requirement.myEntity!)
            do{ try myEntity?.managedObjectContext?.save() } catch {fatalError("failed to save context")}
            requirements.removeAtIndex(requirements.indexOf(requirement)!)   
        }
    }
    
    func getIsFinished () -> Bool
    {
        return endDate != nil
    }
    
    
    func endProject ()
    {
        if (getIsFinished())
        {
            return
        }
        endDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        requirements.removeAll()
        for product in products
        {
            product.produce()
        }
        for allocation in allocations
        {
            if (allocation.isCurrent)
            {
                allocation.freeResource()
            }
        }
        for subProject in subProjects
        {
            subProject.endProject()
        }
        let projectEntity = myEntity as! ProjectEntity
        projectEntity.endDate = endDate as? String
        projectEntity.requirements = nil
        do {
            try projectEntity.managedObjectContext?.save()
        }
        catch {
            fatalError("failerd to endProject")
        }
    }
}
