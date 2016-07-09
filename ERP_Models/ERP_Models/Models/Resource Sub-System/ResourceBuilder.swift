//
//  ResourceBuilder.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/7/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ResourceBuilder: NSObject {
    
    let fetchedResources: [Resource] = []
    
    internal static func BuildResources ()
    {
        let financialResourceBuilder = FinancialResourceBuilder()
        financialResourceBuilder.fetchEntitiesFromDatabase()
        
        let physicalResourceBuilder = PhysicalResourceBuilder()
        physicalResourceBuilder.fetchEntitiesFromDatabase()
        
        let humanResourceBuilder = HumanResourceBuilder()
        humanResourceBuilder.fetchEntitiesFromDatabase()
        
        let moduleBuilder = ModuleBuilder()
        moduleBuilder.fetchEntitiesFromDatabase()
    }
    
    
    internal func fetchEntitiesFromDatabase ()
    {
        let moc = DataController.getInstance().managedObjectContext
        let resourceFetch = NSFetchRequest (entityName: getResourceType().0)
        let resourceCategoryFetch = NSFetchRequest(entityName: getResourceType().0 + "Categories")

        do
        {
            let newResourceEntities = try moc.executeFetchRequest(resourceFetch) as! [ResourceEntity]
            let resourceCategories = try moc.executeFetchRequest(resourceCategoryFetch) as! [CategoriesEntity]
            for cat in resourceCategories
            {
                ResourceCatalog.getInstance().categories[getResourceType().1]?.append(cat.category!)
                ResourceCatalog.getInstance().categoriesEntities[getResourceType().1]?.append(cat)
            }
            for resourceEntity in newResourceEntities
            {
                var newResource : Resource? = createResource(resourceEntity)
                setupResourceFromEntity(&newResource, resourceEntity: resourceEntity)
                if (newResource != nil)
                {
                    ResourceCatalog.getInstance().addResource(newResource!)
                }
            }
        }
        catch
        {
            print (error)
            fatalError("failed to fetch resources from database")
        }
    }
    
    
    
    private func setupResourceFromEntity (inout resource : Resource?, resourceEntity : ResourceEntity)
    {
        resource?.dateAdded = resourceEntity.dateAdded!
    }
    
    
    func createResource (resourceEntity : ResourceEntity) -> Resource?
    {
        preconditionFailure("this method must be overriden")
    }
    
    func getResourceType () -> (String, String)
    {
        preconditionFailure("this method must be overriden")
    }
    
    class ModuleBuilder: ResourceBuilder
    {
        override func createResource(resourceEntity: ResourceEntity) -> Resource?
        {
            let module = resourceEntity as! ModuleEntity
            if (module.product != nil)
            {
                return nil
            }
            let maintenanceFetch = NSFetchRequest(entityName: "Maintenance")
            let humanResources = ResourceCatalog.getInstance().findResource(HumanResource.self) 
            let moc = DataController.getInstance().managedObjectContext
            do
            {
                
                let newResource = Module (moduleName: module.name!, withDescription: module.description, moduleCreators: [], category: module.category!.category!, entity: module)
                for humanResource in humanResources
                {
                    for creatorEntity in module.creators!
                    {
                        if (creatorEntity.name == humanResource.name)
                        {
                            newResource.creators.append(humanResource)
                        }
                    }
                }
                let maintenanceEntities = try moc.executeFetchRequest(maintenanceFetch) as! [MaintenanceEntity]
                for maintenanceEntity in maintenanceEntities
                {
                    if (maintenanceEntity.myModule!.name == module.name)
                    {
                        let newMaintenance = Maintenance(title: maintenanceEntity.title!, maintainersAre: [], descriptionIs: maintenanceEntity.describe!, modificationDateIs: maintenanceEntity.modificationDate!, entity: maintenanceEntity)
                        newResource.maintenances.append(newMaintenance)
                        for humanResource in humanResources
                        {
                            for maintainer in maintenanceEntity.maintainers!
                            {
                                if (maintainer.name == humanResource.name)
                                {
                                    newMaintenance.maintainers.append(humanResource)
                                }
                            }
                        }
                    }
                }
                return newResource
            }
            catch
            {
                print (error)
                fatalError("Failed to fetch maintenances")
            }
        }
        
        override func getResourceType () -> (String, String)
        {
            return ("Module", String(Module))
        }
    }
    
    class HumanResourceBuilder: ResourceBuilder
    {
        override func createResource(resourceEntity: ResourceEntity) -> Resource
        {
            let humanEntity = resourceEntity as! HumanResourceEntity
            let newHumanResource = HumanResource(name: humanEntity.name!, totalAmount: humanEntity.totalAmount as! Int, category: humanEntity.myCategory!.category!, entity: humanEntity)
            //newHumanResource.allocatedAmount = (humanEntity.allocatedAmount! as Int)
            return newHumanResource
        }
        
        override func getResourceType () -> (String, String)
        {
            return ("HumanResource", String(HumanResource))
        }
    }
    
    class FinancialResourceBuilder: ResourceBuilder
    {
        override func createResource(resourceEntity: ResourceEntity) -> Resource
        {
            let financialEntity = resourceEntity as! FinancialResourceEntity
            let newFinancialResource = FinancialResource(name: resourceEntity.name!, totalAmount: financialEntity.totalAmount as! Int, category: financialEntity.myCategory!.category!, entity: financialEntity)
            //newFinancialResource.allocatedAmount = (financialEntity.allocatedAmount! as Int)
            return newFinancialResource
        }
        
        override func getResourceType() -> (String, String)
        {
            return ("FinancialResource", String(FinancialResource))
        }
    }
    
    class PhysicalResourceBuilder: ResourceBuilder
    {
        override func createResource(resourceEntity: ResourceEntity) -> Resource
        {
            let physicalEntity = resourceEntity as! PhysicalResourceEntity
            let newPhysicalResource = PhysicalResource(category: physicalEntity.myCategory!.category!, name: physicalEntity.name!, physicalResourceCode: physicalEntity.resourceCode!, roomNumber: physicalEntity.roomNumber as! Int, entity: physicalEntity)
            return newPhysicalResource
        }
        
        override func getResourceType() -> (String, String)
        {
            return ("PhysicalResource", String(PhysicalResource))
        }
        
    }
}
