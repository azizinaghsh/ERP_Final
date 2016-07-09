//
//  AddProjectViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/18/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class AddProjectViewController: NSViewController {

    @IBOutlet weak var newProjectName: NSTextField!
    
    @IBOutlet weak var newProjectBudget: NSTextField!
    
    @IBOutlet weak var newProjectHumanResource: NSTextField!
    
    @IBOutlet weak var newProjectManager: NSPopUpButton!
    
    @IBOutlet weak var newCategoryButton: NSPopUpButton!
    
    @IBOutlet weak var newProjectCategory: NSTextField!
    
    @IBOutlet weak var descriptionInput: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let categories = ProjectCatalog.getInstance().categories
        for cat in categories{
            newCategoryButton.addItemWithTitle(cat)
        }
        let users = UserCatalog.getInstance().getSampleUsers()
        for user in users{
            newProjectManager.addItemWithTitle(user.username as String)
        }
        
    }
    
    @IBAction func removeCategory(sender: AnyObject) {
        let newCategory = newProjectCategory.stringValue
        if ProjectCatalog.getInstance().categories.indexOf(newCategory) != nil {
            ProjectCatalog.getInstance().removeCategory(newCategory)
            newCategoryButton.removeItemWithTitle(newCategory)
            newProjectCategory.stringValue = ""
        }
    }
    @IBAction func addCategory(sender: AnyObject) {
        let newCategory = newProjectCategory.stringValue
        if newCategory != "" {
            ProjectCatalog.getInstance().addCategory(newCategory)
            newCategoryButton.addItemWithTitle(newCategory)
            newProjectCategory.stringValue = ""
        }
    }
    @IBAction func saveProject(sender: AnyObject) {
        let name = newProjectName.stringValue
        let budget = newProjectBudget.integerValue
        let humanResource = newProjectHumanResource.integerValue
    
        let manager = newProjectManager.selectedItem?.title
        
        let user = UserCatalog.getInstance().FindUser(manager!)
        
        ProjectCatalog.getInstance().addProject(withName: name, category: (newCategoryButton.selectedItem?.title)!, describedAs: descriptionInput.stringValue, budgetLimit: budget, humanResourceLimit: humanResource, isManagedBy: user, entity: nil)
        dismissViewController(self)
        
    }
}
