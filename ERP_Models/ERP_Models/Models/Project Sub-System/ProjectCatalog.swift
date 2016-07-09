//
//  ProjectCatalog.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ProjectCatalog: NSObject {
    private var projects : Array<Project>
    private static var instance : ProjectCatalog!
    var categories: Array<String>
    private var categoriesEntities: Array<ProjectCategoriesEntity>
    
    
    private override init ()
    {
        projects = Array<Project>()
        categories = []
        categoriesEntities = []
        super.init()
    }
    
    static func getInstance () -> ProjectCatalog
    {
        if (instance == nil)
        {
            instance = ProjectCatalog ()
            instance!.fetchProjectsFromDatabase()
        }
        return instance
    }
    
    func getProjects () -> [Project]
    {
        return projects as [Project]
    }
    
    func getProjectByName (projectName: NSString) -> Project?
    {
        for project in projects
        {
            if (project.projectName == projectName)
            {
                return project
            }
        }
        return nil
    }
    
    func addCategory (newCategory : String)
    {
        categories.append(newCategory)
        categoriesEntities.append(ProjectCategoriesEntity.addCategory(newCategory) as! ProjectCategoriesEntity)
    }
    
    func removeCategory (category : String) -> Bool
    {
        if let index : Int = categories.indexOf(category)
        {
            categories.removeAtIndex(index)
            let categoriesEntityToRemove = getCategoriesEntity(category)
            ProjectCategoriesEntity.removeCategory(categoriesEntityToRemove!)
            categoriesEntities.removeAtIndex(categoriesEntities.indexOf(categoriesEntityToRemove!)!)
            return true
        }
        return false
    }
    
    func getCategoriesEntity (categoryTitle: NSString) -> ProjectCategoriesEntity?
    {
        for cat in categoriesEntities
        {
            if (cat.category == categoryTitle)
            {
                return cat
            }
        }
        return nil
    }
    
    func addProject (withName name : NSString, category: NSString, describedAs description: NSString?, budgetLimit : Int?, humanResourceLimit : Int?, isManagedBy manager : User?, entity: ProjectEntity?) -> Project
    {
        let newProject = Project (isProjectRoot: true, withName : name, category: category, description: description,  budgetLimitIs: budgetLimit, humanResourceLimitIs: humanResourceLimit, isManagedBy : manager, entity: entity)
        projects.append(newProject)
        return newProject
    }
    
    func fetchProjectsFromDatabase ()
    {
        let projectFetch = NSFetchRequest (entityName: "Project")
        let projectCategoriesFetch = NSFetchRequest(entityName: "ProjectCategories")
        let moc = DataController.getInstance().managedObjectContext
        do
        {
            let projectEntities = try moc.executeFetchRequest(projectFetch) as! [ProjectEntity]
            categoriesEntities = try moc.executeFetchRequest(projectCategoriesFetch) as! [ProjectCategoriesEntity]
            for projectCategoriesEntity in categoriesEntities
            {
                categories.append(projectCategoriesEntity.category!)
            }
            for projectEntity in projectEntities
            {
                if (projectEntity.isProject!.boolValue)
                {
                    let newProject = addProject(withName: projectEntity.projectName!, category: projectEntity.myCategory!.category!, describedAs: projectEntity.projectDescription, budgetLimit: (projectEntity.budgetLimit?.integerValue), humanResourceLimit: projectEntity.humanResourceLmit?.integerValue, isManagedBy: UserCatalog.getInstance().FindUser(projectEntity.manager?.username), entity: projectEntity)
                    newProject.startDate = projectEntity.startDate!
                    newProject.endDate = projectEntity.endDate
                    fetchSubProjects(newProject)
                    for subProject in newProject.subProjects
                    {
                        fetchSubProjects(subProject)
                    }
                    fetchRequirements(newProject)
                    fetchAllocations(newProject)
                    fetchProducts(newProject)
                }
            }
        }
        catch
        {
            fatalError("failed to fetch projects and categories")
        }
    }
    
    func fetchRequirements (project: Project)
    {
        if let reuiqrementEntities = (project.myEntity as! ProjectEntity).requirements
        {
            for requirementEntitySet in reuiqrementEntities
            {
                let requirementEntity = requirementEntitySet as! RequirementEntity
                let newRequirement = project.createRequirement(forResource: ResourceCatalog.getInstance().findResource(Resource.self, name: requirementEntity.myResource!.name)[0], withAmount: requirementEntity.amount?.integerValue, estimatedToBeUsed: requirementEntity.estimatedUseDuration!.integerValue, entity: requirementEntity)
                newRequirement.createdAt = requirementEntity.createdAt!
            }
        }
    }
    
    func fetchProducts (project: Project)
    {
        if let productEntities = (project.myEntity as! ProjectEntity).products
        {
            for productEntitySet in productEntities
            {
                let productEntity = productEntitySet as! ProductEntity
                var creators : [HumanResource] = []
                
                for humanResourceEntity in (productEntity.module?.creators)!
                {
                    creators.append(ResourceCatalog.getInstance().findResource(HumanResource.self, name: (humanResourceEntity as! HumanResourceEntity).name)[0])
                }
                project.createProduct(withName: (productEntity.module?.name)!, withDescription: productEntity.description, productCreatorsAre: creators, category: (productEntity.module!.category?.category)!, entity: productEntity)
                
            }
        }
    }
    
    func fetchAllocations (project : Project)
    {
        if let allocationEntities = (project.myEntity as! ProjectEntity).allocations
        {
            for allocationEntitySet in allocationEntities
            {
                let allocationEntity = allocationEntitySet as! AllocationEntity
                let resource = ResourceCatalog.getInstance().findResource(Resource.self, name: allocationEntity.myResource!.name)[0]
                if let newAllocation = resource.allocateResource(to: project, withAmount: allocationEntity.isCurrent!.boolValue ? allocationEntity.amount?.integerValue : 0,  estimatedUseDuration: (allocationEntity.estimatedUseDuration?.integerValue)!, entity: allocationEntity)
                {
                    newAllocation.isCurrent = allocationEntity.isCurrent!.boolValue
                    newAllocation.amount = allocationEntity.amount?.integerValue
                    project.allocateResource(newAllocation)
                }
                
            }
        }
    }
    
    func fetchSubProjects (project: Project)
    {
        if let subProjectEntities = (project.myEntity as! ProjectEntity).subProjects
        {
            for subProjectEntityFromSet in subProjectEntities
            {
                let subProjectEntity = subProjectEntityFromSet as! ProjectEntity
                let newSubProject = project.addSubSystem(withName: subProjectEntity.projectName!, category: subProjectEntity.myCategory!.category!, description: subProjectEntity.description, budgetLimit: subProjectEntity.budgetLimit?.integerValue, humanResourceLimit: subProjectEntity.humanResourceLmit?.integerValue, managedBy: UserCatalog.getInstance().FindUser(subProjectEntity.manager?.username), entity: subProjectEntity)
                newSubProject.startDate = subProjectEntity.startDate!
                newSubProject.endDate = subProjectEntity.endDate
                fetchProducts(newSubProject)
                fetchRequirements(newSubProject)
                fetchAllocations(newSubProject)
            }
        }
    }
}





















